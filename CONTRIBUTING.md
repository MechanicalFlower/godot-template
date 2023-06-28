<!--
SPDX-FileCopyrightText: 2023 Florian Vazelle <florian.vazelle@vivaldi.net>

SPDX-License-Identifier: MIT
-->

# Contributing

We welcome contributions to our open source Godot game project! There are many ways you can help, including reporting bugs, improving documentation, and contributing code.

## Code of Conduct

We value the participation of every member of our community and want to ensure that everyone has an enjoyable and fulfilling experience. As such, we have adopted the [Contributor Covenant](https://www.contributor-covenant.org/) as our code of conduct. By participating in this project, you agree to abide by its terms.

## Prerequisites

Before you start, you will need the following:

- A GitHub account
- A copy of the Godot game engine installed on your computer
- Familiarity with Git and GitHub

## Contributing Code

To contribute code to the project, follow these steps:

1. Fork the repository to your own GitHub account.
2. Clone the repository to your local machine.
3. Create a new branch for your changes.
4. Make your changes and commit them to your local repository.
5. Push your changes to your forked repository on GitHub.
6. Create a pull request from your forked repository to the original repository.

Please note that all code contributions should pass the continuous integration (CI) checks that are set up for the project. These checks ensure that the code is well-formatted and that tests are passing.

## Pre-commit Requirements

To ensure that your code passes the CI checks, you should run the following pre-commit checks before committing and pushing your changes:

- Run the code formatter to ensure that your code is properly formatted according to the project's style guidelines.
- Run the test suite to ensure that all tests are passing.

You can set up pre-commit hooks to automatically run these checks before you commit your changes. To do this, you will need to install the following tools:

- The `pre-commit` Python package: This package contains a set of tools for running checks on your code before committing it. You can install it using `pip install pre-commit`.
- The `godot-gdscript-toolkit`: This toolkit contains a set of tools for formatting and linting GDScript code. You can install it using `pip install 'gdtoolkit==3.*'`.

Then, run `pre-commit install` to set up the hooks.

Alternatively, you can run `pre-commit run --all-files` to manually run all the checks on your code before committing. This can save you time and ensure that your code is ready to be merged into the main repository.

## Reporting Bugs

If you find a bug in the project, please report it by creating an issue in the repository's issue tracker. Be sure to include as much information as possible, including the steps to reproduce the bug and any relevant error messages.

## Improving Documentation

If you would like to improve the documentation for the project, you can do so by submitting a pull request with your changes. Please follow the same process as for contributing code, and make sure that your changes are properly formatted and well-written.

## Questions and Feedback

If you have any questions or feedback about the project, don't hesitate to reach out! You can create an issue in the repository's issue tracker, or contact us directly through our website or social media channels.

Thank you for considering contributing to our open source Godot game project! We appreciate your help and look forward to working with you.
