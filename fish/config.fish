set fish_greeting
set -gx GPG_TTY (tty)
set -gx EDITOR nvim
set -gx TERMINAL alacritty
set -gx LC_ALL en_US.UTF-8
set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $HOME/.local/bin $HOME/.cargo/bin $PATH

abbr gcs "git commit -sv"
abbr gpb "git branch --merged | grep -Ev 'main|master' | xargs -r git branch -d"
abbr ghcs "gh copilot suggest -t shell"
abbr ghce "gh copilot explain"

alias c cat
alias cat bat
alias top btop
alias v nvim
alias t tmux
alias l lsd
alias j just
alias ll 'lsd -l'
alias dy 'dig +short $argv @dns.toys'

source $HOME/.config/fish/nnn.fish
source $HOME/.config/fish/fzf.fish

starship init fish | source
atuin init fish --disable-up-arrow | source
zoxide init fish | source
mise activate fish | source
