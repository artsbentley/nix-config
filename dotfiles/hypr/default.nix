{ pkgs, config, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [ ",highres,auto,auto" ];

      env = {
        "XCURSOR_SIZE" = "24";
        "HYPRCURSOR_SIZE" = "24";
      };

      general = {
        gaps_in = 2;
        gaps_out = 5;
        border_size = 1;
        # "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        # "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          # color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      input = {
        kb_layout = "us";
        repeat_delay = 200;
        repeat_rate = 50;
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = false;
      };

      gestures.workspace_swipe = false;

      device."epic-mouse-v1".sensitivity = -0.5;

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bind = [
        "ALT, M, movefocus, l"
        "ALT, N, movefocus, d"
        "ALT, E, movefocus, u"
        "ALT, I, movefocus, r"
        "ALT, left, movefocus, l"
        "ALT, down, movefocus, d"
        "ALT, up, movefocus, u"
        "ALT, right, movefocus, r"
        "ALT SHIFT, M, movewindow, l"
        "ALT SHIFT, N, movewindow, d"
        "ALT SHIFT, E, movewindow, u"
        "ALT SHIFT, I, movewindow, r"
        "ALT SHIFT, left, movewindow, l"
        "ALT SHIFT, down, movewindow, d"
        "ALT SHIFT, up, movewindow, u"
        "ALT SHIFT, right, movewindow, r"
        "ALT, Q, killactive"
        "ALT SHIFT, Q, exit"
        "ALT, SPACE, exec, wofi --show drun"
        "ALT, Return, exec, wezterm"
        "ALT SHIFT, SPACE, togglefloating"
        "ALT, F, fullscreen"
        "ALT, tab, workspace, previous"
        ", Print, exec, grimblast copy area"
        "SHIFT, Print, exec, grimblast copy active"
        "ALT, Print, exec, grimblast copy screen"
        "ALT, D, exec, rofi -show drun -show-icons"
        "ALT, 3, workspace, 3"
        "ALT, 4, workspace, 4"
        "ALT, C, workspace, name:chat"
        "ALT, G, workspace, name:messaging"
        "ALT, P, workspace, name:media"
        "ALT, R, workspace, name:reading"
        "ALT, S, workspace, name:web"
        "ALT, T, workspace, name:terminal"
        "ALT, V, workspace, name:files"
        "ALT, W, workspace, name:notes"
        "ALT, X, workspace, name:mail"
        "ALT, Z, workspace, name:meetings"
        "ALT SHIFT, 3, movetoworkspace, 3"
        "ALT SHIFT, 4, movetoworkspace, 4"
        "ALT SHIFT, C, movetoworkspace, name:chat"
        "ALT SHIFT, G, movetoworkspace, name:messaging"
        "ALT SHIFT, P, movetoworkspace, name:media"
        "ALT SHIFT, R, movetoworkspace, name:reading"
        "ALT SHIFT, S, movetoworkspace, name:web"
        "ALT SHIFT, T, movetoworkspace, name:terminal"
        "ALT SHIFT, V, movetoworkspace, name:files"
        "ALT SHIFT, W, movetoworkspace, name:notes"
        "ALT SHIFT, X, movetoworkspace, name:mail"
        "ALT SHIFT, Z, movetoworkspace, name:meetings"
      ];

      binde = [
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        "ALT, K, resizeactive, -70 0"
        "ALT, H, resizeactive, 70 0"
        "ALT SHIFT, K, resizeactive, 0 -70"
        "ALT SHIFT, H, resizeactive, 0 70"
      ];

      bindl = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      windowrule = [
        "workspace name:terminal,^(Wezterm)$"
        "workspace name:web,^(firefox)$"
        "workspace name:web,^(Microsoft-edge)$"
        "workspace name:messaging,^(WhatsApp)$"
        "workspace name:messaging,^(Signal)$"
        "workspace name:messaging,^(Telegram)$"
        "workspace name:media,^(Spotify)$"
        "workspace name:chat,^(Slack)$"
        "workspace name:mail,^(Mail)$"
        "workspace name:meetings,^(zoom)$"
        "workspace name:meetings,^(Microsoft Teams)$"
        "workspace name:notes,^(obsidian)$"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };
}

