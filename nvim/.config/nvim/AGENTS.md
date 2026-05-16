# AGENTS.md — Neovim Configuration

## Architecture

- **Modular config**: Split across `init.lua` (globals + requires), `lua/options.lua`, `lua/keymaps.lua`, `lua/autocommands.lua`, and per-plugin files in `lua/plugins/`.
- **Plugin Manager**: Native `vim.pack.add()` (built-in Neovim package manager). No lazy.nvim.
- **Neovim version**: 0.12.1+

---

## Key Conventions

- **Leader key**: `<Space>` — set at the top of `init.lua`, must be first before any plugin loads.
- **Icons**: `_G.Icons` is the single source of truth (diagnostics & git signs). Used in `mini.diff`, lualine, and diagnostic config.
- **LSP setup**: Uses `vim.lsp.config()` + `vim.lsp.enable()` APIs (Neovim 0.12+). Do NOT use `lspconfig[server].setup{}`.
- **Format on save**: Dynamically attached per-client via `LspAttach` autocmd. Each filetype creates its own augroup named `LspFormat<Filetype>.<bufnr>`. Not a global handler.
- **Lua code style**: No comments unless requested. Use single quotes.

---

## Plugins

- **File tree**: `neo-tree.nvim` — `<leader>e`
- **Completion**: `blink.cmp` — `<C-e>` docs, `<CR>` accept, `<Tab>`/`<S-Tab>` navigate
- **File picker**: `fzf-lua` — `<leader><Tab>` files, `<leader>f/` grep, `<leader>fb` buffers
- **AI**: `opencode.nvim` + `snacks.nvim` — port 4096, requires tmux session. Keymaps: `<leader>op` (Plan), `<leader>ob` (Build), `go` (range), `goo` (line)
- **File viewer**: `oil.nvim` — `-` opens parent directory
- **Diff**: `mini.diff` (`<leader>ht`) + `codediff.nvim` (`<leader>hd`)
- **Markdown**: `render-markdown.nvim` — headings `inline`, code blocks `thin` border, no language icon/name
- **DAP**: `nvim-dap` — Python only (`debugpy`). Looks for `.venv` in project root.
- **Mini modules**: `icons`, `move` (Alt+arrows), `pairs`, `trailspace`, `surround`, `splitjoin` (`<leader>cs`), `indentscope`, `diff`, `hipatterns` (FIXME/TODO/HACK/NOTE highlighting), `clue` (must be last)
- **Treesitter**: Syntax disabled by default; enabled per-filetype via fallback autocmd.
- **Colorscheme**: Gruvbox (soft contrast, inverse, italic comments).

---

## LSP Servers (enabled via `vim.lsp.enable`)

`ty`, `ruff`, `lua_ls`, `html`, `cssls`, `jsonls`, `vue_ls`, `vtsls`, `tailwindcss`, `terraformls`, `tflint`, `dockerls`, `yamlls`

- **Vue**: Uses `vtsls` with `@vue/typescript-plugin` from hardcoded NVM path (`/home/jorgeav527/.nvm/versions/node/v24.11.1/lib/node_modules/@vue/language-server`).
- **CSS**: `unknownAtRules = "ignore"`.
- **Python**: Ruff handles both formatting and import organization on save.
- **JS/TS**: vtsls handles formatting with `typescript.organizeImports` on save.

---

## Keymaps

| Key | Action |
|-----|--------|
| `j`/`k` | Wrap-aware movement |
| `x`, `v d`, `v p` | Delete/paste without yanking |
| `<Tab>`/`<S-Tab>` | Next/previous buffer |
| `<Esc>` | Clear highlights + escape |
| `<C-Arrow>` | Window navigation |
| `<leader>ba` | Copy absolute path |
| `<leader>br` | Copy relative path |
| `<leader>bQ` | Close all other buffers (with save prompt) |
| `<leader>cs` | Split/join toggle (mini.splitjoin) |
| `<leader>hs`/`<leader>hr` | Stage/reset hunk (mini.diff) |
| `[H`/`[h`/`]h`/`]H` | Navigate hunks |
| `<leader>kb` | Toggle breakpoint |
| `<leader>kc` | Debug continue |
| `<leader>kl`/`<leader>ks`/`<leader>kk` | Step over/into/out |
| `<leader>kr` | Restart frame |
| `<leader>kR` | Open REPL |
| `<leader>kL` | Run last debug config |

---

## Formatting on Save (per filetype)

Each creates a buffer-local `BufWritePre` via `LspAttach`:

- **lua** → `lua_ls`
- **python** → `ruff` (organizeImports + format)
- **html/css** → `html`/`cssls`
- **javascript/typescript** → `vtsls` (organizeImports + format)
- **json** → `jsonls`
- **terraform** → `terraformls`
- **dockerfile** → `dockerls`
- **yaml** → `yamlls`
- **vue** → `vue_ls`

---

## Notable Autocmds

- **BufReadPost**: Restore cursor position.
- **TextYankPost**: Highlight yanked text.
- **FileType** (`*`): Disable auto-comment continuation (`formatoptions`).
- **FileType**: Treesitter fallback — syntax is off by default, enabled per-filetype.
