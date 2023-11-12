# `.devcontainer` Config

This directory houses a set of Dev Container config files, which streamline contributions from team and community members.

## Developing in the Browser using Codespaces

GitHub Codespaces allows maintainers and contributors to launch directly into a web browser window that hosts the VS Code IDE.

## Container Prebuild Optimizations

Prebuilds of these dev containers can significantly speed up launch times.

## Sharing Codespace Links

Per the [GitHub Docs](https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/setting-up-your-repository/facilitating-quick-creation-and-resumption-of-codespaces#creating-a-link-to-the-codespace-creation-page-for-your-repository), you can:

- Create a codespace for the default branch:
  - [`https://codespaces.new/airbytehq/quickstarts`](https://codespaces.new/airbytehq/airbyte)
- Create a codespace for a specific branch of the repository:
  - `https://codespaces.new/airbytehq/quickstarts/tree/BRANCH-NAME`
  - `https://codespaces.new/FORK-NAME/quickstarts/tree/BRANCH-NAME`
  - E.g. https://codespaces.new/aaronsteers/quickstarts/tree/aj%2Ffeat%2Fdevcontainers
- Create a codespace for a pull request:
  - https://codespaces.new/airbytehq/quickstarts/pull/PR-SHA
