local wk = require('which-key')
wk.add({
  {"<leader>g", group="Code" },
  {"<leader>cc", vim.lsp.buf.hover, desc="Code context", mode="n"},
  {"<leader>ca", vim.lsp.buf.code_action, desc="Code action", mode="n"},
  {"<leader>cr", vim.lsp.buf.rename, desc="Code rename", mode="n"},
  {"<leader>g", group="Goto" },
  {"<leader>gd", vim.lsp.buf.definition, desc="Go to definition", mode="n"},
  {"<leader>gt", vim.lsp.buf.type_definition, desc="Go to type definition", mode="n"},
  {"<leader>gi", vim.lsp.buf.implementation, desc="Go to implementation", mode="n"},
  {"<leader>gn", vim.lsp.buf.goto_next, desc="Go to next", mode="n"},
  {"<leader>gp", vim.lsp.buf.goto_prev, desc="Go to previous", mode="n"},
})

