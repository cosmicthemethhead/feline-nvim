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

local servers = {
  "sumneko_lua",
  "rust_analyzer",
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

  server = vim.split(server, "@")[1]
  lspconfig[server].setup(opts)
end
