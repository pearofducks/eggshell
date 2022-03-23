# DIRECTORY

setopt AUTO_CD              # auto changes to a directory without typing cd
setopt AUTO_PUSHD           # push the old directory onto the stack on cd
setopt PUSHD_IGNORE_DUPS    # do not store duplicates in the stack
setopt PUSHD_SILENT         # do not print the directory stack after pushd or popd
setopt PUSHD_TO_HOME        # push to home directory when no argument is given
setopt CDABLE_VARS          # change directory to a path stored in a variable
setopt MULTIOS              # write to multiple descriptors
setopt EXTENDED_GLOB        # use extended globbing syntax
setopt GLOB_DOTS            # include dotfiles when globbing

# HISTORY

HISTFILE="$HOME/.local/share/zsh/history"
if [[ ! -f "$HISTFILE" ]]; then
  mkdir -p "$HISTFILE:h" && touch "$HISTFILE"
fi

HISTSIZE=10000
SAVEHIST=8500
setopt APPEND_HISTORY          # append to history file
setopt HIST_NO_STORE           # don't store history commands
setopt HIST_REDUCE_BLANKS      # remove superfluous blanks from each command line being added to the history list
setopt SHARE_HISTORY        # don't share history between all sessions
setopt BANG_HIST               # treat the '!' character specially during expansion
setopt EXTENDED_HISTORY        # write the history file in the ':start:elapsed;command' format
setopt INC_APPEND_HISTORY      # write to the history file immediately, not when the shell exits
setopt HIST_EXPIRE_DUPS_FIRST  # expire a duplicate event first when trimming history
setopt HIST_IGNORE_DUPS        # do not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS    # delete an old recorded event if a new event is a duplicate
setopt HIST_FIND_NO_DUPS       # do not display a previously found event
setopt HIST_IGNORE_SPACE       # do not record an event starting with a space
setopt HIST_SAVE_NO_DUPS       # do not write a duplicate event to the history file
setopt HIST_VERIFY             # do not execute immediately upon history expansion
setopt NO_HIST_BEEP            # don't beep when attempting to access a missing history entry
