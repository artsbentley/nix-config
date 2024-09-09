{ inputs, lib, config, pkgs, ... }:
{
  #  age.secrets.gitIncludes = {
  #    file = ../../secrets/gitIncludes.age;
  #    path = "$HOME/.config/git/includes";
  #  };

  programs.git = {
    enable = true;
    userName = "artsbentley";
    userEmail = "artsbentley@gmail.com";
    delta = {
      enable = true;
      # options = {
      #   navigate = true;
      #   line-numbers = true;
      #   # syntax-theme = "gruvbox-dark";
      #   syntax-theme = config.programs.bat.config.theme;
      #   dark = true;
      #   side-by-side = true;
      #   hyperlinks = true;
      # };
      options = {
        features = "hyperlinks";
        file-added-label = "[+]";
        file-copied-label = "[C]";
        file-decoration-style = "yellow ul";
        file-modified-label = "[M]";
        file-removed-label = "[-]";
        file-renamed-label = "[R]";
        file-style = "yellow bold";
        hunk-header-decoration-style = "omit";
        hunk-header-style = "syntax italic #303030";
        minus-emph-style = "syntax bold #780000";
        minus-style = "syntax #400000";
        plus-emph-style = "syntax bold #007800";
        plus-style = "syntax #004000";
        syntax-theme = config.programs.bat.config.theme;
        width = 1;
      };
    };
    aliases = {
      cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
    };
    extraConfig = {
      branch.autosetuprebase = "always";
      color.ui = true;
      core = {
        excludesfile = "~/.config/git/ignore";
        autocrlf = "input";
      };
      init = {
        defaultBranch = "main";
      };
    };

    # extraConfig = {
    #   core = {
    #     sshCommand = "ssh -o 'IdentitiesOnly=yes' -i ~/.ssh/arar";
    #   };
    # };
    #    includes = [
    #      {
    #        path = "~" + (lib.removePrefix "$HOME" config.age.secrets.gitIncludes.path);
    #        condition = "gitdir:~/Workspace/Projects/";
    #      }
    #    ];
  };

  home.file = {
    ".config/git/ignore".source = ./config/ignore;
  };
}

