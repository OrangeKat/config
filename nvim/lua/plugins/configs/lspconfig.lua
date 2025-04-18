local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({})

lspconfig.clangd.setup({})

lspconfig.gopls.setup({
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})

lspconfig.pyright.setup({
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off"
      }
    }
  }
})
lspconfig.ruff.setup({})
