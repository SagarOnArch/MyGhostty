# MyGhostty – Ghostty Installer & Configuration

![Version](https://img.shields.io/github/v/release/devSagarSardar/MyGhostty)
![License](https://img.shields.io/github/license/devSagarSardar/MyGhostty)
![Stars](https://img.shields.io/github/stars/devSagarSardar/MyGhostty)
[![❤️ GitHub Sponsors ](https://img.shields.io/badge/Sponsor-GitHub-%23EA4AAA?logo=githubsponsors)](https://github.com/sponsors/devSagarSardar)

A simple and interactive installer for Ghostty that automatically installs Ghostty, applies a customized configuration, themes, and shell integration across major Linux distributions.

The installer provides a quick and convenient way to set up a clean Ghostty environment without manual configuration.

![Ghostty Preview](assets/preview.png)

## Installation

### Quick Install

```sh
bash <(curl -s https://raw.githubusercontent.com/devSagarSardar/MyGhostty/main/install.sh)
```

The installer will interactively guide you through:

- **Ghostty** — installs if not already present
- **JetBrainsMono Nerd Font** — installed automatically as a dependency
- **Configuration** — applies the MyGhostty config (backs up any existing config)
- **Theme** — installs the `ml4w-matugen` theme
- **Shell integration** — auto-detected (bash / zsh / fish)
- **Default terminal** — optionally sets Ghostty as your system default
- **`myghostty-update` command** — installed to `~/.local/bin` for future updates

## Keeping Up to Date

After the initial install, a `myghostty-update` command is available globally. Run it anytime the repo is updated to pull the latest changes and reapply your config and theme:

```sh
myghostty-update
```

This will:
1. Pull the latest version from the repository
2. Back up your existing config (timestamped `.bak` file)
3. Apply the updated config
4. Update the `ml4w-matugen` theme (if installed)
5. Re-apply your shell integration setting

> **Note:** If `~/.local/bin` is not on your `$PATH`, the installer will print the export line to add to your shell config (e.g. `~/.bashrc` or `~/.zshrc`).

## Features

- Automated interactive Ghostty installation
- JetBrainsMono Nerd Font included as a dependency
- Custom Ghostty configuration with auto-backup
- Matugen theme support
- Automatic shell detection (bash / zsh / fish)
- Optional default terminal setup
- `myghostty-update` command for seamless future updates

### Supported Distributions

| Distribution | Package Manager |
|---|---|
| Arch Linux | `pacman` |
| Fedora | `dnf` |
| openSUSE | `zypper` |
| Debian / Ubuntu | `apt` |

For other distributions, install Ghostty manually — see the [official guide](https://ghostty.org/docs/install/binary) — then re-run the installer to apply the configuration and theme.

**Note:** MyGhostty required JetBrainsMono Nerd Font to be installed on your system. To install it manually, see the [official guide](https://github.com/JetBrains/JetBrainsMono).


## Acknowledgements & Credits

Thanks to the developers of the following projects that inspired this setup and provided the necessary resources:

- https://github.com/ghostty-org/ghostty
- https://github.com/mylinuxforwork
- https://github.com/JetBrains/JetBrainsMono

## Contributions & Support

Contributions, suggestions, and improvements are welcome.

Feel free to open issues or submit pull requests.

If you find this project useful, consider supporting development.

# MyGhostty – Ghostty Installer & Configuration

![Version](https://img.shields.io/github/v/release/devSagarSardar/MyGhostty)
![License](https://img.shields.io/github/license/devSagarSardar/MyGhostty)
![Stars](https://img.shields.io/github/stars/devSagarSardar/MyGhostty)
[![❤️ GitHub Sponsors ](https://img.shields.io/badge/Sponsor-GitHub-%23EA4AAA?logo=githubsponsors)](https://github.com/sponsors/devSagarSardar)

A simple and interactive installer for Ghostty that automatically installs Ghostty, applies a customized configuration, themes, and shell integration across major Linux distributions.

The installer provides a quick and convenient way to set up a clean Ghostty environment without manual configuration.

![Ghostty Preview](assets/preview.png)

## Installation

### Quick Install

```sh
bash <(curl -s https://raw.githubusercontent.com/devSagarSardar/MyGhostty/main/install.sh)
```

The installer will interactively guide you through:

- **Ghostty** — installs if not already present
- **JetBrainsMono Nerd Font** — installed automatically as a dependency
- **Configuration** — applies the MyGhostty config (backs up any existing config)
- **Theme** — installs the `ml4w-matugen` theme
- **Shell integration** — auto-detected (bash / zsh / fish)
- **Default terminal** — optionally sets Ghostty as your system default
- **`myghostty-update` command** — installed to `~/.local/bin` for future updates

## Keeping Up to Date

After the initial install, a `myghostty-update` command is available globally. Run it anytime the repo is updated to pull the latest changes and reapply your config and theme:

```sh
myghostty-update
```

This will:
1. Pull the latest version from the repository
2. Back up your existing config (timestamped `.bak` file)
3. Apply the updated config
4. Update the `ml4w-matugen` theme (if installed)
5. Re-apply your shell integration setting

> **Note:** If `~/.local/bin` is not on your `$PATH`, the installer will print the export line to add to your shell config (e.g. `~/.bashrc` or `~/.zshrc`).

## Features

- Automated interactive Ghostty installation
- JetBrainsMono Nerd Font included as a dependency
- Custom Ghostty configuration with auto-backup
- Matugen theme support
- Automatic shell detection (bash / zsh / fish)
- Optional default terminal setup
- `myghostty-update` command for seamless future updates

### Supported Distributions

| Distribution | Package Manager |
|---|---|
| Arch Linux | `pacman` |
| Fedora | `dnf` |
| openSUSE | `zypper` |
| Debian / Ubuntu | `apt` |

For other distributions, install Ghostty manually — see the [official guide](https://ghostty.org/docs/install/binary) — then re-run the installer to apply the configuration and theme.

**Note:** MyGhostty required JetBrainsMono Nerd Font to be installed on your system. To install it manually, see the [official guide](https://github.com/JetBrains/JetBrainsMono).


## Acknowledgements & Credits

Thanks to the developers of the following projects that inspired this setup and provided the necessary resources:

- https://github.com/ghostty-org/ghostty
- https://github.com/mylinuxforwork
- https://github.com/JetBrains/JetBrainsMono

## Contributions & Support

Contributions, suggestions, and improvements are welcome.

Feel free to open issues or submit pull requests.

If you find this project useful, consider supporting development.

[![❤️ GitHub Sponsors ](https://img.shields.io/badge/Sponsor-GitHub-%23EA4AAA?logo=githubsponsors)](https://github.com/sponsors/devSagarSardar) https://github.com/sponsors/devSagarSardar

