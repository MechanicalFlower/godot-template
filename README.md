
<div align="center">

# 📝 Greeter

![Godot Badge](https://img.shields.io/badge/godot-4.2-blue?logo=Godot-Engine&logoColor=white)
![license](https://img.shields.io/badge/license-MIT-green?logo=open-source-initiative&logoColor=white)
![reuse](./.reuse/REUSE-compliant.svg)

A template to create new [Godot Engine](https://godotengine.org/) project.

</div>

## Features

- Clean separation of assets, resources, scenes, scripts and shaders code
- Continuous integration via [GitHub Actions](https://help.github.com/en/actions/)
- Code formatting enforced by [gdformat](https://github.com/Scony/godot-gdscript-toolkit) for gdscript code, and [clang-format](https://clang.llvm.org/docs/ClangFormat.html) for shaders, via [pre-commit](https://github.com/pre-commit/pre-commit)
- Keep track of licenses and attribution by following the [reuse specification](https://reuse.software/spec/)
- Addons management with [gd-plug](https://github.com/imjp94/gd-plug)
- Automatic dependencies bumping with [renovate](https://docs.renovatebot.com/) for Godot and addons
- Command runner with [just](https://just.systems/man/en/), with a provided `Justfile` that handle tools installation, exporting, publishing ...
<!-- - Integrated test suite -->

## Usage

### Adjust the template to your needs

- Use this repo [as a template](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template).
- Replace all occurrences of "Greeter" with the name of your project
- Replace files with your own
- Happy coding!

Eventually, you can remove any unused files, such as irrelevant github workflows for your project.
Feel free to replace the License with one suited for your project.

## Installation

### From a release

Released binaries are available on Itch.io and
on the Github repository, in the release section.

Download the zip archive, accordingly to your OS, and unzip it.

- **Windows**: Double click on `Greeter.exe`.
- **MacOS**: Double click on `Greeter.app`.
- **Linux**: In a terminal, run `./Greeter.x86_64`.

<!--
### From Snap

With the [Snap command line](https://manpages.ubuntu.com/manpages/focal/en/man8/snap.8.html), run:
```
snap install godot-template
```

To run the game:
```
godot-template.greeter
```
-->

<!--
### From an AppImage

The AppImage is available on the Github
 repository, in the release section.

More details on how to run an AppImage, on the
 [official documentation](https://docs.appimage.org/introduction/quickstart.html#how-to-run-an-appimage).
-->

### From source

> [!IMPORTANT]
> For this installation, you need to have
> the Godot Editor installed.

Clone the source locally:
```
git clone https://github.com/MechanicalFlower/godot-template.git
```

You need to install addons first:
```
godot --headless --script plug.gd install
```

And simply run the game as any Godot project:
```
godot
```

## Development

The project use:
- [`just`](https://just.systems/man/en/) as command runner,
- [`pre-commit`](https://pre-commit.com/) to run formatters, this requires [Python 3](https://docs.python.org/3/).

> [!IMPORTANT]
> Actually, `just` recipes only support Linux.

To check all available recipes, run:
```
just
```

To run formatters:
```
just fmt
```

To install, and run the game:
```
just install-addons
just godot
```

> [!TIP]
> In `just` recipes, the Godot Editor is installed
> automatically. This ensure that you
> use the right version of the engine.

## Contributing

![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)

We welcome community contributions to this project.

Please read our [Contributor Guide](CONTRIBUTING.md) for more information on how to get started.

## Releasing

Please read our [Release Guide](RELEASING.md) for more information on how we manage our releases.
