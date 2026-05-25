return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    require("fzf-lua").setup({ "fzf-native" })
    vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>")
    vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>")
    vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>")
    vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>")
  end,
}
