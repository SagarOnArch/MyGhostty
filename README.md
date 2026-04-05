<div align="center">

# 👻 MyGhostty

### _A blazing-fast Ghostty installer & configuration toolkit for Linux_

<br/>

![Version](https://img.shields.io/github/v/release/devSagarSardar/MyGhostty?style=for-the-badge&color=7c3aed&labelColor=0f0f12)
![License](https://img.shields.io/github/license/devSagarSardar/MyGhostty?style=for-the-badge&color=06b6d4&labelColor=0f0f12)
![Stars](https://img.shields.io/github/stars/devSagarSardar/MyGhostty?style=for-the-badge&color=f59e0b&labelColor=0f0f12)
[![Sponsor](https://img.shields.io/badge/❤️_Sponsor-GitHub-%23EA4AAA?style=for-the-badge&logo=githubsponsors&labelColor=0f0f12)](https://github.com/sponsors/devSagarSardar)

<br/>

![Ghostty Preview](assets/preview.png)

</div>

---

## ✨ What is MyGhostty?

**MyGhostty** is a smart, interactive installer that sets up [Ghostty](https://ghostty.org/) — the fast, feature-rich terminal — with a hand-crafted configuration, themes, and shell integration across all major Linux distributions. Zero manual config needed.

---

## Recommended ⚡ Quick Install Command for Beginners

```sh

```
## Advanced Install Command for Experts

```sh

```

The installer interactively walks you through everything. You can also run it unattended using CLI parameters:
- `--yes` or `-y`: Auto-accept all prompts.
- `--minimal` or `-m`: Skip downloading and installing the Matugen theme.


| Step | What It Does |
|------|-------------|
| 👻 **Ghostty** | Installs if not already present |
| 🔤 **JetBrainsMono Nerd Font** | Installed automatically as a dependency |
| ⚙️ **Configuration** | Applies the MyGhostty config (auto-backs up existing) |
| 🎨 **Theme** | Installs the `ml4w-matugen` theme |
| 🐚 **Shell Integration** | Auto-detected — bash / zsh / fish |
| 🖥️ **Default Terminal** | Optionally sets Ghostty as your system default |
| 🔄 **`myghostty-update`** | Installed to `~/.local/bin` for future updates |

---

## 🔄 Keeping Up to Date

After the initial install, a global `myghostty-update` command is available. Run it anytime to pull the latest changes:

```sh
myghostty-update
```

This will:
1. Pull the latest version from the repository
2. Back up your existing `config` and `config.d` (timestamped `.bak` folders)
3. Apply the updated configuration and modular `config.d` components
4. Update the `ml4w-matugen` theme (if installed and not restricted by minimal mode)
5. Re-apply your shell integration setting

---

## 📁 Modular Configuration (`config.d`)

MyGhostty uses a modular `.conf` file approach to keep settings organized instead of a single massive config file. Everything is housed inside `$HOME/.config/ghostty/config.d/`:

- **`core.conf`**: Houses core terminal setup and shell integration.
- **`fonts.conf`**: Manages typeface, sizing, and ligatures.
- **`keybindings.conf`**: Custom hotkeys and shortcuts.
- **`appearance.conf`**: Padding, opacity, window snapping, blur, etc.
- **`theme.conf`**: Holds the selected color theme.
- **`custom.conf`**: Your personal sandbox. Add any custom configurations or overrides here safely.

> [!TIP]
> If you wish to change settings, add them to `config.d/custom.conf`! This ensures your custom overrides won't conflict with MyGhostty's base structures during updates.

---

## ⌨️ Custom Keybindings

MyGhostty comes with some intuitive keybindings configured out of the box in `config.d/keybindings.conf`:

| Shortcut | Action |
|----------|--------|
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>c</kbd> | Copy to clipboard |
| <kbd>Ctrl</kbd> + <kbd>g</kbd> > <kbd>g</kbd> | Scroll to top (Vim style) |
| <kbd>Shift</kbd> + <kbd>g</kbd> > <kbd>g</kbd> | Scroll to bottom (Vim style) |

> [!TIP]
> You can add your own keybindings by editing `$HOME/.config/ghostty/config.d/keybindings.conf`.

> [!NOTE]
> If `~/.local/bin` is not on your `$PATH`, the installer will print the `export` line to add to your shell config (e.g. `~/.bashrc` or `~/.zshrc`).

---

## 🚀 Features

- ⚡ Automated interactive Ghostty installation
- 🔤 JetBrainsMono Nerd Font bundled as a dependency
- ⚙️ Custom Ghostty configuration with automatic backup
- 🎨 Matugen theme support out of the box
- 🐚 Automatic shell detection (bash / zsh / fish)
- 🖥️ Optional default terminal setup
- 🔄 `myghostty-update` command for seamless future updates

---

## 🐧 Supported Distributions

| Distribution | Package Manager |
|---|:---:|
| Arch Linux | `pacman` |
| Fedora | `dnf` |
| openSUSE | `zypper` |
| Debian / Ubuntu | `apt` |

> [!TIP]
> For other distributions, install Ghostty manually via the [official guide](https://ghostty.org/docs/install/binary), then re-run the installer to apply the configuration and theme.

> [!IMPORTANT]
> MyGhostty requires **JetBrainsMono Nerd Font** to be installed on your system. To install it manually, see the [official JetBrains repository](https://github.com/JetBrains/JetBrainsMono).

---

## 🙏 Acknowledgements & Credits

Thanks to the developers of these amazing projects:

- [ghostty-org/ghostty](https://github.com/ghostty-org/ghostty) — the terminal itself
- [mylinuxforwork](https://github.com/mylinuxforwork) — theme and configuration inspiration
- [JetBrains/JetBrainsMono](https://github.com/JetBrains/JetBrainsMono) — the beautiful font

---

## 🤝 Contributions & Support

Contributions, suggestions, and improvements are welcome!

Feel free to **open issues** or **submit pull requests**. If you find this project useful, consider supporting development:

<div align="center">

[![❤️ GitHub Sponsors](https://img.shields.io/badge/❤️_Sponsor_MyGhostty-GitHub-%23EA4AAA?style=for-the-badge&logo=githubsponsors&labelColor=0f0f12)](https://github.com/sponsors/devSagarSardar)

</div>
