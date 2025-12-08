# Shen's Neovim — Fast, Minimal, Batteries Included

> Lazy-managed, Tokyonight-transparent Neovim with smart navigation, LSP/cmp stack, Treesitter, Git UI, Python tooling, terminal helpers, and a VSCode-aware profile.

![Neovim](https://img.shields.io/badge/Neovim-0.9+-57A143?logo=neovim&logoColor=white) ![Lazy](https://img.shields.io/badge/Plugin%20Manager-lazy.nvim-orange) ![Theme](https://img.shields.io/badge/Theme-tokyonight_moon-1E2030)

## Screenshots (placeholders)
- Dashboard / statusline / bufferline: `assets/ui-home.png` (drop your PNG/GIF here)
- Telescope live-grep + outline: `assets/telescope-outline.gif`
- Python debug/test flow: `assets/python-dap.png`

*(Add your own captures later; filenames above are just placeholders.)*

## Why use this config
- **Great defaults**: relative numbers, smart indent, wrap on, cursorline/column, transparent Tokyonight.
- **Two profiles**: full native Neovim or lightweight VSCode (auto-detected with `vim.g.vscode`).
- **Navigation superpowers**: hop, accelerated-jk, window-picker, aerial outline, NvimTree, Telescope with live grep & file browser.
- **Productive editing**: surround, Comment.nvim, context-commentstring, autopairs/autotag, indent guides, marks, TODO highlighter.
- **LSP/Completion**: mason + lspconfig + lspsaga, cmp (LSP/buffer/LuaSnip), diagnostics with icons.
- **Treesitter everywhere**: highlighting, context sticky header, folding (ufo), and autotagging.
- **Git & history**: gitsigns, git.nvim, quickfix enhancer (bqf), time-machine view.
- **Python toolkit**: dap-python, neotest-python, iron.nvim REPL, pymple import resolver, toggleterm workflows.
- **Remote & DevOps**: remote-sshfs picker, jenkinsfile linter, conform formatter.
- **Terminal quality-of-life**: send selection/clipboard to last terminal, remember & highlight last terminal, copy path with line numbers.

## Requirements
- Neovim 0.9+ (tested)
- git, curl
- Node.js (Markdown preview, some LSP servers)
- Compiler: `clang` (macOS/Windows) or `gcc` (Linux) for Treesitter; `clangd` for C/C++ LSP
- Windows extras (optional):
  ```cmd
  winget install -e --id zig.zig
  winget install BurntSushi.ripgrep.MSVC
  ```

## Install
```sh
git clone https://github.com/yourname/nvim.git ~/.config/nvim   # Linux/macOS
# Windows: %LOCALAPPDATA%\nvim
nvim   # first launch auto-installs lazy.nvim and plugins
```

## Quickstart
- `:Mason` to install LSP servers (clangd, pyright, etc.).
- `:TSInstall <lang>` if a Treesitter parser is missing.
- `:NvimTreeToggle`, `<leader>ff` (Telescope find files), `<leader>fg` (live grep args), `<leader>fb` (buffers).
- Python: `:Neotest run` (per file), `:IronRepl` for REPL, DAP via `:lua require'dap'.continue()`.

## Plugin Stack (grouped)
- **Core/UI**: `folke/tokyonight.nvim`, `nvim-lualine/lualine.nvim`, `akinsho/nvim-bufferline.lua`, `kyazdani42/nvim-web-devicons`, `lukas-reineke/indent-blankline.nvim`, `norcalli/nvim-colorizer.lua`, `kevinhwang91/nvim-ufo` (folds).
- **Navigation/Search**: `smoka7/hop.nvim`, `rhysd/accelerated-jk`, `nvim-tree/nvim-tree.lua`, `stevearc/aerial.nvim`, `nvim-telescope/telescope.nvim` + live-grep-args + file-browser, `s1n7ax/nvim-window-picker`.
- **Editing**: `tpope/vim-surround`, `JoosepAlviste/nvim-ts-context-commentstring`, `numToStr/Comment.nvim`, `windwp/nvim-autopairs`, `windwp/nvim-ts-autotag`, `chentoast/marks.nvim`, `folke/todo-comments.nvim`.
- **LSP/Completion**: `williamboman/mason.nvim`, `mason-lspconfig.nvim`, `neovim/nvim-lspconfig`, `nvimdev/lspsaga.nvim`, `hrsh7th/nvim-cmp`, `cmp-nvim-lsp`, `cmp-buffer`, `saadparwaiz1/cmp_luasnip`, `L3MON4D3/LuaSnip`.
- **Treesitter**: `nvim-treesitter/nvim-treesitter`, `nvim-treesitter/nvim-treesitter-context`.
- **Git**: `lewis6991/gitsigns.nvim`, `dinhhuy258/git.nvim`, `kevinhwang91/nvim-bqf`, `y3owk1n/time-machine.nvim`.
- **Terminal/Focus**: `akinsho/toggleterm.nvim`, `folke/zen-mode.nvim`, `folke/twilight.nvim`, custom `terminal-send` helper.
- **Python/Testing/Debug**: `mfussenegger/nvim-dap` + `nvim-dap-python`, `nvim-neotest/neotest` + `neotest-python`, `Vigemus/iron.nvim`, `alexpasmantier/pymple.nvim`.
- **Remote/DevOps**: `nosduco/remote-sshfs.nvim`, `ckipp01/nvim-jenkinsfile-linter`, `stevearc/conform.nvim`.
- **VSCode profile only**: `unblevable/quick-scope`, `easymotion/vim-easymotion`, `JoosepAlviste/nvim-ts-context-commentstring` (shared) with VSCode keybindings.

## Keymaps (leaders: `;` global, `\` local)
- Insert escape: `kj` / `jk`; word-jump: `<C-l>` end word, `<C-h>` back word.
- Tabs/windows: `te` new tab; `th`/`tl` move tab; `ss` split, `sv` vsplit; `sh/sk/sj/sl` move focus; `<C-Left/Right/Up/Down>` resize.
- Selection: `<C-a>` select all; `dw` delete previous word; `+`/`-` inc/dec number.
- Paths: `yr` copy relative path; `<leader>yr` (visual) copy path + line range; `<leader>l`/`<leader>L` copy path+lines then send to terminal.
- Terminal: `<leader>tc` send clipboard to last terminal; `<leader>ts` send visual selection; `<leader>q` exit terminal mode.
- Search/Files (Telescope): `<leader>ff` files, `<leader>fg` live grep, `<leader>fb` buffers, `<leader>fh` help tags.
- Folding: `zM`/`zR` fold all/unfold all (mapped to VSCode fold commands when in VSCode profile).

## Terminal Send helper
- Remembers the last terminal buffer/window, highlights it, and re-opens if closed.
- Send clipboard or visual selection without leaving your window (`<leader>tc`, `<leader>ts`).
- Optional stay/insert behavior handled in `lua/terminal-send.lua`.

## OS-specific tweaks
- Linux/macOS: clipboard uses `unnamedplus`; shell set to `zsh` on *nix.
- Windows: clipboard uses `unnamed,unnamedplus`; shell set to `cmd`.

## File layout
- `init.lua` — bootstraps lazy.nvim, loads platform modules, keymaps.
- `lua/base.lua` — core options.
- `lua/highlights.lua` — UI/diagnostic icons and visuals.
- `lua/maps.lua` / `lua/ultra_maps.lua` — leader/keymaps and path/terminal helpers.
- `lua/plugins/` — lazy.nvim plugin specs (always, notvscode, vscode).
- `lua/terminal-send.lua` — terminal workflow helper.

## Troubleshooting
- Treesitter build fails: ensure `clang` (mac/win) or `gcc` (linux) is in PATH.
- Missing LSP features: open `:Mason` and install servers (`clangd`, `pyright`, etc.), restart Neovim.
- Transparent background too light: change style in `lua/plugins/user/notvscode.lua` (`style = "moon"` → "storm"/"night" or set `transparent = false`).
- VSCode quirks: profile auto-loads when `vim.g.vscode` is set; if you want native profile inside VSCode, unset that variable.

## Roadmap / personal notes
- Add real screenshots/gifs in `assets/` and reference above.
- Consider adding formatter/linter per language via conform/null-ls alternative.
- Add custom mason install list for frequently used servers.

Happy hacking!
