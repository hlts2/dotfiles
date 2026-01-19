-- LSPサーバーの設定
-- mason-lspconfig: masonでインストールしたLSPをnvim-lspconfigに接続
-- nvim-lspconfig: LSPサーバーの設定
return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		mason_lspconfig.setup({
			ensure_installed = {
				"bashls",
				"biome",
				"clangd",
				"cmake",
				"dagger",
				"docker_compose_language_service",
				"dockerls",
				"efm",
				"eslint",
				"gopls",
				"graphql",
				"html",
				"jqls",
				"jsonls",
				"lua_ls",
				"pyright",
				"rust_analyzer",
				"svelte",
				"tailwindcss",
				"taplo",
				"terraformls",
				"tflint",
				"vtsls",
				"yamlls",
			},
			automatic_installation = true,
		})

		-- 各サーバーの個別設定
		local server_configs = {
			gopls = {
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
				single_file_support = true,
			},
			graphql = {
				cmd = { "graphql-lsp", "server", "-m", "stream" },
				filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript", "javascript", "vue" },
				root_dir = lspconfig.util.root_pattern(".git", ".graphqlrc*", ".graphql.config.*", "graphql.config.*"),
			},
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim", "require" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
					},
				},
			},
			rust_analyzer = {
				cmd = { "rust-analyzer" },
				filetypes = { "rust" },
				root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
				settings = {
					["rust-analyzer"] = {
						imports = { granularity = { group = "module" }, prefix = "self" },
						diagnostics = { enable = true },
						cargo = {},
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
			helm_ls = {
				cmd = { "helm_ls", "serve" },
				filetypes = { "helm" },
				root_dir = lspconfig.util.root_pattern("Chart.yaml"),
			},
			yamlls = {
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
			},
		}

		mason_lspconfig.setup_handlers({
			function(server_name)
				local opts = server_configs[server_name] or {}
				opts.capabilities = capabilities
				lspconfig[server_name].setup(opts)
			end,
		})

		-- キーマップ
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
					pattern = { "*.rs" },
					callback = function()
						vim.lsp.buf.format({ buffer = opts.buffer, async = false })
					end,
				})
			end,
		})
	end,
}
