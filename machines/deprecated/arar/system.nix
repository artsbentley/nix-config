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
    activationScripts.pam.text = true;
    defaults = {

      # show all file extensions in Finder
      NSGlobalDomain.AppleShowAllExtensions = true;
      finder.AppleShowAllExtensions = true;

      # key repeat initial delay
      NSGlobalDomain.InitialKeyRepeat = 15;

      # key repeat rate
      NSGlobalDomain.KeyRepeat = 2;

      #disable beep
      NSGlobalDomain."com.apple.sound.beep.volume" = 0.000;

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
      dock.tilesize = 28;

      # dock minimize/maximize effect
      dock.mineffect = "scale";

      # disable automatic space sort by recent use
      dock.mru-spaces = false;

      # hide recent apps in dock
      dock.show-recents = true;

      # set list view as default Finder view
      finder.FXPreferredViewStyle = "clmv";

      # show Finder path bar
      finder.ShowPathbar = true;

      # show Finder status bar
      finder.ShowStatusBar = true;

      # disable shadows when screenshotting windows
      screencapture.disable-shadow = true;

      finder = {
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
      };
    };
    activationScripts.postUserActivation.text = ''
      # Following line should allow us to avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings - u
      launchctl
      stop
      com.apple.Dock.agent
      launchctl
      start
      com.apple.Dock.agent
    '';
  };
}

