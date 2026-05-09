return {
	{
		"rust-lang/rust.vim",
		ft = "rust",
		config = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		init = function()
			-- Rust tooling is intentionally managed outside Mason.
			-- Install rust-analyzer/clippy/rustfmt via rustup so rustaceanvim uses
			-- the toolchain selected for the current project.
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<C-space>", function()
							vim.cmd.RustLsp({ "hover", "actions" })
						end, { buffer = bufnr })
						vim.keymap.set("n", "<Leader>a", function()
							vim.cmd.RustLsp("codeAction")
						end, { buffer = bufnr })
					end,
					default_settings = {
						["rust-analyzer"] = {
							imports = { granularity = { group = "module" }, prefix = "self" },
							diagnostics = { enable = true },
							check = { command = "clippy" },
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
				},
			}
		end,
	},
}
