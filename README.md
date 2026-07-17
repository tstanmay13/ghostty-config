# ghostty-config

My personal [Ghostty](https://ghostty.org) terminal setup — theme, keybinds, and custom cursor shaders. Clone this on a new laptop to get an identical terminal in one command.

## What's here

```
dot-config-ghostty/config   →  ~/.config/ghostty/config
app-support/config          →  ~/Library/Application Support/com.mitchellh.ghostty/config
app-support/shaders/        →  ~/Library/Application Support/com.mitchellh.ghostty/shaders/
```

- **`dot-config-ghostty/config`** — minimal XDG config (Option-as-Alt, word-delete keybind). This is the file Ghostty loads by default.
- **`app-support/config`** — the full "daily driver" config: Catppuccin Mocha theme, font size, padding, quick terminal, split navigation, copy-on-select, and the cursor-blaze shader.
- **`app-support/shaders/`** — custom GLSL shaders (`cursor_blaze.glsl` is active, `bloom.glsl` is available).

## Install on a new machine

```bash
git clone <this-repo-url> ~/Documents/personal/ghostty-config
cd ~/Documents/personal/ghostty-config
./install.sh
```

The script symlinks the files into place (backing up anything already there) so future edits sync straight back to the repo — just `git commit`.

## Notes

- Ghostty has **no inline comments**. A `#` must start its own line — never after a value.
- Reload config after editing: `⌘ + ⇧ + ,`
- ⚠️ In the source machine the App Support file was named `config.ghostty`, which Ghostty does **not** auto-load (it looks for `config`). This repo stores it as `config` so it actually takes effect. If you intentionally kept it dormant, remove that line from `install.sh`.
