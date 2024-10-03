{ inputs, lib, config, pkgs, ... }:

{
  programs.neovim = {
    extraLuaPackages = (ps: with ps; [ luarocks rocks-nvim ]);
    extraPackages = with pkgs; [
      tree-sitter
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
