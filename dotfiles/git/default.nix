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
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "GitHub";
      };
    };
    init = {
      defaultBranch = "main";
    };
    core = {
      excludesfile = "~/.config/git/ignore";
      autocrlf = "input";
    };
    aliases = {
      cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
    };
    extraConfig = {
      branch.autosetuprebase = "always";
      color.ui = true;
      init.defaultBranch = "main";
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

