
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
- Automatic dependencies bumping with [dependabot](https://docs.github.com/en/code-security/dependabot/working-with-dependabot) and [renovate](https://docs.renovatebot.com/) for Godot and addons
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

## Contributing

![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)

We welcome community contributions to this project.

Please read our [Contributor Guide](CONTRIBUTING.md) for more information on how to get started.
