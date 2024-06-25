local M = {}

M.setup = function()
	-- NOTE: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#setup
	require("mason").setup()
	local lspconfig = require("lspconfig")
	local mason_lspconfig = require("mason-lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

	mason_lspconfig.setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
		ensure_installed = {
			"bashls",
			"biome",
			"bufls",
			"clangd",
			"cmake",
			"dagger",
			"docker_compose_language_service",
			"dockerls",
			"efm",
			"eslint",
			"gopls",
			"graphql",
			-- "helm_ls",
			"html",
			"jqls",
			"jsonls",
			"lua_ls",
			"pyright",
			-- "rnix",
			"nil_ls",
			"rust_analyzer",
			"svelte",
			"tailwindcss",
			"taplo",
			"terraformls",
			"tflint",
			"tsserver",
			"vtsls",
			"yamlls",
		},
		automatic_installation = true,
	})

	mason_lspconfig.setup_handlers({
		-- NOTE https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		function(server_name)
			local opts = {}
			if server_name == "gopls" then
				opts = {
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
					single_file_support = true,
				}
			elseif server_name == "graphql" then
				opts = {
					cmd = { "graphql-lsp", "server", "-m", "stream" },
					filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript", "javascript", "vue" },
					root_dir = lspconfig.util.root_pattern(
						".git",
						".graphqlrc*",
						".graphql.config.*",
						"graphql.config.*"
					),
				}
			elseif server_name == "lua_ls" then
				opts = {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							diagnostics = {
								globals = {
									"vim",
									"require",
								},
							},
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
							},
							telemetry = {
								enable = false,
							},
						},
					},
				}
			elseif server_name == "rust_analyzer" then
				opts = {
					cmd = { "rust-analyzer" },
					filetypes = { "rust" },
					root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
					settings = {
						["rust-analyzer"] = {
							imports = {
								granularity = {
									group = "module",
								},
								prefix = "self",
							},
							diagnostics = {
								enable = true,
							},
							cargo = {
								-- features = "all",
							},
							check = {
								command = "clippy",
							},
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
				}
			elseif server_name == "helm_ls" then
				opts = {
					cmd = { "helm_ls", "serve" },
					filetypes = { "helm" },
					root_dir = lspconfig.util.root_pattern("Chart.yaml"),
				}
			elseif server_name == "yamlls" then
				opts = {
					cmd = { "yaml-language-server", "--stdio" },
					filetypes = { "yaml", "yml" },
					on_attach = function(client, bufnr)
						-- wait 1 ms before checking to wait for the helm lsp to set the filetype
						vim.defer_fn(function()
							-- if the buffer is a helm file, detach the yamlls client
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

								-- kubernetes = "*.yaml",
								-- ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
								-- ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
								-- ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
								-- ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
								-- ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
								-- ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
								-- ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
								-- ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
								-- ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
								-- ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
								-- ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
								-- ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
								-- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
								-- ["https://raw.githubusercontent.com/vscode-kubernetes-tools/vscode-kubernetes-tools/master/syntaxes/helm.tmLanguage.json"] = "/charts/*.yaml",
								-- ['https://raw.githubusercontent.com/docker/cli/master/cli/compose/schema/data/config_schema_v3.9.json'] = '/docker-compose.yml',
								-- ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/charts/*",
							},
						},
					},
				}
			end
			opts.capabilities = capabilities

			lspconfig[server_name].setup(opts)
		end,
	})

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
					vim.lsp.buf.format({
						buffer = opts.buffer,
						async = false,
					})
				end,
			})
		end,
	})
end

return M
