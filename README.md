# .dotfiles

My collection of dotfiles managed by [dotter](https://github.com/SuperCuber/dotter).

## Setup

```bash
# Clone the repository to ~/.dotfiles
cd ~
git clone https://github.com/stephen-bunn/.dotfiles

# Initialize dotter
cd ~/.dotfiles
dotter init

# Create local configuration of desired packages
echo 'packages = ["git", "alacritty", "neovim"]' > ~/.dotfiles/.dotter/local.toml

# Apply configuration
cd ~/.dotfiles
dotter
```
