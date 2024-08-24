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
}

