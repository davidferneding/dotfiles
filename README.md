# My dotfiles
## Dependencies
### Fonts
- [Monaspace Neon + Radon](https://monaspace.githubnext.com/) (terminal & editor)
- SF Pro (sketchybar)
- [Sketchybar App Font](https://github.com/kvndrsslr/sketchybar-app-font) (icons)

### Tools
- [Homebrew](https://brew.sh/)
- [Babashka](https://babashka.org/) - Clojure scripting runtime (theme system, sketchybar plugins, lf scripts)
- [gum](https://github.com/charmbracelet/gum) - CLI prompts
- Zsh + [Oh My Zsh](https://ohmyz.sh/)

## Setup

```sh
./setup.sh
```

This will:
1. Install Homebrew (if not already installed)
2. Install all CLI tools, apps, and fonts via Homebrew
3. Install Oh My Zsh (if not already installed)
4. Create links in `~/` for `.zshrc`, `.tmux.conf`, and `.ideavimrc`
5. Seed the theme config files

## Theming

The entire environment uses a centralized theme system based on [Catppuccin](https://github.com/catppuccin/catppuccin). You can choose a flavour using:

```sh
cd ~/.config/theme/
bb switch
```

This will update the theme config files for all tools.

**Available themes:** Latte (light), Frappé, Macchiato, Mocha

**Generated theme config files (not tracked in git):**
- `wezterm/theme.lua`
- `nvim/lua/current-theme.lua`
- `tmux/theme.conf`
- `sketchybar/theme_colors.{sh,edn}`
- `borders/theme_colors.sh`
- `theme.edn`

## Tools
### [WezTerm](https://wezfurlong.org/wezterm/) - Terminal emulator
Config written in Fennel (compiled to Lua via [nfnl](https://github.com/Olical/nfnl)).

Using Monaspace font family with Neon for normal text and Radon for italics.

### [Neovim](https://neovim.io/) - Editor
Config in Lua + Fennel, using [Lazy.nvim](https://github.com/folke/lazy.nvim) as plugin manager.

- **LSP:** Mason, blink.cmp
- **Navigation:** fzf, Harpoon, Oil.nvim
- **REPL:** Conjure

### [Tmux](https://github.com/tmux/tmux) - Terminal multiplexer
Sessions will be auto-saved using `tmux-continuum` and can be restored using `tmux-resurrect`

### [AeroSpace](https://github.com/nikitabobko/AeroSpace) - Window manager
Config auto-generated using Clojure based on keyboard layout and number of monitors. Supports QWERTY and Dvorak.

### [SketchyBar](https://github.com/FelixKratz/SketchyBar) - Menu bar
Plugins written in Clojure.

- Left side: workspace indicators, focused app
- Right side: calendar (click to open notification centre), battery, notification indicators (Slack, Teams, Outlook)

### [JankyBorders](https://github.com/FelixKratz/JankyBorders) - Window borders
Indicators for focused / unfocused windows.

### [lf](https://github.com/gokcehan/lf) - File manager
CLI file browser.

- `v` → open file in Preview
- `a` → create file/folder
- `x` → delete

## Other configs

### Zsh (`.zshrc`)
- Oh My Zsh, robbyrussell theme, Powerlevel10k instant prompt
- `$EDITOR` set to `nvim`

### IdeaVim (`.ideavimrc`)
Vim emulation for JetBrains IDEs.
- Plugins: vim-commentary, vim-surround
- Custom mappings mirror Neovim setup
- `<leader>rt/dt` to run and debug tests
