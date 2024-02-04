#!/usr/bin/env -S just --justfile

# === Settings ===

set dotenv-load := true


# === Aliases ===

[private]
alias g := godot

[private]
alias e := editor

# === Variables ===

# Global directories
# To make the Godot binaries available for other projects
home_dir := env_var('HOME')
main_dir := home_dir / ".mkflower"
cache_dir := main_dir / "cache"
bin_dir := main_dir / "bin"

# Local directories
build_dir := justfile_directory() / "build"
dist_dir := justfile_directory() / "dist"

# Godot variables
godot_version := env_var('GODOT_VERSION')
godot_platform := if arch() == "x86" {
 "linux.x86_32"
} else {
  if arch() == "x86_64" {
    "linux.x86_64"
  } else {
    if arch() == "arm" {
      "linux.arm32"
    } else {
      if arch() == "aarch64" {
        "linux.arm64"
      } else { "" }
    }
  }
}
godot_filename := "Godot_v" + godot_version + "_" + godot_platform
godot_template := "Godot_v" + godot_version + "_export_templates.tpz"
godot_bin := bin_dir / godot_filename
godot_editor_data_dir := "~/.local/share/godot"
godot_templates_dir := godot_editor_data_dir / "export_templates" / replace_regex(godot_version, "([^-]+)-([^-]+)", "$1.$2")

# Game variables
game_name := env_var('GAME_NAME')
game_version := env_var('GAME_VERSION')
game_itchio_key := env_var_or_default('GAME_ITCHIO_KEY', "")

# Build info
datetime := `date '+%Y%m%d'`
short_version := replace_regex(game_version, "([0-9]+).([0-9]+).[0-9]+", "$1.$2")
commit_hash := `git log --pretty=format:"%H" -1`

# Python virtualenv
venv_dir := justfile_directory() / "venv"

# Butler binary
butler_bin := bin_dir / "butler"
butler_platform := if arch() == "x86" { "linux-386" } else { if arch() == "x86_64" { "linux-amd64" } else{ "" } }

# === Commands ===

# Display all commands
@default:
    echo "OS: {{ os() }} - ARCH: {{ arch() }}\n"
    just --list

# Create directories
[private]
@makedirs:
    mkdir -p {{ cache_dir }} {{ bin_dir }} {{ build_dir }} {{ dist_dir }}

# === Installer ===
#
# Recipes that check and/or install some binaries like Godot, Bulter ...
# This means the user doesn't have to worry about installation,
# and can be sure that the same code is running in CI and locally.

# Download Godot
[private]
install-godot: makedirs
    curl -L --silent -X GET "https://github.com/godotengine/godot-builds/releases/download/{{ godot_version }}/{{ godot_filename }}.zip" --output {{ cache_dir }}/{{ godot_filename }}.zip
    unzip -o {{ cache_dir }}/{{ godot_filename }}.zip -d {{ cache_dir }}
    cp {{ cache_dir }}/{{ godot_filename }} {{ godot_bin }}

# Download Godot if not already done
[private]
@check-godot:
    [ ! -e {{ godot_bin }} ] && just install-godot || true

# Download Godot export templates
[private]
install-templates: makedirs
    curl -L --silent -X GET "https://github.com/godotengine/godot-builds/releases/download/{{ godot_version }}/{{ godot_template }}" --output {{ cache_dir }}/{{ godot_template }}
    unzip -o {{ cache_dir }}/{{ godot_template }} -d {{ cache_dir }}
    mkdir -p {{ godot_templates_dir }}
    cp {{ cache_dir }}/templates/* {{ godot_templates_dir }}

# Download Godot export templates if not already done
[private]
@check-templates:
    [ ! -d {{ godot_templates_dir }} ] && just install-templates || true

# Download Butler
[private]
install-butler: makedirs
    curl -L --silent -X GET "https://broth.itch.ovh/butler/{{ butler_platform }}/LATEST/archive/default" --output {{ cache_dir }}/butler.zip
    unzip -o {{ cache_dir }}/butler.zip -d {{ cache_dir }}
    mv {{ cache_dir }}/butler {{ butler_bin }}
    chmod +x {{ butler_bin }}

# Download Butler if not already done
[private]
@check-butler:
    [ ! -e {{ butler_bin }} ] && just install-butler || true

# === Python ===
#
# Recipes that use python or python packages.
# This ensures that all python packages are installed in a virtual environment.

export PIP_REQUIRE_VIRTUALENV := "true"

# Python virtualenv wrapper
[private]
@venv *ARGS:
    [ ! -d {{ venv_dir }} ] && python3 -m venv {{ venv_dir }} || true
    . {{ venv_dir }}/bin/activate && {{ ARGS }}

# Run files formatters
fmt:
    just venv pip install pre-commit==3.*
    just venv pre-commit run -a

# Generate the CREDTIS.md file
credits:
    just venv python ./generate_credits.py

# === Godot ===
#
# Recipes around the Godot binary.
# This simplifies some recurring tasks, such as installing addons.

# Godot binary wrapper
godot *ARGS: check-godot check-templates
    {{ godot_bin }} {{ ARGS }}

# Download game plugins
@install-addons:
    [ -f plug.gd ] && just godot --headless --script plug.gd install force || true

# Workaround from https://github.com/godotengine/godot/pull/68461
# Import game resources
@import-resources:
    just godot --headless --export-pack null /dev/null
    # timeout 60 just godot --editor || true
    # just godot --headless --quit --editor

# Open the Godot editor
@editor:
    just godot --editor

# === Butler ===

# Bulter wrapper
butler *ARGS: check-butler
    {{ butler_bin }} {{ ARGS }}

# === Export ===

# Updates the game version for export
@bump-version:
    echo "Update version in the presets.cfg"
    sed -i "s,application/file_version=.*$,application/file_version=\"{{ game_version }}.{{ datetime }}\",g" ./export_presets.cfg
    sed -i "s,application/product_version=.*$,application/product_version=\"{{ game_version }}.{{ datetime }}\",g" ./export_presets.cfg
    sed -i "s,application/version=.*$,application/version=\"{{ game_version }}\",g" ./export_presets.cfg
    sed -i "s,application/short_version=.*$,application/short_version=\"{{ short_version }}\",g" ./export_presets.cfg

    echo "Update version in the project.godot"
    sed -i "s,config/version=.*$,config/version=\"{{ game_version }}\",g" ./project.godot

[private]
pre-export: clean-addons makedirs bump-version install-addons import-resources

# Export game on Windows
export-windows: pre-export
    mkdir -p {{ build_dir }}/windows
    just godot --headless --export-release '"Windows Desktop"' {{ build_dir }}/windows/{{ game_name }}.exe
    (cd {{ build_dir }}/windows && zip {{ game_name }}-windows-v{{ game_version }}.zip -r .)
    mv {{ build_dir }}/windows/{{ game_name }}-windows-v{{ game_version }}.zip {{ dist_dir }}/{{ game_name }}-windows-v{{ game_version }}.zip
    rm -rf {{ build_dir }}/windows

# Export game on MacOS
export-mac: pre-export
    just godot --headless --export-release "macOS" {{ dist_dir }}/{{ game_name }}-mac-v{{ game_version }}.zip

# Export game on Linux
export-linux: pre-export
    mkdir -p {{ build_dir }}/linux
    just godot --headless --export-release "Linux/X11" {{ build_dir }}/linux/{{ game_name }}.x86_64
    (cd {{ build_dir }}/linux && zip {{ game_name }}-linux-v{{ game_version }}.zip -r .)
    mv {{ build_dir }}/linux/{{ game_name }}-linux-v{{ game_version }}.zip {{ dist_dir }}/{{ game_name }}-linux-v{{ game_version }}.zip
    rm -rf {{ build_dir }}/linux

# Export game for the web
export-web: pre-export
    mkdir -p {{ build_dir }}/web
    just godot --headless --export-release "Web" {{ build_dir }}/web/index.html

# Export on all platform
export: export-windows export-mac export-linux

# === Clean ===
#
# Recipes that clean up the project, deleting
# files and folders created by this Justfile.

# Remove game plugins
clean-addons:
    rm -rf .plugged
    [ -f plug.gd ] && (cd addons/ && git clean -X -d) || true

# Remove files created by Godot
clean-resources:
    rm -rf .godot

# Remove files created during the export
clean-export:
    rm -rf {{ build_dir }} {{ dist_dir }}

# Remove any unnecessary files
clean: clean-addons clean-resources clean-export

# === CI ===
#
# Recipes launched by CI steps.
# They can be run locally, but requires the setup of some environment variables.

# Add some variables to Github env
ci-load-dotenv:
    echo "godot_version={{ godot_version }}" >> $GITHUB_ENV
    echo "game_name={{ game_name }}" >> $GITHUB_ENV
    echo "game_version={{ game_version }}" >> $GITHUB_ENV

# Upload the game on Github and Itch.io
ci-publish:
    gh release create "{{ game_version }}" --title="v{{ game_version }}" --generate-notes {{ dist_dir }}/*
    just butler push {{ dist_dir }}/{{ game_name }}-windows-v{{ game_version }}.zip mechanical-flower/{{ game_itchio_key }}:windows --userversion {{ game_version }}
    just butler push {{ dist_dir }}/{{ game_name }}-mac-v{{ game_version }}.zip mechanical-flower/{{ game_itchio_key }}:mac --userversion {{ game_version }}
    just butler push {{ dist_dir }}/{{ game_name }}-linux-v{{ game_version }}.zip mechanical-flower/{{ game_itchio_key }}:linux --userversion {{ game_version }}
