# Neovim Configuration

Modular Neovim 0.12+ configuration using native `vim.pack.add()`. Built for full-stack web development and systems programming on Debian 12/13.

## Prerequisites

- Neovim 0.12+ (build from source — see below)
- `git`, `curl`, `ripgrep`, `fd-find`
- A Nerd Font (e.g. JetBrainsMono Nerd Font)
- `node` + `npm` (via nvm recommended)
- `npm install -g neovim`
- `uv` (Python package installer)
- `uv tool install --upgrade pynvim`
- Terraform tools (optional, for HCL files)

## Install inotify-tools for better file watching
- `sudo apt install inotify-tools`

## Installation

```bash
# 1. Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# 2. Clone this repo
git clone <your-repo-url> ~/.config/nvim

# 3. Install Neovim 0.12+ (pre-built binary)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# Add this to ~/.bashrc or ~/.zshrc:
#   export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# 4. Install system dependencies
sudo apt install ripgrep fd-find git curl

# 5. Install Python tools (uv)
curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install ruff@latest
uv tool install ty@latest
uv tool list

# 6. Install Node.js LSP servers (via nvm)
nvm install --lts  # if not already done
npm install -g prettier
npm install -g @fsouza/prettierd
npm install -g vscode-langservers-extracted        # html, cssls, jsonls
npm install -g @vtsls/language-server
npm install -g @vue/language-server                 # vue_ls + vtsls vue plugin
npm install -g @tailwindcss/language-server
npm install -g dockerfile-language-server-nodejs    # dockerls
npm install -g yaml-language-server                 # yamlls

# 6.5. Install lua-language-server (from GitHub release)
cd Download/
curl -LO https://github.com/LuaLS/lua-language-server/releases/latest/download/lua-language-server-3.18.2-linux-x64.tar.gz
mkdir lua-ls-tmp && cd lua-ls-tmp && tar -xzf ../lua-language-server-3.18.2-linux-x64.tar.gz
sudo cp bin/lua-language-server /usr/local/bin/
cd .. && rm -rf lua-ls-tmp lua-language-server-3.18.2-linux-x64.tar.gz
lua-language-server --version
# 6.6. Install stylua
cargo install stylua

# 7. Install Terraform tools (optional)
sudo apt install terraform-ls
# tflint:
curl -sSLO https://github.com/terraform-linters/tflint/releases/latest/download/tflint_linux_amd64.zip
curl -sSLO https://github.com/terraform-linters/tflint/releases/latest/download/checksums.txt
sha256sum --ignore-missing -c checksums.txt
unzip tflint_linux_amd64.zip
sudo install -c -v tflint /usr/local/bin/
rm tflint tflint_linux_amd64.zip checksums.txt

# 8. Launch Neovim — plugins load automatically on first require
nvim
```

## LSP Servers

| Server | Package | Command |
|--------|---------|---------|
| `ruff` | ruff | `uv tool install ruff` |
| `ty` | ty-lsp | `uv tool install ty-lsp` |
| `html` | vscode-langservers-extracted | `npm i -g vscode-langservers-extracted` |
| `cssls` | vscode-langservers-extracted | `npm i -g vscode-langservers-extracted` |
| `jsonls` | vscode-langservers-extracted | `npm i -g vscode-langservers-extracted` |
| `vtsls` | vtsls | `npm i -g vtsls` |
| `vue_ls` | @vue/language-server | `npm i -g @vue/language-server` |
| `tailwindcss` | @tailwindcss/language-server | `npm i -g @tailwindcss/language-server` |
| `dockerls` | dockerfile-language-server-nodejs | `npm i -g dockerfile-language-server-nodejs` |
| `yamlls` | yaml-language-server | `npm i -g yaml-language-server` |
| `lua_ls` | lua-language-server | `curl -LO ... && mkdir tmp && cd tmp && tar -xzf ../*.tar.gz && sudo cp bin/lua-language-server /usr/local/bin/` (see step 6.5) |
| `terraformls` | terraform-ls | `sudo apt install terraform-ls` |
| `tflint` | tflint | See step 7 |

For all available LSP configs, see the [nvim-lspconfig lsp directory](https://github.com/neovim/nvim-lspconfig/tree/master/lsp).

## File Structure

```
~/.config/nvim
├── init.lua                  # Globals + 19 require() calls
├── AGENTS.md                 # Full keymap reference & architecture
├── lua/
│   ├── options.lua           # vim.o / vim.opt settings
│   ├── keymaps.lua           # All keybindings
│   ├── autocommands.lua      # Generic autocmds (cursor, yank, comments)
│   └── plugins/
│       ├── pack.lua          # vim.pack.add() — registers all plugins
│       ├── treesitter.lua    # Syntax fallback + incremental selection
│       ├── gruvbox.lua       # Colorscheme
│       ├── snacks.lua        # Snacks.nvim (opencode dependency)
│       ├── opencode_cfg.lua  # opencode.nvim config
│       ├── mini.lua          # All mini.nvim modules (icons, move, pairs, etc.)
│       ├── mini_clue.lua     # mini.clue — keymap hints (must be last)
│       ├── lualine.lua       # Statusline
│       ├── blink_cmp.lua     # Completion
│       ├── fzf_lua.lua       # File picker
│       ├── oil_cfg.lua       # File viewer
│       ├── neo_tree.lua      # File tree
│       ├── neoscroll.lua     # Smooth scrolling
│       ├── codediff.lua      # Diff viewer
│       ├── render_markdown.lua # Markdown rendering
│       ├── dap_cfg.lua       # Debugger (Python only)
│       └── lsp.lua           # Diagnostics, LSP configs, format-on-save
```
