# DIRECTORY

setopt AUTO_CD              # auto changes to a directory without typing cd
setopt AUTO_PUSHD           # push the old directory onto the stack on cd
setopt PUSHD_IGNORE_DUPS    # do not store duplicates in the stack
setopt PUSHD_SILENT         # do not print the directory stack after pushd or popd
setopt PUSHD_TO_HOME        # push to home directory when no argument is given
unsetopt CDABLE_VARS        # don't cd into variable values without $
setopt MULTIOS              # write to multiple descriptors
setopt EXTENDED_GLOB        # use extended globbing syntax
setopt GLOB_DOTS            # include dotfiles when globbing

# HISTORY

HISTFILE="$HOME/.local/share/zsh/history"
if [[ ! -f "$HISTFILE" ]]; then
  mkdir -p "$HISTFILE:h" && touch "$HISTFILE"
fi

HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY           # share history between all sessions (implies INC_APPEND_HISTORY)
setopt HIST_NO_STORE           # don't store history commands
setopt HIST_REDUCE_BLANKS      # remove superfluous blanks from each command line being added to the history list
setopt BANG_HIST               # treat the '!' character specially during expansion
setopt EXTENDED_HISTORY        # write the history file in the ':start:elapsed;command' format
setopt HIST_EXPIRE_DUPS_FIRST  # expire a duplicate event first when trimming history
setopt HIST_IGNORE_ALL_DUPS    # delete an old recorded event if a new event is a duplicate
setopt HIST_FIND_NO_DUPS       # do not display a previously found event
setopt HIST_IGNORE_SPACE       # do not record an event starting with a space
setopt HIST_SAVE_NO_DUPS       # do not write a duplicate event to the history file
setopt HIST_VERIFY             # do not execute immediately upon history expansion
setopt NO_HIST_BEEP            # don't beep when attempting to access a missing history entry

# ALIASES

alias ls='ls --color=auto -hF'
alias ll='ls -l'
alias la='ll -a'
alias lz='ll -rS'             # sort by size
alias lt='ll -rt'             # sort by date
alias sudo='sudo '            # enable alias expansion after sudo
