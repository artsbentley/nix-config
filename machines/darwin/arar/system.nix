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

  # Enable sudo authentication with TouchID
  security.pam.enableSudoTouchIdAuth = true;

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
      keyboard = {
        remapCapsLockToEscape.enable = true;
      };
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

      # show all file extensions in Finder
      NSGlobalDomain.AppleShowAllExtensions = true;

      # key repeat initial delay
      NSGlobalDomain.InitialKeyRepeat = 10;

      # Disable quarantine for downloaded files
      LaunchServices.LSQuarantine = false;


      # key repeat rate
      NSGlobalDomain.KeyRepeat = 1;

      #disable beep
      NSGlobalDomain."com.apple.sound.beep.volume" = 0.000;

      # disable period after double-space
      NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
      NSGlobalDomain._HIHideMenuBar = true;

      # enable tap to click
      trackpad.Clicking = true;

      # enable three finger drag
      trackpad.TrackpadThreeFingerDrag = true;

      # autohide dock
      dock.autohide = true;
      dock.autohide-delay = 0.0;

      # disable dock magnification
      dock.magnification = false;

      # dock icons normal size
      dock.tilesize = 70;

      # dock minimize/maximize effect
      dock.mineffect = "scale";

      # disable automatic space sort by recent use
      dock.mru-spaces = false;

      # hide recent apps in dock
      dock.show-recents = true;


      # disable shadows when screenshotting windows
      screencapture.disable-shadow = true;

    };
    activationScripts.postUserActivation.text = ''
      # Following line should allow us to avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      # launchctl stop com.apple.Dock.agent
      # launchctl start com.apple.Dock.agent
    '';
  };
}



