# Releasing

This document outlines the release policy for games within our organization.

## Versioning

We adhere to [Semantic Versioning](https://semver.org/) for our releases, following the `MAJOR.MINOR.PATCH` format.

## Branching

Our projects maintain the following active branches:
* **main**: This branch represents the next release and is where all merges take place.

## Continuous Delivery

We use [Github Actions](https://docs.github.com/en/actions) to automate the release process. When a new version is released, the CI pipeline automatically triggers a publication on the **GitHub** and **itch.io** platforms.

## Steps to release

1. Update the version in the code base
    - Update the `.env` file
        1. Change the `GAME_VERSION` variable to the new version
        2. Run the `bump-version` recipe
    - Update the `CHANGELOG.md` file
        1. Replace the `Unreleased` title with the new version
        2. Add a link for the new version at the bottom of the changelog
        3. Create a new `Unreleased` section
2. Merge the change into the `main` branch
    1. Create a branch `release-<version>` from the `main` branch
    2. Commit the changes with `"chore: bump version to <version> for release"` as message
    3. Push the branch to the remote repository
    4. Create a pull request targeting the `main` branch
    5. Review the changes in the pull request and ensure they meet the release criteria
    6. Merge the pull request into the `main` branch
3. Tag the `main` branch
    1. Tag the `main` branch with the release version
    2. Push the tags to the remote repository
