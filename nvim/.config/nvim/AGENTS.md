# AGENTS.md — Neovim Configuration

## Architecture

- **Modular config**: Split across `init.lua` (globals + requires), `lua/options.lua`, `lua/keymaps.lua`, `lua/autocommands.lua`, and per-plugin files in `lua/plugins/`.
- **Plugin Manager**: Native `vim.pack.add()` (built-in Neovim package manager). No lazy.nvim. Lockfile: `nvim-pack-lock.json`.
- **Neovim version**: 0.12.1+

---

## Key Conventions

- **Leader key**: `<Space>` — set at the top of `init.lua`, must be first before any plugin loads.
- **Icons**: `_G.Icons` is the single source of truth (diagnostics & git signs). Used in `mini.diff`, lualine, and diagnostic config.
- **LSP setup**: Uses `vim.lsp.config()` + `vim.lsp.enable()` APIs (Neovim 0.12+). Do NOT use `lspconfig[server].setup{}`.
- **Format on save**: Uses `conform.nvim` with `lsp_format = 'fallback'`. Config in `lua/plugins/conform.lua`.
- **Treesitter**: `syntax off` globally. Tries `vim.treesitter.start()` on every FileType; falls back to `syntax on` if unavailable.
- **Lua code style**: No comments unless requested. Use single quotes.

---

## Plugins

- **File tree**: `neo-tree.nvim` — `<leader>e`
- **Completion**: `blink.cmp` — `<C-s>` show/docs, `<CR>` accept, `<Tab>`/`<S-Tab>` snippet nav, `<C-u>`/`<C-d>` scroll docs
- **File picker**: `fzf-lua` — `<leader>f<Tab>` files, `<leader>f/` grep, `<leader>fb` buffers, `<leader>fl` current buffer lines
- **Formatting**: `conform.nvim` — lua→stylua, python→ruff_organize_imports+ruff_format, rust→rustfmt, javascript→prettierd/prettier
- **AI**: `opencode.nvim` + `snacks.nvim` — port 4096, requires tmux session
- **File viewer**: `oil.nvim` — `-` opens parent directory
- **Diff**: `mini.diff` (`<leader>ht`) + `codediff.nvim` (`<leader>hd`)
- **Markdown**: `render-markdown.nvim` — headings `inline`, code blocks `thin` border, no language icon/name
- **DAP**: `nvim-dap` — Python only (`debugpy`). Looks for `.venv` in project root via `vim.fs.root()`.
- **Mini modules**: `icons`, `move` (Alt+arrows), `pairs`, `trailspace`, `surround`, `splitjoin` (`<leader>cs`), `indentscope`, `diff`, `hipatterns` (FIXME/TODO/HACK/NOTE + hex colors), `clue` (must be loaded last)
- **Start screen**: `alpha-nvim`
- **Smooth scroll**: `neoscroll.nvim`
- **Colorscheme**: Gruvbox (soft contrast, inverse, italic comments). Kanagawa available but not active.

---

## LSP Servers (enabled via `vim.lsp.enable`)

`lua_ls`, `html`, `cssls`, `vtsls`, `vue_ls`, `tailwindcss`, `terraformls`, `tflint`, `ruff`, `ty`

- **Vue**: vtsls handles vue filetype with `@vue/typescript-plugin` from hardcoded NVM path (`/home/jorgeav527/.nvm/versions/node/v24.11.1/lib/node_modules/@vue/language-server`).
- **CSS**: `unknownAtRules = "ignore"`.
- **Python**: `ruff` for diagnostics/formatting, `ty` for type checking.

---

## Keymaps

| Key | Action |
|-----|--------|
| `j`/`k` | Wrap-aware movement (`gj`/`gk`) |
| `x`, `v d`, `v p`, `c` | Delete/paste/change without yanking |
| `<Tab>`/`<S-Tab>` | Next/previous buffer |
| `<Esc>` | Clear highlights + escape |
| `<C-Arrow>` | Window focus navigation |
| `<leader>ba` / `<leader>br` | Copy absolute / relative path |
| `<leader>bQ` | Close all other buffers (with save prompt) |
| `<leader>cs` | Split/join toggle (mini.splitjoin) |
| `<leader>hs`/`<leader>hr` | Stage/reset hunk (mini.diff) |
| `[H`/`[h`/`]h`/`]H` | Navigate hunks |
| `<leader>kb`/`<leader>kc`/`<leader>kl`/`<leader>ks`/`<leader>kk`/`<leader>kr` | DAP: breakpoint, continue, step over/into/out, restart |
| `<leader>kq`/`<leader>kR`/`<leader>kL` | DAP: terminate, REPL, run last |
| `K` | LSP hover |
| `<C-k>` | LSP signature help |
| `gd`/`gD`/`gri`/`grr`/`grt`/`gr[a]`/`gy`/`gO` | LSP: definition, declaration, implementation, references, typedefs, code actions, workspace symbols, document symbols |
| `-` | Open parent directory (oil.nvim) |
| Visual `<Enter>`/`<Backspace>` | Select parent/child treesitter node |
