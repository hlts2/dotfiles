-- mason.nvim: Package manager for LSP servers/formatters
return {
	"williamboman/mason.nvim",
	cmd = {
		"Mason",
		"MasonInstall",
		"MasonInstallAll",
		"MasonUninstall",
		"MasonUninstallAll",
		"MasonLog",
	},
	config = function()
		require("mason").setup({
			max_concurrent_installers = 15,
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
	end,
}
