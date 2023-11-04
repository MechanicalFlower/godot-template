#!/usr/bin/env -S just --justfile

set dotenv-load := true

export PIP_REQUIRE_VIRTUALENV := "true"

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
godot_platform := if arch() == "x86" { "linux.x86_32" } else { if arch() == "x86_64" { "linux.x86_64" } else { "" } }
godot_filename := "Godot_v" + godot_version + "-stable_" + godot_platform
godot_template := "Godot_v" + godot_version + "-stable_export_templates.tpz"
godot_bin := bin_dir / godot_filename
godot_editor_data_dir := "~/.local/share/godot/"

# Game variables
game_name := env_var('GAME_NAME')
game_version := env_var('GAME_VERSION')
game_itchio_key := env_var_or_default('GAME_ITCHIO_KEY', "")

# Build info
datetime := `date '+%Y%m%d'`
short_version := replace_regex(game_version, "([0-9]+).([0-9]+).[0-9]+", "$1.$2")
build_date := `date +'%Y/%m/%d'`
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

# Python virtualenv wrapper
[private]
@venv *ARGS:
    [ ! -d {{ venv_dir }} ] && python3 -m venv {{ venv_dir }} || true
    . {{ venv_dir }}/bin/activate && {{ ARGS }}

# Download Godot
[private]
install-godot:
    #!/usr/bin/env sh
    if [ ! -e {{ godot_bin }} ]
    then
        curl -X GET "https://downloads.tuxfamily.org/godotengine/{{ godot_version }}/{{ godot_filename }}.zip" --output {{ cache_dir }}/{{ godot_filename }}.zip
        unzip {{ cache_dir }}/{{ godot_filename }}.zip -d {{ cache_dir }}
        cp {{ cache_dir }}/{{ godot_filename }} {{ godot_bin }}
    fi

# Download Godot export templates
[private]
install-templates:
    #!/usr/bin/env sh
    if [ ! -d {{ godot_editor_data_dir }}/export_templates/{{ godot_version }}.stable ]
    then
        curl -X GET "https://downloads.tuxfamily.org/godotengine/{{ godot_version }}/{{ godot_template }}" --output {{ cache_dir }}/{{ godot_template }}
        unzip {{ cache_dir }}/{{ godot_template }} -d {{ cache_dir }}
        mkdir -p {{ godot_editor_data_dir }}/export_templates/{{ godot_version }}.stable
        cp {{ cache_dir }}/templates/* {{ godot_editor_data_dir }}/export_templates/{{ godot_version }}.stable
    fi

# Download game plugins
install-addons:
    [ -f plug.gd ] && just godot --headless --script plug.gd install || true

# Workaround from https://github.com/godotengine/godot/pull/68461
# Import game resources
import-resources:
    just godot --headless --export-pack null /dev/null
    # timeout 60 just godot --editor || true
    # just godot --headless --quit --editor

# Updates the game version for export
@bump-version:
    echo "Update version in the presets.cfg"
    sed -i "s,application/file_version=.*$,application/file_version=\"{{ game_version }}.{{ datetime }}\",g" ./export_presets.cfg
    sed -i "s,application/product_version=.*$,application/product_version=\"{{ game_version }}.{{ datetime }}\",g" ./export_presets.cfg
    sed -i "s,application/version=.*$,application/version=\"{{ game_version }}\",g" ./export_presets.cfg
    sed -i "s,application/short_version=.*$,application/short_version=\"{{ short_version }}\",g" ./export_presets.cfg

    echo "Create the override.cfg"
    touch override.cfg
    echo -e "[build_info]\npackage/version={{ game_version }}\npackage/build_date={{ build_date }}\nsource/commit={{ commit_hash }}" > override.cfg

# Godot binary wrapper
@godot *ARGS: makedirs install-godot install-templates
    {{ godot_bin }} {{ ARGS }}

# Open the Godot editor
editor:
    just godot --editor

# Run files formatters
fmt:
    just venv pip install pre-commit==3.3.3 reuse==2.1.0 gdtoolkit==4.*
    just venv pre-commit run -a

# Export game on Windows
export-windows: bump-version install-addons import-resources
    mkdir -p {{ build_dir }}/windows
    just godot --export-release '"Windows Desktop"' --headless {{ build_dir }}/windows/{{ game_name }}.exe
    (cd {{ build_dir }}/windows && zip {{ game_name }}-windows-v{{ game_version }}.zip -r .)
    mv {{ build_dir }}/windows/{{ game_name }}-windows-v{{ game_version }}.zip {{ dist_dir }}/{{ game_name }}-windows-v{{ game_version }}.zip
    rm -rf {{ build_dir }}/windows

# Export game on MacOS
export-mac: bump-version install-addons import-resources
    just godot --export-release "macOS" --headless {{ dist_dir }}/{{ game_name }}-mac-v{{ game_version }}.zip

# Export game on Linux
export-linux: bump-version install-addons import-resources
    mkdir -p {{ build_dir }}/linux
    just godot --export-release "Linux/X11" --headless {{ build_dir }}/linux/{{ game_name }}.x86_64
    (cd {{ build_dir }}/linux && zip {{ game_name }}-linux-v{{ game_version }}.zip -r .)
    mv {{ build_dir }}/linux/{{ game_name }}-linux-v{{ game_version }}.zip {{ dist_dir }}/{{ game_name }}-linux-v{{ game_version }}.zip
    rm -rf {{ build_dir }}/linux

# Export on all platform
export: export-windows export-mac export-linux

# Remove cache and binaries created by this Justfile
[private]
clean-mkflower:
    rm -rf {{ main_dir }}
    rm -rf {{ venv_dir }}

# Remove files created during the export
clean-export:
    rm -rf {{ build_dir }} {{ dist_dir }}

# Remove files created by Godot
clean-resources:
    rm -rf .godot

# Remove game plugins
clean-addons:
    rm -rf .plugged
    [ -f plug.gd ] && find addons/ -type d -not -name 'addons' -not -name 'gd-plug' -exec rm -rf {} \; || true

# Remove any unnecessary files
clean: clean-export clean-resources clean-addons

# Add some variables to Github env
ci-load-dotenv:
    echo "godot_version={{ godot_version }}" >> $GITHUB_ENV
    echo "game_name={{ game_name }}" >> $GITHUB_ENV
    echo "game_version={{ game_version }}" >> $GITHUB_ENV

# Download Butler
[private]
install-butler: makedirs
    #!/usr/bin/env sh
    if [ ! -e {{ butler_bin }} ]
    then
        curl -L -X GET "https://broth.itch.ovh/butler/{{ butler_platform }}/LATEST/archive/default" --output {{ cache_dir }}/butler.zip
        unzip {{ cache_dir }}/butler.zip -d {{ cache_dir }}
        mv {{ cache_dir }}/butler {{ butler_bin }}
        chmod +x {{ butler_bin }}
    fi

# Bulter wrapper
@butler *ARGS: install-butler
    {{ butler_bin }} {{ ARGS }}

# Upload the game on Github and Itch.io
publish:
    gh release create "{{ game_version }}" --title="v{{ game_version }}" --generate-notes {{ dist_dir }}/*
    just butler push {{ dist_dir }}/{{ game_name }}-windows-v{{ game_version }}.zip mechanical-flower/{{ game_itchio_key }}:windows --userversion {{ game_version }}
    just butler push {{ dist_dir }}/{{ game_name }}-mac-v{{ game_version }}.zip mechanical-flower/{{ game_itchio_key }}:mac --userversion {{ game_version }}
    just butler push {{ dist_dir }}/{{ game_name }}-linux-v{{ game_version }}.zip mechanical-flower/{{ game_itchio_key }}:linux --userversion {{ game_version }}
