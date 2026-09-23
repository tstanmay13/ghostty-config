# ghostty-config

My personal [Ghostty](https://ghostty.org) terminal setup — theme, keybinds, and custom cursor shaders. Clone this on a new laptop to get an identical terminal in one command.

## What's here

```
dot-config-ghostty/config   →  ~/.config/ghostty/config
app-support/config          →  ~/Library/Application Support/com.mitchellh.ghostty/config
app-support/shaders/        →  ~/Library/Application Support/com.mitchellh.ghostty/shaders/
```

- **`dot-config-ghostty/config`** — minimal XDG config (Option-as-Alt, word-delete keybind). This is the file Ghostty loads by default. It also loads an optional `cmux.conf` next to it, which [cmux-config](https://github.com/tstanmay13/cmux-config) provides.
- **`app-support/config`** — the full "daily driver" config: Catppuccin Mocha theme, font size, padding, quick terminal, split navigation, copy-on-select, and the cursor-blaze shader.
- **`app-support/shaders/`** — custom GLSL shaders (`cursor_blaze.glsl` is active, `bloom.glsl` is available).

## Install on a new machine

```bash
mkdir -p ~/Documents/personal
git clone https://github.com/tstanmay13/ghostty-config.git ~/Documents/personal/ghostty-config
cd ~/Documents/personal/ghostty-config
./install.sh
```

The script symlinks the files into place and backs up existing regular files.
It runs `+validate-config` when Ghostty is installed, including when its binary
is only available inside `/Applications/Ghostty.app`. Future edits affect the
local clone; commit and push them to preserve changes on GitHub.

## Notes

- Ghostty has **no inline comments**. A `#` must start its own line — never after a value.
- Reload config after editing: `⌘ + ⇧ + ,`
- Ghostty 1.3.1 documents `config.ghostty` as a supported filename. The older claim that it never loads was incorrect. This repository uses `config`, which was verified on 1.3.1; the installer backs up an existing App Support `config.ghostty` to avoid conflicting files.

## Verify a new laptop

Tested on Apple Silicon with Ghostty 1.3.1 during the September 2026 setup:

```bash
/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config
/Applications/Ghostty.app/Contents/MacOS/ghostty +show-config | \
  grep -E '^(theme|font-size|custom-shader|macos-option-as-alt|quick-terminal)'
```

Expect Catppuccin Mocha, font size 14, the centered 70% quick terminal, and an
absolute shader path ending in `app-support/shaders/cursor_blaze.glsl`. The
relative shader path resolves against the configuration file. With both supplied
configs installed, the effective `macos-option-as-alt` value was `right`; the full
App Support configuration overrides the XDG file's `true` value.

Validation checks configuration errors; open Ghostty to check rendering and
keybindings. Reload with **Cmd+Shift+,** and open a new tab after shell changes.
Ghostty configuration does not install shell tools: use the separate
[dotfiles repository](https://github.com/tstanmay13/dotfiles) for zoxide, fzf,
Atuin, Starship, completions, and PATH. Reuse an existing Ghostty app rather than
reinstalling it solely to configure the terminal.
