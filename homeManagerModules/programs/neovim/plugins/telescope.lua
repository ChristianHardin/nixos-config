-- lua/config/plugins/telescope.lua
require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      ".venv",
      ".git"
    }
  },
  pickers = {
    find_files = {
      theme = "ivy"
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      overrife_generic_sorter = true,
      case_mode = "smart_case",
    }
  }
}
require('telescope').load_extension('fzf')

vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
vim.keymap.set("n", "<space>fd", function()
	require('telescope.builtin').find_files { hidden = true}
end)

vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
vim.keymap.set("n", "<space>fd", function()
  require('telescope.builtin').find_files {
    hidden = true
  }
end)

vim.keymap.set("n", "<space>en", function()
  require('telescope.builtin').find_files {
    hidden = true,
    cwd = "/etc/nixos/"
  }
end)
