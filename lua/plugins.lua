local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
		profile = {
			enable = true,
			threshold = 0,
		},
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

	  -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Colorscheme
    use {
      "sainnhe/everforest",
      config = function()
        vim.cmd "colorscheme everforest"
      end,
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- Git
    use {
      "TimUntersberger/neogit",
			cmd = "Neogit",
      config = function()
        require("config.neogit").setup()
      end,
    }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        require("config.whichkey").setup()
      end,
    }

    -- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("config.indentblankline").setup()
      end,
    }

   -- Theme: icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- Comment
    use {
      "numToStr/Comment.nvim",
      opt = true,
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("Comment").setup {}
      end,
    }

    -- Easy hopping
    use {
      "phaazon/hop.nvim",
      cmd = { "HopWord", "HopChar1" },
      config = function()
        require("hop").setup {}
      end,
    }

    -- Easy motion
    use {
      "ggandor/lightspeed.nvim",
      keys = { "s", "S", "f", "F", "t", "T" },
      config = function()
        require("lightspeed").setup {}
      end,
    }

    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" },
    }

    -- Status line
    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = function()
        require("config.lualine").setup()
      end,
      requires = { "nvim-web-devicons" },
    }


			-- Treesitter
use {
  "nvim-treesitter/nvim-treesitter",
  opt = true,
  event = "BufRead",
  run = ":TSUpdate",
  config = function()
    require("config.treesitter").setup()
  end,
  requires = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
  },
}

		
    -- FZF
    use { "junegunn/fzf", run = "./install --all", event = "VimEnter" }
    use { "junegunn/fzf.vim", event = "BufEnter" }

		use {
			"ibhagwan/fzf-lua",
			requires = { "kyazdani42/nvim-web-devicons" },
		}


		use {
			"kyazdani42/nvim-tree.lua",
			requires = {
				"kyazdani42/nvim-web-devicons",
			},
			cmd = { "NvimTreeToggle", "NvimTreeClose" },
				config = function()
					require("config.nvimtree").setup()
				end,
		}

		-- User interface
		use {
			"stevearc/dressing.nvim",
			event = "BufEnter",
			config = function()
				require("dressing").setup {
					select = {
						backend = { "telescope", "fzf", "builtin" },
					},
				}
			end,
		}

use { "nvim-telescope/telescope.nvim", module = "telescope", as = "telescope" }

		-- Buffer line
		use {
			"akinsho/nvim-bufferline.lua",
			event = "BufReadPre",
			wants = "nvim-web-devicons",
			config = function()
				require("config.bufferline").setup()
			end,
		}

		use {
			 "SmiteshP/nvim-navic",
				requires = "neovim/nvim-lspconfig"
		}


    -- Completion
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      wants = { "LuaSnip" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        -- "onsails/lspkind-nvim",
        -- "hrsh7th/cmp-calc",
        -- "f3fora/cmp-spell",
        -- "hrsh7th/cmp-emoji",
        {
          "L3MON4D3/LuaSnip",
          wants = { "friendly-snippets", "vim-snippets" },
          config = function()
            require("config.snip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
      },
    }

-- Auto pairs
use {
  "windwp/nvim-autopairs",
  wants = "nvim-treesitter",
  module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
  config = function()
    require("config.autopairs").setup()
  end,
}

use {
    "williamboman/mason.nvim"
}


    -- LSP
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      -- event = "VimEnter",
      event = { "BufReadPre" },
      -- keys = { "<leader>l", "<leader>f" },
      -- wants = { "nvim-lsp-installer", "lsp_signature.nvim", "cmp-nvim-lsp" },
      wants = {
        "nvim-lsp-installer",
        "cmp-nvim-lsp",
        "lua-dev.nvim",
        "vim-illuminate",
        "null-ls.nvim",
        "schemastore.nvim",
        -- "nvim-lsp-ts-utils",
        "typescript.nvim",
      },
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "williamboman/nvim-lsp-installer",
        "folke/lua-dev.nvim",
        "RRethy/vim-illuminate",
        "jose-elias-alvarez/null-ls.nvim",
        {
          "j-hui/fidget.nvim",
          config = function()
            require("fidget").setup {}
          end,
        },
        "b0o/schemastore.nvim",
        -- "jose-elias-alvarez/nvim-lsp-ts-utils",
        "jose-elias-alvarez/typescript.nvim",
        -- "ray-x/lsp_signature.nvim",
      },
    }




    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end


  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M


