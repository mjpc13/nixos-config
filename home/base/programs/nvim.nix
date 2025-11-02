{ lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      theme.enable = true;
      vimAlias = true;

      #Set-up the global and local leaders
      globals.mapleader = " ";
      globals.maplocalleader = ",";

      #Plug-ins
      autopairs.nvim-autopairs.enable = true;
      utility.motion.leap.enable = true; #move efortly
      
      #Fuzzy Finder
      telescope = {
        enable = true;
        mappings = {
          liveGrep = "<leader>fw";
        };
      };

      #Comment lines and blocks of text
      comments.comment-nvim = {
        enable = true;
        mappings = {
          toggleCurrentLine = "<leader>/";
          #toggleCurrentBlock = "<leader>;";

        };
      };

      #Autocomplete and suggestions
      autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
      };

      #Display options after pressing a key
      binds.whichKey = {
        enable = true;
        #setupOpts.preset = "helix";
      };


      #Terminal support
      terminal.toggleterm = {
          enable = true;
          mappings.open = "<leader>tt";

      };

      #File-tree
      filetree.neo-tree.enable = true;


      
      # Visual
      mini = {
        statusline.enable = true;
        icons.enable = true;
        starter.enable = true;
        animate.enable = true;
        notify.enable = true;
      };





      languages = {
        enableTreesitter = true;
        rust = {
          #rust-analyzer has a problem that is about to be fixed in PR #641
          enable =true;
          lsp.enable = true;
        };
        nix = {
          enable = true;
        };
        lua.enable = true;
        clang.enable = true;
        python.enable = true;
      };
    };
    
  };

}