return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    require("oil").setup({
      columns = { "icon" },
      keymaps = {
        ["<CR>"] = "actions.select",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
      },
      view_options = {
        show_hidden = true,
      },
    })
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open oil" })
  end,
}
