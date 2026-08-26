local ok, lspinstall = pcall(require, 'lspinstall')
if not ok then return end -- nvim-lspinstall is unmaintained; use :LspInstall via nvim-lspconfig instead
lspinstall.setup() -- important

local servers = lspinstall.installed_servers()
for _, server in pairs(servers) do
  if server == 'tsserver' then server = 'ts_ls' end
  pcall(function() require'lspconfig'[server].setup{} end)
end

