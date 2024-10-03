{ inputs, lib, config, pkgs, ... }:

{
  programs.neovim = {
    extraLuaPackages = (ps: with ps; [ luarocks rocks-nvim ]);
    extraPackages = with pkgs; [
      tree-sitter
      lua-language-server
      luaformatter
      stylua
      bash-language-server
      dockerfile-language-server-nodejs
      nil
      nixfmt-classic
      black
      pyright
      ruff-lsp
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
