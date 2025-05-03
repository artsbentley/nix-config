{ inputs, pkgs, lib, hostConfig, userConfig, ... }:
{
  environment.launchDaemons."limit.maxfiles.plist" = {
    enable = true;
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
      "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
      <key>Label</key>
      <string>limit.maxfiles</string>
      <key>ProgramArguments</key>
      <array>
      <string>launchctl</string>
      <string>limit</string>
      <string>maxfiles</string>
      <string>524288</string>
      <string>524288</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>ServiceIPC</key>
      <false/>
      </dict>
      </plist>
    '';
  };

  #  # STYLIX
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  stylix.targets = {
    tmux.enable = false;
    yazi.enable = false;
    wezterm.enable = false;

    waybar.enable = true;
    firefox.enable = true;
    gnome.enable = true;
    hyprland.enable = true;
    rofi.enable = true;
  };


  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    optimise.automatic = true;
    package = pkgs.nix;
  };

  # User configuration
  users.users.${userConfig.name} = {
    name = "${userConfig.name}";
    home = "/Users/${userConfig.name}";
  };

  # Enable sudo authentication with TouchID
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    activationScripts = {
      extraActivation = {
        enable = true;
        # Many of these taken from https://github.com/mathiasbynens/dotfiles/blob/master/.macos
        text = ''
          # Show the ~/Library folder
          #chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

          # Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
          # defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

          # Display emails in threaded mode, sorted by date (newest at the top)
          defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
          defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "no"
          defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"
          		'';
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      finder = {
        _FXShowPosixPathInTitle = true;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        FXPreferredViewStyle = "clmv"; # set list view as default Finder view
        ShowPathbar = true;
        ShowStatusBar = true;
        QuitMenuItem = true; # Allow quitting Finder from the menu
        # FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
      };

      NSGlobalDomain.AppleShowAllExtensions = true; # show all file extensions in Finder
      LaunchServices.LSQuarantine = false; # Disable quarantine for downloaded files

      NSGlobalDomain.KeyRepeat = 1; # key repeat rate
      NSGlobalDomain.InitialKeyRepeat = 10; # key repeat initial delay

      NSGlobalDomain."com.apple.sound.beep.volume" = 0.000; #disable beep

      NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false; # disable period after double-space
      NSGlobalDomain._HIHideMenuBar = true; # hide the menu bar
      NSGlobalDomain.NSWindowShouldDragOnGesture = true; # allows to drag windows from anywhere
      NSGlobalDomain."com.apple.trackpad.scaling" = 3.0; # trackpad speed 1 to 3

      trackpad.Clicking = true; # enable tap to click
      trackpad.TrackpadThreeFingerDrag = true; # enable three finger drag
      trackpad.Dragging = true; # enable dragging items by tapping trackpad
      trackpad.TrackpadRightClick = true;

      # universalaccess.closeViewScrollWheelToggle = true; # use scroll gesture with the Ctrl (^) modifier key to zoom
      # universalaccess.reduceMotion = true; # disable animations

      dock = {
        autohide = true; # autohide dock
        autohide-delay = 0.0;
        show-recents = false; # hide recent apps in dock
        magnification = false; # disable dock magnification
        tilesize = 70; # dock icons normal size
        mineffect = "scale"; # dock minimize/maximize effect
        mru-spaces = false; # disable automatic space sort by recent use
      };

      screencapture.disable-shadow = true; # disable shadows when screenshotting windows
      menuExtraClock.Show24Hour = true; # show 24 hour clock

    };
    activationScripts.postUserActivation.text = ''
      # Following line should allow us to avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      # launchctl stop com.apple.Dock.agent
      # launchctl start com.apple.Dock.agent
    '';
  };
}



