_eggshell_plugins=(
  sanity
  editor
  completions
)

for _ep in $_eggshell_plugins; do
  source ${0:a:h}/plugins/$_ep.plugin.zsh
done
