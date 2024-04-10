_default:
  @just --list

# Update fish plugins
update-fish:
  #!/usr/bin/env fish
  echo "Updating fish plugins..."
  fisher update 2>&1 >/dev/null

# Update Neovim
update-nvim:
  @echo "Updating neovim plugins..."
  @nvim +PlugUpdate +quit +quit

# Update Homebrew dependencies
update-homebrew:
  @echo "Updating system dependencies..."
  @brew update --quiet
  @brew upgrade --quiet

# Update tmux plugins
update-tmux:
  @echo "Updating tmux plugins..."
  @"$HOME/.tmux/plugins/tpm/bin/update_plugins" all >/dev/null

# Update vscode
update-vscode:
  @echo "Updating vscode extensions..."
  @code --update-extensions

# Update GitHub CLI
update-gh:
  @echo "Updating gh extensions..."
  @gh extensions upgrade --all >/dev/null

# Update system dependencies
update:
  @just update-homebrew
  @just update-vscode
  @just update-tmux
  @just update-fish
  @just update-nvim
  @just update-gh

alias up := update

