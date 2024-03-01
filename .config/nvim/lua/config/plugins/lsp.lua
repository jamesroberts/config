-- -- [[ Configure LSP ]]
-- --  This function gets run when an LSP connects to a particular buffer.
-- local on_attach = function(_, bufnr)
--     local nmap = function(keys, func, desc)
--         if desc then
--             desc = 'LSP: ' .. desc
--         end
--
--         vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--     end
--     local builtin = require('telescope.builtin')
--     nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--     nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--     nmap('<leader>cf', vim.lsp.buf.format, '[C]ode [F]ormat')
--
--     nmap('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
--     nmap('gr', builtin.lsp_references, '[G]oto [R]eferences')
--     nmap('gi', builtin.lsp_implementations, '[G]oto [I]mplementation')
--     nmap('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
--     nmap('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
--     nmap('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
--     -- See `:help K` for why this keymap
--     nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--     nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
-- end
--
-- local configure = function()
--     require('mason').setup()
--     require('mason-lspconfig').setup()
--
--     local servers = {
--         clangd = {},
--         pyright = {},
--         rust_analyzer = {},
--         tsserver = {},
--         smithy_ls = {},
--         jdtls = {},
--         kotlin_language_server = {},
--         lua_ls = {
--             Lua = {
--                 workspace = { checkThirdParty = false },
--                 telemetry = { enable = false },
--             },
--         },
--     }
--
--     require('neodev').setup()
--
--     local capabilities = vim.lsp.protocol.make_client_capabilities()
--     capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
--     local mason_lspconfig = require 'mason-lspconfig'
--
--     mason_lspconfig.setup {
--         ensure_installed = vim.tbl_keys(servers),
--     }
--
--     mason_lspconfig.setup_handlers {
--         function(server_name)
--             require('lspconfig')[server_name].setup {
--                 capabilities = capabilities,
--                 on_attach = on_attach,
--                 settings = servers[server_name],
--                 filetypes = (servers[server_name] or {}).filetypes,
--             }
--         end,
--     }
-- end
--
-- return {
--     {
--         'neovim/nvim-lspconfig',
--         dependencies = {
--             'williamboman/mason-lspconfig.nvim',
--             { 'williamboman/mason.nvim',  config = true },
--             { 'j-hui/fidget.nvim',        tag = 'legacy',      opts = {} },
--             { 'simrat39/rust-tools.nvim', opts = {} },
--         },
--         config = configure,
--         opts = {
--             autoformat = false,
--         }
--     },
-- }

-- LSP Configuration & Mason Plugins
return {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('group-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local builtin = require('telescope.builtin')
          map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
          map('gr', builtin.lsp_references, '[G]oto [R]eferences')
          map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        clangd = {},
        pyright = {},
        rust_analyzer = {},
        tsserver = {},
        smithy_ls = {},
        jdtls = {},
        kotlin_language_server = {},
        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('mason').setup()

      -- Add other tools here that you want Mason to install
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'jq',
        'kotlin-language-server',
        'lua-language-server',
        'markdownlint-cli2',
        'openjdk-17',
        'vale',
        'vale-ls',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  }
