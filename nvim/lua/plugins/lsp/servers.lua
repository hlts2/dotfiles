-- LSP server configuration
-- mason-lspconfig: Connects LSPs installed via mason to nvim-lspconfig
-- nvim-lspconfig: LSP server settings
return {
	"williamboman/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		mason_lspconfig.setup({
			-- ensure_installed is owned by mason-tool-installer.nvim
			automatic_enable = true,
		})

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config("zls", {
			cmd = { "zls", },
			filetypes = { "zig", "zir", "zon" },
			root_markers = { ".git", "build.zig" },
			single_file_support = true,
		})

		vim.lsp.config("gopls", {
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_markers = { "go.work", "go.mod", ".git" },
			single_file_support = true,
		})

		vim.lsp.config("graphql", {
			cmd = { "graphql-lsp", "server", "-m", "stream" },
			filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript", "javascript", "vue" },
			root_markers = { ".git", ".graphqlrc", ".graphqlrc.json", ".graphqlrc.yaml", ".graphqlrc.yml", "graphql.config.js", "graphql.config.ts" },
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim", "require" } },
					workspace = { library = vim.api.nvim_get_runtime_file("", true) },
					telemetry = { enable = false },
				},
			},
		})

		vim.lsp.config("nil_ls", {
			cmd = { "nil" },
			filetypes = { "nix" },
			root_markers = { "flake.nix", "default.nix", ".git" },
			single_file_support = true,
		})

		-- rust_analyzer is managed by rustaceanvim

		vim.lsp.config("helm_ls", {
			cmd = { "helm_ls", "serve" },
			filetypes = { "helm" },
			root_markers = { "Chart.yaml" },
		})

		vim.lsp.config("yamlls", {
			cmd = { "yaml-language-server", "--stdio" },
			filetypes = { "yaml", "yml" },
			on_attach = function(client, bufnr)
				vim.defer_fn(function()
					if vim.bo[bufnr].filetype == "helm" then
						vim.lsp.buf_detach_client(bufnr, client.id)
					end
				end, 1)
			end,
			settings = {
				yaml = {
					schemas = {
						kubernetes = {
							"*deployment.yaml",
							"*daemonset.yaml",
							"*service.yaml",
							"*configmap.yaml",
							"*pdb.yaml",
							"secret.yaml",
							"*job.yaml",
							"*cronjob.yaml",
						},
						["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
					},
				},
			},
		})

		-- Keymaps
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
		vim.keymap.set("n", "K", vim.lsp.buf.hover)

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "<C-[>", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<space>h", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<space>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)

				vim.api.nvim_create_autocmd("BufWritePre", {
					pattern = { "*.rs", "*.zig", "*.zon" },
					callback = function()
						vim.lsp.buf.format({ buffer = opts.buffer, async = false })
					end,
				})
			end,
		})
	end,
}
