# zinit

if [[ ! -e ~/.zinit/bin/zinit.zsh ]]; then
    mkdir -p ~/.zinit
    git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi

source ~/.zinit/bin/zinit.zsh

zinit light sindresorhus/pure
zinit light wfxr/forgit
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# pure

fpath+=$HOME/.zinit/plugins/sindresorhus---pure

autoload -U promptinit; promptinit
prompt pure

# options

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt always_last_prompt
setopt auto_cd
setopt list_packed
setopt share_history
setopt hist_ignore_all_dups

unsetopt correct

# clean history

add-zsh-hook preexec optimize_history_preexec
add-zsh-hook precmd optimize_history_precmd

optimize_history_preexec() {
    OPTIMIZE_HISTORY_CALLED=1
}

optimize_history_precmd() {
    local -r exit_code="$?"
    if [[ ! ${exit_code} =~ ^(0|130)$ ]] && [[ "${OPTIMIZE_HISTORY_CALLED}" -eq 1 ]]; then
        command sed -i '' '$d' ~/.zsh_history 2>/dev/null || command sed -i '$d' ~/.zsh_history # BSD || GNU
    fi
    unset OPTIMIZE_HISTORY_CALLED
}

# alias

alias cat=bat
alias cdr='cd $(git rev-parse --show-toplevel)'
alias cp='cp -i'
alias editor=$EDITOR
alias ghc='stack ghc'

alias ghci='stack ghci'
alias ghqup='ghq list | ghq get --update --parallel'
alias ibus-restart='ibus-daemon -drx'
alias ls=exa
alias mkdir='mkdir -p'

alias mv='mv -i'
alias nyan=fuck
alias rm='rm -i'
alias pbcopy='xclip -selection c'
alias pbff='cat $_ | pbcopy'

alias pbpaste='xclip -selection c -o'
alias runghc='stack runghc'
alias sudo='sudo -E'
alias t='tmux new -A'
alias todo='vim ~/Documents/todo.txt'

alias update-nvim-nightly='asdf uninstall neovim nightly && asdf install neovim nightly'
alias vconf='editor ~/.config/nvim/init.vim'
alias zconf='editor ~/.zshrc'

# path

export PATH=/var/lib/spand/bin:$PATH
export PATH=~/.local/bin:$PATH
export cdpath=(.. ~/.repos/github.com/nan1sa ~/.repos/github.com)

# other

export XDG_CONFIG_HOME=~/.config
export TERM=xterm-256color

export EDITOR=nvim

eval $(keychain --eval id_ed25519)
eval $(thefuck --alias)
source ~/.cargo/env
source ~/.asdf/asdf.sh
