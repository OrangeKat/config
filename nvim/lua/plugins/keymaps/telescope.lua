local builtin = require("telescope.builtin")
local wk = require("which-key")

wk.add({
  {"<leader>f", group="Find" },
  {"<leader>ff", builtin.find_files, desc="Find files", mode="n"},
  {"<leader>fg", builtin.find_grep, desc="Find grep", mode="n"},
  {"<leader>fd", ":Telescope diagnostics<CR>", desc="Find diagnostics", mode="n"},
})
