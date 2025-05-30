# Generated by OrbStack.
# This MAY be overwritten in the future. Make a copy and update the include
# in configuration.nix if you want to keep your changes.

{ lib, config, pkgs, ... }:

with lib;

{
  # sudoers
  security.sudo.extraRules = [
    {
      users = [ "arar" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # add OrbStack CLI tools to PATH
  environment.shellInit = ''
    . /opt/orbstack-guest/etc/profile-early

    # add your customizations here

    . /opt/orbstack-guest/etc/profile-late
  '';

  # timezone
  time.timeZone = "Europe/Amsterdam";

  # resolv.conf: NixOS doesn't use systemd-resolved

  # faster DHCP - OrbStack uses SLAAC exclusively
  networking.dhcpcd.extraConfig = ''
    noarp
    noipv6
  '';


  # systemd
  systemd.services."systemd-oomd".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-userdbd".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-udevd".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-timesyncd".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-timedated".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-portabled".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-nspawn@".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-machined".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-localed".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-logind".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-journald@".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-journald".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-journal-remote".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-journal-upload".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-importd".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-hostnamed".serviceConfig.WatchdogSec = 0;
  systemd.services."systemd-homed".serviceConfig.WatchdogSec = 0;

  # ssh config
  programs.ssh.extraConfig = ''
    Include /opt/orbstack-guest/etc/ssh_config
  '';

  # extra certificates
  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
      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
      l4RlmUpM3qj3rdlDnGKQkin4gLmS
      -----END CERTIFICATE-----

      -----BEGIN CERTIFICATE-----
      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
      hjWdXe5OGdB6nXeJj8eazHEnpz8=
      -----END CERTIFICATE-----

      -----BEGIN CERTIFICATE-----
      MIIFxjCCA66gAwIBAgIUc/5i+O46H6JnafuL0twqvvNN4bUwDQYJKoZIhvcNAQEL
      BQAwUjELMAkGA1UEBhMCTkwxHTAbBgNVBAoMFEtvbmlua2xpamtlIEtQTiBOLlYu
      MSQwIgYDVQQDDBtLUE4gTi5WLiBQcml2YXRlIFJvb3QgQ0EgRzMwHhcNMjExMDI2
      MDkwODUyWhcNNDYxMDIwMDkwODUxWjBSMQswCQYDVQQGEwJOTDEdMBsGA1UECgwU
      S29uaW5rbGlqa2UgS1BOIE4uVi4xJDAiBgNVBAMMG0tQTiBOLlYuIFByaXZhdGUg
      Um9vdCBDQSBHMzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAJatwfMq
      4Jxg1hROk7yqtFDUWm9hTrwUGehYIYTwN3JdfOSSAAyBT+A5qt9qeBfNj3Euk9sZ
      1uva8sUXz+YsHt3hpmfkzPsp1OM1O+zMOlzrlTuLXed4c3xGhmSheftkFIYd+WDe
      9XFpwocuExd+FTJIdTTPYOr3l7o1KpY0arzsJFGyHwWPvJFVRzQWis6iURZIDtGt
      rtla+qCWVe/aDfZCkUEX3C9rwnAnA5jv98HmfNJuZGl8hSgl6xYolTOwwgn7nl5R
      +Y8G1eRy8HONGdUHXYBk+eLoPllZ4L3cdZW4Df+3vaWzRQm+ROFz0ZQTWnI5+pBO
      M2VBUQnV4z8mcqQedkNG1uMdEGB2mki7aGA3Qb21DnbaSoTXO5gSjIuCekyAg5ir
      7WWzJzL4bfuQlt+gvcsF8p4fHWAf3cWezGQGjsk7u5iCVz6O6EW/tL1Y3DFZ6tXq
      5q+f6GYsBt/7BTPg5ff1uuz2+EnB24eQlRcV5TlqnIgOjQku3ajO9MNtktyYb8wn
      KaqatHaDoTibTXwkQmTdzSytiGfbn8RYUsgilr2IZ/NC2L3LJ7s0rM9reCXQ1h/g
      skk5lUoV0eyDNXnjQqk5J7eT56OEcsbVsnMjfqVqm+LxrsfN2//9trJnk3sqPe/T
      vXz1/r26DF/00lkOt+n5HRXUdmWkaB1ZgmzjAgMBAAGjgZMwgZAwEgYDVR0TAQH/
      BAgwBgEB/wIBATBLBgNVHSAERDBCMEAGBFUdIAAwODA2BggrBgEFBQcCARYqaHR0
      cHM6Ly9jZXJ0aWZpY2FhdC5rcG4uY29tL0NQUy9LUE5Qcml2YXRlMB0GA1UdDgQW
      BBQXRBVNk+R6VKu95URvNM9nb3awXDAOBgNVHQ8BAf8EBAMCAQYwDQYJKoZIhvcN
      AQELBQADggIBAHundNFZ8euHG40sFptyjs6BaJ7b62xWyMe7/2fr2UFCoyxv68kc
      rdIHRJaL40kbzu9COB7qGajhxBnECkYTubzATy6DyGYW3MwqqAIUvlI9ikl5QM95
      B2OiqoT32zmL9ipro2WgccITIKdLqK1hgyaj/kS8mD/7uN+ar1x/F+S7ySDImfoU
      T0dkn/wCojlzEuMgSqylXegmNPbS9s6utP5r+XthUrFvmg4mLh1gSySRJMOKr36m
      SvsjPFdFzIe4DraQiK5kgboejXCDGWsX/1NUJ48ywBD2o4RivdxvrJZFV9o6/H5y
      UfTXbr06e/yMS059QQVaaaVwCcaVeRDF0ROj6fVWUD/qqWVVzb5keZZuEhFJ83tV
      pL0LnO0grRHTYc0me0KlDztAFuRkiSWAnA/+tfKugG/ywUmUzZXo755h5jvrGskq
      QrF1U5ifJJv/vdny7+NvqnPNLsORKD2w/OUUSbAZAGFNFbS5tqizuVkoA9CEx6N1
      e1IdlpahHgUiM6nZKAhHGL0qWndn6otWADZva735gktZpxip1UXt22ZAhI/nhSEn
      /kLqqMN+SfiOlviqpJ3j3s0tBGgNCWI5kKyKUP53v6Mk30MZolA16eMfnEUvcjY5
      a5ODEyvTOHPmbJwdiQotAtFn93tZnUU/KXFEDkQ+rT6j4bAt+C5p9F9b
      -----END CERTIFICATE-----

      -----BEGIN CERTIFICATE-----
      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
      ei5KfcfbUsv/g1CUsTyFHUQUdMoZ4MVtg0rN
      -----END CERTIFICATE-----

      -----BEGIN CERTIFICATE-----
      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
      l4RlmUpM3qj3rdlDnGKQkin4gLmS
      -----END CERTIFICATE-----

      -----BEGIN CERTIFICATE-----
      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
      hjWdXe5OGdB6nXeJj8eazHEnpz8=
      -----END CERTIFICATE-----

      -----BEGIN CERTIFICATE-----
      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
      -----END CERTIFICATE-----

      -----BEGIN CERTIFICATE-----
      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
      ei5KfcfbUsv/g1CUsTyFHUQUdMoZ4MVtg0rN
      -----END CERTIFICATE-----

    ''
  ];

  # indicate builder support for emulated architectures
  nix.extraOptions = "extra-platforms = x86_64-linux i686-linux";
}
