#-------------------------------------------------------------------------------
# GENERAL
#-------------------------------------------------------------------------------

set -U fish_key_bindings fish_vi_key_bindings
bind -M insert \e\C-h backward-kill-word
set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git'"

#-------------------------------------------------------------------------------
# SSH Agent
#-------------------------------------------------------------------------------
function __ssh_agent_is_started -d "check if ssh agent is already started"
    if begin
            test -f $SSH_ENV; and test -z "$SSH_AGENT_PID"
        end
        source $SSH_ENV >/dev/null
    end

    if test -z "$SSH_AGENT_PID"
        return 1
    end

    ssh-add -l >/dev/null 2>&1
    if test $status -eq 2
        return 1
    end
end

function __ssh_agent_start -d "start a new ssh agent"
    ssh-agent -c | sed 's/^echo/#echo/' >$SSH_ENV
    chmod 600 $SSH_ENV
    source $SSH_ENV >/dev/null
    ssh-add
end

if not test -d $HOME/.ssh
    mkdir -p $HOME/.ssh
    chmod 0700 $HOME/.ssh
end

if test -d $HOME/.gnupg
    chmod 0700 $HOME/.gnupg
end

if test -z "$SSH_ENV"
    set -xg SSH_ENV $HOME/.ssh/environment
end

if not __ssh_agent_is_started
    __ssh_agent_start
end

#-------------------------------------------------------------------------------
# Ghostty Shell Integration
#-------------------------------------------------------------------------------
# Ghostty supports auto-injection but Nix-darwin hard overwrites XDG_DATA_DIRS
# which make it so that we can't use the auto-injection. We have to source
# manually.
if set -q GHOSTTY_RESOURCES_DIR
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
end

#-------------------------------------------------------------------------------
# Programs
#-------------------------------------------------------------------------------
# Vim: We should move this somewhere else but it works for now
mkdir -p $HOME/.vim/{backup,swap,undo}

# Homebrew
if test -d /opt/homebrew
    set -gx HOMEBREW_PREFIX /opt/homebrew

    set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar

    set -gx HOMEBREW_REPOSITORY /opt/homebrew

    set -q PATH; or set PATH ''
    set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH

    set -q MANPATH; or set MANPATH ''
    set -gx MANPATH /opt/homebrew/share/man $MANPATH

    set -q INFOPATH; or set INFOPATH ''
    set -gx INFOPATH /opt/homebrew/share/info $INFOPATH

end

# Hammerspoon
if test -d "/Applications/Hammerspoon.app"
    set -q PATH; or set PATH ''
    set -gx PATH "/Applications/Hammerspoon.app/Contents/Frameworks/hs" $PATH

end

# Add ~/.local/bin
set -q PATH; or set PATH ''
set -gx PATH "$HOME/.local/bin" $PATH

#-------------------------------------------------------------------------------
# Prompt
#-------------------------------------------------------------------------------
# Do not show any greeting
set --universal --erase fish_greeting
function fish_greeting
end

# Gruvbox Material Dark Palette for fish shell
# Standard prompt colors
set -U fish_color_normal "#ebdbb2"
set -U fish_color_command "#fabd2f" --bold
set -U fish_color_quote "#8ec07c"
set -U fish_color_redirection "#f2594b"
set -U fish_color_end "#b8bb26"
set -U fish_color_error "#f2594b"
set -U fish_color_param "#d3869b"
set -U fish_color_variable "#83a598"
set -U fish_color_comment "#928374"
set -U fish_color_match --background="#3c3836"
set -U fish_color_selection white --bold --background="#3c3836"
set -U fish_color_search_match "#d65d0e" --background="#3c3836"
set -U fish_color_autosuggestion "#928374"
set -U fish_color_cancel "#f2594b"
set -U fish_color_cwd "#b8bb26"
set -U fish_color_cwd_root "#f2594b"
set -U fish_color_escape "#83a598"
set -U fish_color_history_current --bold "#fe8019"
set -U fish_color_host "#d5c4a1"
set -U fish_color_host_remote "#fabd2f"
set -U fish_color_operator "#8ec07c"
set -U fish_color_status "#f2594b"
set -U fish_color_user "#b8bb26"
set -U fish_color_valid_path --underline "#d5c4a1"

# Set the terminal cursor color.
# This escape sequence tells the terminal to use the command color.
# printf '\e]12;#fabd2f\a'
printf '\e[6 q'

#-------------------------------------------------------------------------------
# YAZI
#-------------------------------------------------------------------------------
function ya
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
alias :Yazi="ya"

#-------------------------------------------------------------------------------
# Vars
#-------------------------------------------------------------------------------
# Modify our path to include our Go binaries
contains $HOME/code/go/bin $fish_user_paths; or set -Ua fish_user_paths $HOME/code/go/bin
contains $HOME/bin $fish_user_paths; or set -Ua fish_user_paths $HOME/bin

# Exported variables
if isatty
    set -x GPG_TTY (tty)
end

# Editor
set -gx EDITOR nvim

if test -f $HOME/api_keys.fish
    source $HOME/api_keys.fish
end

#-------------------------------------------------------------------------------
# NOTES
#-------------------------------------------------------------------------------
# if test -d /Users/arar/notes; and test -d /home/arar; and test (uname) = Linux
#     if not test -e /home/arar/notes
#         ln -s /Users/arar/notes /home/arar/notes
#     end
# end

#-------------------------------------------------------------------------------
# PATH
#-------------------------------------------------------------------------------
fish_add_path $HOME/.config/scripts/
fish_add_path $HOME/.local/share/nvim/mason/bin/
set -x STU_ROOT_DIR "$XDG_CONFIG_HOME/stu"
set -x RAINFROG_CONFIG "$XDG_CONFIG_HOME/rainfrog"

if test (uname) = Darwin
    fish_add_path ~/.orbstack/bin
end

# orbstack 
if test -d /opt/orbstack-guest
    set -x PATH $PATH /opt/orbstack-guest/bin

    # automatically trigger the macOS host to open links
    set -x BROWSER /opt/orbstack-guest/bin/open
end

#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------
# Shortcut to setup a nix-shell with fish. This lets you do something like
# `fnix -p go` to get an environment with Go but use the fish shell along
# with it.
alias fnix "nix-shell --run fish"
