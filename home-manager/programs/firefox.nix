{ pkgs, ... }: {
  config = {
    programs = {
      # firefox dev edition
      firefox = {
        enable = true;
        package = pkgs.firefox-devedition-bin;
        profiles.arar =
          {
            settings = { };
          };
      };
    };

    # iynaix.persist = {
    #   home.directories = [
    #     ".cache/mozilla"
    #     ".mozilla"
    #   ];
    # };
  };
}
