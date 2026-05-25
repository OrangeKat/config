return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.icons").setup({})
    MiniIcons.tweak_lsp_kind()

    require("mini.git").setup({})
    require("mini.diff").setup({})
    require("mini.statusline").setup({})
    require("mini.pairs").setup({})
    require("mini.indentscope").setup({})
  end,
}
