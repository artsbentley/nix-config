{ inputs, lib, config, pkgs, ... }:

{
  programs.neovim = {
    extraLuaPackages = (ps: with ps; [ luarocks rocks-nvim ]);
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
