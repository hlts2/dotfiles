-- LSP server configuration.
--
-- nvim 0.11 resolves a server from `lsp/<name>.lua` on the runtimepath, which
-- nvim-lspconfig provides. The vim.lsp.enable() list below is therefore the
-- only thing that starts a server: installing a Mason package no longer enables
-- one by itself, which is how the stylua formatter used to run as a language
-- server (and buf and tflint with it).
--
-- vim.lsp.config() REPLACES list-valued keys (cmd/filetypes/root_markers)
-- rather than merging them, so only override a list to add something the
-- nvim-lspconfig default does not already have. Overriding one to restate the
-- default silently drops whatever the default had and this file does not.
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- mason.nvim puts its bin directory on PATH, so it has to load before
		-- any server starts.
		"williamboman/mason.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		})

		-- Adds typescript/javascript/vue to the default graphql filetypes.
		-- Without workspace_required the widened list started graphql-lsp on
		-- every TypeScript buffer, rootless, in repositories with no graphql
		-- config at all.
		vim.lsp.config("graphql", {
			filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript", "javascript", "vue" },
			workspace_required = true,
		})

		-- Adds default.nix; the default only looks for flake.nix and .git.
		vim.lsp.config("nil_ls", {
			root_markers = { "flake.nix", "default.nix", ".git" },
		})

		-- The lua_ls setup nvim-lspconfig documents for editing Neovim config.
		-- Putting the whole runtimepath in workspace.library is what it warns
		-- against (lspconfig #3189); VIMRUNTIME alone supplies the vim global.
		vim.lsp.config("lua_ls", {
			on_init = function(client)
				local folder = client.workspace_folders and client.workspace_folders[1]
				if folder then
					-- Resolve both sides: stdpath("config") is a symlink into the
					-- dotfiles repo, and the workspace root is a subdirectory of
					-- it whenever a .luarc.json sits below the repo root. Plain
					-- string equality misses both, and this config would then
					-- lose the vim global while editing itself.
					local config_dir = vim.uv.fs_realpath(vim.fn.stdpath("config"))
					local path = vim.uv.fs_realpath(folder.name)
					local editing_own_config = config_dir
						and path
						and (path == config_dir or vim.startswith(path, config_dir .. "/"))

					-- Any other project that ships a .luarc.json owns its settings.
					if
						not editing_own_config
						and (
							vim.uv.fs_stat(folder.name .. "/.luarc.json")
							or vim.uv.fs_stat(folder.name .. "/.luarc.jsonc")
						)
					then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						version = "LuaJIT",
						path = { "lua/?.lua", "lua/?/init.lua" },
					},
					workspace = {
						checkThirdParty = false,
						library = { vim.env.VIMRUNTIME },
					},
					telemetry = { enable = false },
				})
			end,
			settings = { Lua = {} },
		})

		-- nvim-lspconfig's terraformls on_attach calls vim.lsp.codelens.enable(),
		-- which only exists on nvim 0.12. On 0.11 it raises ON_ATTACH_ERROR on
		-- every terraform buffer, so fall back to the refresh API nvim 0.11
		-- documents. The guard drops this override once nvim gains enable().
		vim.lsp.config("terraformls", {
			on_attach = function(_, bufnr)
				if vim.lsp.codelens.enable then
					vim.lsp.codelens.enable(true, { bufnr = bufnr })
					return
				end

				vim.lsp.codelens.refresh({ bufnr = bufnr })
				vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
					group = vim.api.nvim_create_augroup("TerraformCodeLens", { clear = false }),
					buffer = bufnr,
					callback = function()
						vim.lsp.codelens.refresh({ bufnr = bufnr })
					end,
				})
			end,
		})

		-- Python is split between two servers: ruff lints, formats and sorts
		-- imports, basedpyright does types and completion. These settings stop
		-- each one from also doing the other's job.
		vim.lsp.config("basedpyright", {
			settings = {
				basedpyright = {
					-- basedpyright defaults to its stricter "recommended" mode,
					-- which buries real errors in style hints on existing code.
					analysis = { typeCheckingMode = "standard" },
					disableOrganizeImports = true,
				},
			},
		})

		vim.lsp.config("ruff", {
			on_attach = function(client)
				client.server_capabilities.hoverProvider = false
			end,
		})

		vim.lsp.config("yamlls", {
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

		-- rust_analyzer is managed by rustaceanvim, so it is not listed here.
		-- biome and eslint each ship a root_dir that attaches only inside a
		-- project holding their own config file, so both can stay enabled and
		-- the repository decides which one runs.
		vim.lsp.enable({
			"basedpyright",
			"biome",
			"eslint",
			"gopls",
			"graphql",
			"helm_ls",
			"lua_ls",
			"nil_ls",
			"ruff",
			"terraformls",
			"vtsls",
			"yamlls",
			"zls",
		})

		-- Keymaps
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				-- <C-[> is byte 27, the same as <Esc>, so this also makes <Esc>
				-- jump to the definition in normal mode. That is intended: it is
				-- the key this config has always used. <C-]> is Vim's own tag
				-- jump key and is kept pointing at the same place.
				vim.keymap.set("n", "<C-[>", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
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
			end,
		})
	end,
}
