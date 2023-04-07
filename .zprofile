#eval "$(/opt/homebrew/bin/brew shellenv)"


export GOPATH="$HOME/Code/Go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"



# Added by Toolbox App
export PATH="$PATH:/Users/vladislav.k/Library/Application Support/JetBrains/Toolbox/scripts"
export DOCKER_DEFAULT_PLATFORM=linux/amd64

#source "$HOME/.iterm2_shell_integration.zsh"
alias gss="git status -sb"
alias ll="grc --colour=auto ls -al"
alias mc="maze-client -e $HOME/.maze-client.env"
alias mc-journal="mc authorize && mc journal get"
