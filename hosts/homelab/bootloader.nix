{ inputs
, hostname
, nixosModules
, userConfig
, hostConfig
, system
, ...
}: {

  # NOTE: this would all be way better to do with disko, currently i have no way
  # to ensure the partition at /dev/sda actually exists, Disko could guarantee
  # this

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
}


# TODO: do this outside of common and with disko 
# boot = lib.mkIf (hostConfig.hasBootloader == true) {
#   loader.grub.enable = true;
#   loader.grub.device = "/dev/sda";
#   loader.grub.useOSProber = true;
#
#   # TODO: decide which booloader to use
#   # kernelPackages = pkgs.linuxKernel.packages.linux_6_14;
#   # consoleLogLevel = 0;
#   # initrd.verbose = false;
#   # kernelParams = [ "quiet" "splash" ];
#   # loader.efi.canTouchEfiVariables = true;
#   # loader.systemd-boot.enable = true;
#   # loader.timeout = 0;
#   # plymouth.enable = true;
#   #
#   # # NOTE: do i need thsi config? probably not
#   # # v4l (virtual camera) module settings
#   # kernelModules = [ "v4l2loopback" ];
#   # extraModulePackages = with config.boot.kernelPackages; [
#   #   v4l2loopback
#   # ];
#   # extraModprobeConfig = ''
#   #   options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
#   # '';
# };


