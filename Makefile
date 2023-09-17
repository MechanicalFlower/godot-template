#############
# Variables #
#############

GODOT_VERSION := $(shell cat .godot_version)
RELEASE_NAME = stable
SUBDIR =
GODOT_PLATFORM = linux.x86_64
GODOT_FILENAME = Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}
GODOT_TEMPLATE = Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz

GAME_NAME = Greeter
GAME_VERSION := $(shell cat .version)

#############
# Commands  #
#############

mkflower:
	mkdir -p .mkflower
	mkdir -p .mkflower/build
	mkdir -p .mkflower/bin
	mkdir -p .mkflower/cache

	touch .mkflower/.gitignore
	echo '*' >> .mkflower/.gitignore

	touch .mkflower/.gdignore

install_godot: mkflower
	curl -X GET "https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}${SUBDIR}/${GODOT_FILENAME}.zip" --output .mkflower/cache/${GODOT_FILENAME}.zip; \
	unzip .mkflower/cache/${GODOT_FILENAME}.zip -d .mkflower/cache/; \
	cp .mkflower/cache/${GODOT_FILENAME} .mkflower/bin/${GODOT_FILENAME};

install_templates: mkflower
	curl -X GET "https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}${SUBDIR}/${GODOT_TEMPLATE}" --output .mkflower/cache/${GODOT_TEMPLATE}; \
	unzip .mkflower/cache/${GODOT_TEMPLATE} -d .mkflower/cache/; \
	mkdir -p ~/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME}; \
	cp .mkflower/cache/templates/* ~/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME};

install_addons:
	.mkflower/bin/${GODOT_FILENAME} --headless --script plug.gd install || true

import_resources:
	.mkflower/bin/${GODOT_FILENAME} --headless --export-pack null /dev/null
	# timeout 60 .mkflower/bin/${GODOT_FILENAME} --editor || true
	# .mkflower/bin/${GODOT_FILENAME} --headless --quit --editor

export_release_linux:
	mkdir -p .mkflower/build/linux
	.mkflower/bin/${GODOT_FILENAME} --export-release "Linux/X11" --headless .mkflower/build/linux/${GAME_NAME}.x86_64
	(cd .mkflower/build/linux && zip ${GAME_NAME}-linux-v${GAME_VERSION}.zip -r .)
	mv .mkflower/build/linux/${GAME_NAME}-linux-v${GAME_VERSION}.zip .mkflower/build/${GAME_NAME}-linux-v${GAME_VERSION}.zip

export_release_windows:
	mkdir -p .mkflower/build/windows
	.mkflower/bin/${GODOT_FILENAME} --export-release "Windows Desktop" --headless .mkflower/build/windows/${GAME_NAME}.exe
	(cd .mkflower/build/windows && zip ${GAME_NAME}-windows-v${GAME_VERSION}.zip -r .)
	mv .mkflower/build/windows/${GAME_NAME}-windows-v${GAME_VERSION}.zip .mkflower/build/${GAME_NAME}-windows-v${GAME_VERSION}.zip

export_release_mac:
	.mkflower/bin/${GODOT_FILENAME} --export-release "macOS" --headless .mkflower/build/${GAME_NAME}-mac-v${GAME_VERSION}.zip

editor:
	.mkflower/bin/${GODOT_FILENAME} --editor

godot:
	.mkflower/bin/${GODOT_FILENAME} $(ARGS)

run_release:
	.mkflower/build/linux/${GAME_NAME}.x86_64

clean_mkflower:
	rm -rf .mkflower

clean_godot:
	rm -rf .godot

clean_plug:
	rm -rf .plugged
	find addons/ -type d -not -name 'addons' -not -name 'gd-plug' -exec rm -rf {} \; || true

#############
# Playbook  #
#############

clean: clean_mkflower clean_godot clean_plug
build: clean_godot clean_plug install_addons import_resources export_release_linux
run: build run_release

export_release_all: export_release_linux export_release_mac export_release_windows
ci_build: clean install_godot install_templates install_addons import_resources export_release_all
