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
        syntax-theme = config.programs.bat.config.theme;
        dark = true;
        side-by-side = true;
        hyperlinks = true;
      };
    };
    aliases = {
      cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
    };
    extraConfig = {
      # credential.helper = "gh";
      rebase.updateRefs = true;
      branch.autosetuprebase = "always";
      color.ui = true;
      core = {
        excludesfile = "~/.config/git/ignore";
        autocrlf = "input";
      };
      init = {
        defaultBranch = "main";
      };
      pull.rebase = true;
      push.default = "tracking";
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

