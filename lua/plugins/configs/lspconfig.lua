local present_1, lspconfig       = pcall(require, "lspconfig")
local present_2, mason_lspconfig = pcall(require, "mason-lspconfig")

if not present_1 then
  vim.notify("failed to load: lspconfig", "error", {
    title = "plugins.configs.lspconfig",
  })
  return
end

if not present_2 then
  vim.notify("failed to load: mason-lspconfig", "error", {
    title = "plugins.configs.lspconfig",
  })
  return
end

local handlers = {}

handlers.on_attach = function(client, _)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  -- utils.load_mappings("lspconfig", { buffer = bufnr })
end

handlers.capabilities = vim.lsp.protocol.make_client_capabilities()

handlers.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local config = {
  update_in_insert = true,
  underline = true,
  severity_sort = true,
}

vim.diagnostic.config(config)

local servers = {
  "sumneko_lua",
  "rust_analyzer",
  "texlab",
  "clangd",
  "cssls",
  "cssmodules_ls",
  "emmet_ls",
  "html",
  "tsserver",
}

mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local opts = {}
for _, server in pairs(servers) do
  -- set default opts
  opts = {
    on_attach    = handlers.on_attach,
    capabilities = handlers.capabilities,
  }

  if server == "sumneko_lua" then
    local sumneko_lua_opts = require("plugins.server_opts.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_lua_opts, opts)
  end

  if server == "tsserver" then
    local tsserver_opts = require "plugins.server_opts.tsserver"
    opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end

  if server == "emmet_ls" then
    local emmet_ls_opts = require "plugins.server_opts.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  server = vim.split(server, "@")[1]
  lspconfig[server].setup(opts)
end
