{ pkgs, lib, ...}:
{
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-illuminate
      vim-numbertoggle
      {
        plugin = nvim-web-devicons;
        type = "lua";
        config = /* lua */ ''
          require('nvim-web-devicons').setup()
        '';
      }
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = /* lua */ ''
          require('nvim-tree').setup()
        '';
      }
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = /* lua */ ''
          require('nvim-autopairs').setup()
        '';
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = /* lua */ ''
          require('lualine').setup()
        '';
      }
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = /* lua */ ''
          require('bufferline').setup{}
        '';
      }
      {
        plugin = scope-nvim;
        type = "lua";
        config = /* lua */ ''
          require('scope').setup{}
        '';
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = /* lua */ ''
          require('which-key').setup{}
        '';
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = /* lua */ ''
          require('ibl').setup{}
        '';
      }
        {
        plugin = nvim-colorizer-lua;
        type = "lua";
        config = /* lua */ ''
          require('colorizer').setup{}
        '';
      }
      {
        plugin = fidget-nvim;
        type = "lua";
        config = /* lua */ ''
          require('fidget').setup{
            text = {
              spinner = "dots",
            },
          }
        '';
      }
    ];
  };
}