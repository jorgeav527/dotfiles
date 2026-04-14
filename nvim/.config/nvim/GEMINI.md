# Workspace Context: Neovim Configuration (v0.11.6+)

This workspace contains a highly modular Neovim configuration optimized for web development and general software engineering (TypeScript, Go, Rust, Python, Lua, etc.).

## Project Overview

- **Core:** Neovim 0.11.6+.
- **Plugin Manager:** `lazy.nvim`.
- **Architecture:**
  - `init.lua`: Main entry point, sets up `lazy.nvim`.
  - `lua/config/`: Core settings (`options.lua`), global keybindings (`keymaps.lua`), and system-wide autocommands (`autocmds.lua`).
  - `lua/plugins/`: Individual plugin specifications (one file per plugin/group).
  - `lua/servers/`: LSP server configurations (one file per server), loaded via `lua/servers/init.lua`.
  - `lua/utils/`: Shared helper modules for LSP, diagnostics, etc.

## Key Technologies & Plugins

- **LSP:** Native Neovim LSP with `nvim-lspconfig` and the new `vim.lsp.config`/`vim.lsp.enable` APIs (Neovim 0.11+).
- **Formatters/Linters:** `efm-langserver` with `efmls-configs-nvim` integration.
- **Completion:** `nvim-cmp` with various sources (LSP, snippets, buffer, path).
- **Picker:** `fzf-lua` for files, grep, and LSP symbols.
- **File Explorer:** `neo-tree`.
- **AI:** `codeium.nvim`.
- **UI:** `lualine.nvim` for statusline, `gruvbox` theme.
- **Rust Integration:** `rustaceanvim` for a superior Rust development experience.

## Building & Running

As this is a Neovim configuration, "running" it involves launching `nvim`.

- **Install Plugins:** `lazy.nvim` handles this on first launch or via `:Lazy`.
- **Check Health:** Run `:checkhealth` within Neovim.
- **LSP/Tool Management:** `mason.nvim` is used to manage LSP servers, linters, and formatters (configured in `lua/plugins/mason_config.lua`).

## Development Conventions

- **Modular Design:** Keep plugin-specific logic within its corresponding file in `lua/plugins/`.
- **LSP Setup:** New servers should be added as a file in `lua/servers/` and required in `lua/servers/init.lua`.
- **Formatting:** Formatting is primarily handled via `efm-langserver` on save. The `BufWritePre` autocommand in `lua/config/autocmds.lua` triggers this.
- **Keybindings:**
  - Leader key is `<Space>` (set in `lua/config/globals.lua`).
  - Buffer navigation: `<Tab>` (Next), `<S-Tab>` (Previous).
  - File Explorer: `<leader>e`.
  - Zen Mode: `<leader>z`.
- **Code Style:** Use `stylua` for Lua formatting (configured in EFM). `.luacheckrc` defines the linting rules.

## Known Architecture & Conflicts to Watch

- **LSP API:** Uses Neovim 0.11+ `vim.lsp.config` and `vim.lsp.enable`. Do not use deprecated `lspconfig[server].setup{}` unless necessary.
- **Formatting:** Ensure `async = false` in `vim.lsp.buf.format` within `BufWritePre` to ensure formatting completes before writing to disk.
- **DAP:** Currently specifically configured for Rust in `lua/utils/lsp.lua` and `lua/plugins/rustaceanvim.lua`.
