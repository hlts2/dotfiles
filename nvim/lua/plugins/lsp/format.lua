-- Formatting and linting.
--
-- conform.nvim is the single owner of format-on-save. No other plugin may
-- format on save: lang/go.lua and lang/rust.lua disable their own autosave,
-- and servers.lua no longer registers a BufWritePre handler.
-- nvim-lint owns the standalone linters that no LSP server provides.
--
-- Tool ownership:
-- - Mason-managed tools are installed from lsp/tool-installer.lua.
-- - rustfmt/zigfmt come from rustup/zig, terraform_fmt and tfsec from the
--   terraform toolchain, zsh from the shell itself.
-- - terraform validation is not listed here; terraformls reports it already.
return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<space>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = { "n", "v" },
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				-- biome-check is what the frontend repos run as their own
				-- `format` script: format, lint fixes and import sorting in one
				-- pass. It resolves the project's node_modules copy and does
				-- nothing outside a project that has a biome config.
				css = { "biome-check" },
				go = { "goimports", "gofumpt" },
				javascript = { "biome-check" },
				javascriptreact = { "biome-check" },
				json = { "biome-check" },
				lua = { "stylua" },
				nix = { "nixfmt" },
				proto = { "buf" },
				-- ruff sorts imports first, then formats.
				python = { "ruff_organize_imports", "ruff_format" },
				rust = { "rustfmt" },
				sql = { "sql_formatter" },
				terraform = { "terraform_fmt" },
				typescript = { "biome-check" },
				typescriptreact = { "biome-check" },
				zig = { "zigfmt" },
				-- Filetypes with no formatter of their own still get the
				-- trailing-whitespace strip that core.lua used to do globally.
				["_"] = { "trim_whitespace" },
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 1000,
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				dockerfile = { "hadolint" },
				proto = { "protolint" },
				sql = { "sqlfluff" },
				terraform = { "tfsec" },
				zsh = { "zsh" },
			}

			vim.api.nvim_create_autocmd("BufWritePost", {
				group = vim.api.nvim_create_augroup("NvimLint", {}),
				callback = function(ev)
					lint.try_lint()
					-- actionlint only understands workflow files, not yaml at large.
					if vim.api.nvim_buf_get_name(ev.buf):match("/%.github/workflows/") then
						lint.try_lint("actionlint")
					end
				end,
			})
		end,
	},
}
