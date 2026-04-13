# 🚀 Neovim Configuration for Modern Development (v0.11.6+)

A highly modular, blazing-fast Neovim configuration tailored for Full-Stack Web Development and Systems Programming. Optimized for Neovim 0.11+ using the latest native LSP APIs.

---

## 🌟 Key Features

- **LSP Power:** Native Neovim LSP setup using `vim.lsp.config` and `vim.lsp.enable`.
- **Linting & Formatting:** Integrated via `efm-langserver` for consistent code style across 20+ languages.
- **AI-Powered Coding:** `Codeium` integration for intelligent autocompletions.
- **Fast Picker:** `fzf-lua` for instantaneous file searching, grepping, and symbol navigation.
- **Rich UI:** `Lspsaga` for beautiful hover docs, renames, and diagnostics; `lualine` for a clean status bar.
- **Advanced Rust Support:** Deep integration with `rustaceanvim` for cargo tasks and debugging.
- **File Management:** `neo-tree` for intuitive project navigation.
- **Distraction-Free:** `zen-mode` and `twilight` for focused coding sessions.

## 🛠️ Supported Languages

`TypeScript`, `JavaScript`, `Go`, `Rust`, `Python`, `Lua`, `C/C++`, `Bash`, `Solidity`, `Docker`, `YAML`, `JSON`, `HTML`, `CSS`, `TailwindCSS`, `Vue`, `React`, `Svelte`, `Helm`.

## 📋 Prerequisites

- **Neovim v0.11.6 or higher** (Required for the new LSP APIs used here).
- **Git** (For plugin management).
- **Ripgrep (rg)**: Required for fast searching.
- **A Nerd Font**: Recommended for icons (e.g., JetBrainsMono Nerd Font).
- **Node.js / Python / Go / Rust**: For various LSP servers and tools.

## 🚀 Installation

1. **Backup your current configuration:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   ```

2. **Clone this repository:**
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

3. **Launch Neovim:**
   ```bash
   nvim
   ```
   `lazy.nvim` will automatically download and install all plugins.

4. **Install External Tools:**
   Open Neovim and run `:Mason` to install any missing LSP servers, linters, or formatters.

## 📂 File Structure

```text
~/.config/nvim
├── init.lua              # Main entry point
├── lua
│   ├── config
│   │   ├── autocmds.lua  # Event-based logic (Format on save, etc.)
│   │   ├── globals.lua   # Leader key and global variables
│   │   ├── keymaps.lua   # Global keybindings
│   │   └── options.lua   # Neovim options/settings
│   ├── plugins           # Individual plugin configurations
│   ├── servers           # LSP server setups (one file per server)
│   └── utils             # Helper functions (LSP on_attach, etc.)
└── README.md
```

## ⌨️ Keybindings

The **Leader key** is set to `<Space>`.

### General
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle File Explorer (Neo-tree) |
| `<leader>z` | Toggle Zen Mode |
| `<Tab>` | Next Buffer |
| `<S-Tab>` | Previous Buffer |
| `<C-s>` | Save File |
| `<leader>bx` | Close Current Buffer |

### LSP & Navigation (`fzf-lua`)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find Files |
| `<leader>fg` | Live Grep (Search in files) |
| `<leader>gd` | Peek Definition (Lspsaga) |
| `<leader>gD` | Go to Definition |
| `<leader>ca` | Code Actions |
| `<leader>rn` | Rename Symbol |
| `K` | Hover Documentation |

## 🎥 Original Tutorials

This configuration was inspired by and documented in the following tutorial series:
- [Part 1: Options & Plugins](https://youtu.be/cdAMq2KcF4w)
- [Part 2: LSP & AI Assistance](https://youtu.be/qp1OcolI6x0)
- [Part 3: Git & Debugging](https://youtu.be/JN4Zbs0ypwM)

## 📄 License

Distributed under the GPLv3 License.
