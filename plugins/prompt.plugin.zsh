local prompt_newline=$'\n%{\r%}'
local dim_block="%{%F{8}%}"
local highlight_block="%{%F{blue}%}"
local end_block="%{%f%}"
local git_clean="%{%F{cyan}%}"
local git_dirty="%{%F{magenta}%}"
local italic_start="%{\x1b[3m%}"
local italic_end="%{\x1b[0m%}"

quack_prompt_path() {
  readonly p=${1:?"path arg must be specified"}
  local paths
  local isHome
  paths=("${(@s|/|)p}")
  paths=("${(@)paths:#}") # this sanitizes the empty-string-difference between splitting ~/foo and /foo
  [[ '~' = "$paths[1]" ]] && isHome=true || isHome=false
  # @ means 'the contents of the array', the first number is the start index, and last number is length
  if [[ ${#paths[@]} -gt 4 ]]; then paths=(${paths[@]:0:2} "…" ${paths[@]: -2:2}) fi;
  if ! $isHome; then paths=('' ${^paths}) fi; # add an empty element to the start so when we join ('' 'foo' 'bar') becomes /foo/bar
  if [[ ${#paths[@]:#} -eq 0 ]]; then paths=('/') fi;
  paths[-1]=$highlight_block$paths[-1]$end_block
  echo $dim_block${(j:/:)paths}$end_block
}

quack_prompt_git() {
  if [[ -n $vcs_info_msg_0_ ]]; then
    if [[ $VCS_STATUS_HAS_STAGED -eq 1 || $VCS_STATUS_HAS_UNSTAGED -eq 1 || $VCS_STATUS_HAS_UNTRACKED -eq 1 ]]; then
      echo $git_dirty
    else
      echo $git_clean
    fi;
  fi;
}

quack_prompt_isSSH() {
  [[ -n $SSH_CONNECTION ]] && echo '%F{yellow}%m%f'
}

quack_prompt_isRoot() {
  [[ $UID -eq 0 ]] && echo '%F{red}%n%f%F{yellow}@%m%f'
}

quack_prompt_preprompt() {
  local preprompt=()
  preprompt+="$(quack_prompt_path $(print -rD $PWD))"
  preprompt+="$(quack_prompt_git)$vcs_info_msg_0_"
  preprompt+="$(quack_prompt_isSSH)"
  preprompt+="$(quack_prompt_isRoot)"

  preprompt=("${(@)preprompt:#}") # nuke empty strings
  echo $italic_start${(j:%{%F{8}%} ∘ %{%f%}:)preprompt}$italic_end # we have to manually type this out
}

quack_prompt_render() {
  PROMPT='$prompt_newline  $(quack_prompt_preprompt)$prompt_newline%(?.%F{yellow}.%F{red})≷ '
}

quack_prompt_precmd() {
  vcs_info
  gitstatus_query -d $PWD -c quack_prompt_render QUACK
  quack_prompt_render
}

quack_prompt_setup() {
  source $ZPLUGINDIR/gitstatus/gitstatus.plugin.zsh
  gitstatus_start QUACK

  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  add-zsh-hook precmd quack_prompt_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' use-simple true
  zstyle ':vcs_info:git:*' check-for-changes false
  # only export two msg variables from vcs_info
  zstyle ':vcs_info:*' max-exports 2
  # vcs_info_msg_0_ = ' %b' (for branch)
  # vcs_info_msg_1_ = 'x%R' git top level (%R), x-prefix prevents creation of a named path (AUTO_NAME_DIRS)
  zstyle ':vcs_info:git:*' formats '%b'
  zstyle ':vcs_info:git:*' actionformats '%b|%a' 'x%R'
}

quack_prompt_setup
