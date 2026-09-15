-- Plugin specs live one file per plugin under these category directories.
-- lazy.nvim imports every file in them, so a new file needs no registration here.
return {
	{ import = "plugins.ui" },
	{ import = "plugins.editor" },
	{ import = "plugins.lsp" },
	{ import = "plugins.lang" },
	{ import = "plugins.tools" },
}
