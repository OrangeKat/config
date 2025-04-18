local wk = require('which-key')
wk.add({
  {"<leader>n", group="Neotree" },
  {"<leader>ns", ':Neotree show right<CR>', desc="Neotree show", mode="n"},
  {"<leader>nf", ':Neotree focus right<CR>', desc="Neotree focus", mode="n"},
  {"<leader>nc", ':Neotree close right<CR>', desc="Neotree close", mode="n"},
})
