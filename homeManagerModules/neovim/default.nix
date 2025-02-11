{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    lua-language-server
  ];

  programs.neovim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      wl-clipboard
      xclip
    ];

    extraLuaConfig = ''${builtins.readFile ./options.lua}'';

    plugins = with pkgs.vimPlugins; [
      telescope-fzf-native-nvim
      undotree # TODO KEYMAP <leader>u
      plenary-nvim
      friendly-snippets

      {
        plugin = kanagawa-nvim;
        config = "colorscheme kanagawa";
      }

      {
        plugin = mini-statusline;
        config = toLuaFile ./plugins/mini.lua;
      }

      {
        plugin = mini-pairs;
        config = toLua "require('mini.pairs').setup()";
      }

      {
        plugin = mini-icons;
        config = toLua "require('mini.icons').setup()";
      }

      {
        plugin = oil-nvim;
        config = toLuaFile ./plugins/oil.lua;
      }

      {
        plugin = nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
        ]);
        config = toLuaFile ./plugins/treesitter.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugins/telescope.lua;
      }

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./plugins/lsp.lua;
      }

      {
        plugin = blink-cmp;
        config = toLuaFile ./plugins/blink.lua;
      }

      {
        plugin = harpoon2;
        config = toLuaFile ./plugins/harpoon.lua;
      }
    ];
  };
}
