local M = {}

function M.mason_setup()
	require("mason").setup()
end

function M.setup()
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
			"helm_ls",
			"html",
			"jqls",
			"jsonls",
			"lua_ls",
			"pyright",
			"rnix",
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
			elseif server_name == "lua_ls" then
				opts.settings = {
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
				}
			elseif server_name == "rust_analyzer" then
				opts = {
					cmd = { "rust-analyzer" },
					filetypes = { "rust" },
					root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
					settings = {
						["rust-analyzer"] = {
							diagnostics = {
								enable = false,
							},
                            cargo = {
                                buildScripts = {
                                    enable = true,
                                },
                            },
						},
					},
				}
			elseif server_name == "terraformls" then
				opts = {
					cmd = { "terraform-ls", "serve" },
					filetypes = { "terraform", "terraform-vars" },
					root_dir = lspconfig.util.root_pattern(".terraform", ".git"),
				}
			elseif server_name == "yamlls" then
				opts = {
                    cmd = { "yaml-language-server", "--stdio" },
                    filetypes = { "yaml", "yml" },
                    settings = {
                        yaml = {
                            schemas = {
                                -- ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/charts/*",
                                -- ["https://json.schemastore.org/chart.json"] = "/charts/*",
                                -- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
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
		end,
	})
end

return M
