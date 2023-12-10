alias code="codium"
export KUBE_EDITOR=nano

export OCI_CLI_AUTH=security_token
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

export LC_ALL=en_US.UTF-8
export PATH=/opt/homebrew/bin:$PATH

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

function obsidian(){
       cd "/Users/david/Library/Mobile Documents/iCloud~md~obsidian/Documents/konstfish/.obsidian/"
       git add -A
       git commit -m "$@"
       git push
       cd ~
}

alias nano="nano -x"
alias gitignore="echo '.DS_Store\n' > .gitignore"

eval "$(starship init zsh)"