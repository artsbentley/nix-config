{ inputs, lib, config, pkgs, ... }:
let
  program = "nvim";
  filePath = config.home.homeDirectory + "/nix-config/modules/home-manager/dotfiles/${program}/${program}/";
  configSrc = config.lib.file.mkOutOfStoreSymlink filePath;
in
{
  # home.packages = [ pkgs.neovim ];
  xdg.configFile."${program}".source = configSrc;

  programs.neovim = {
    extraLuaPackages = (ps: with ps; [ luarocks rocks-nvim ]);
    extraPackages = with pkgs; [
      tree-sitter
      lua-language-server
      lua_ls
      luaformatter
      stylua
      bash-language-server
      dockerfile-language-server-nodejs
      nil
      nixfmt-classic
      black
      pyright
      ruff-lsp
      marksman
      rustfmt
    ];
    extraWrapperArgs = [
      "--prefix"
      "PATH"
      ":"
      "${lib.makeBinPath [ 
        pkgs.luajit
        pkgs.luajitPackages.luarocks
        pkgs.luajitPackages.rocks-nvim
      ]}"
    ];
  };
}
