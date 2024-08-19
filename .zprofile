# autoload -U +X compinit && compinit
# source <($HOME/.config/fxbo/completion.sh)

export GOPATH="$HOME/Code/Go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Added by Toolbox App
export PATH="$PATH:/Users/vladislav.k/Library/Application Support/JetBrains/Toolbox/scripts"

alias gss="git status -sb"
alias ll="grc --colour=auto ls -al"
alias mc="maze-client -e $HOME/.maze-client.env"
alias mc-journal="mc authorize && mc journal get"

alias lg="lazygit"

export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="$(gem env gemhome)/bin:$PATH"
export GITLAB_ACCESS_TOKEN="glpat-xjMroFewpqM7bSzp5mPj"
export NODE_OPTIONS=--openssl-legacy-provider


alias clipdecrypt="clippaste | gpg --decrypt 2> /dev/null | tr -d '\n' | clipcopy"

function db() { 
  ssh $@ 'echo "cd www/*/current/ && cat .env.prod | grep DATABASE_URL | cut -c14- | base64 --decode" | sudo su - fxbo';
}

function db_access(){
  db $@ | awk -F "/" '{print $3}' | awk -F "@" '{print $1}' | tr -d '\n';
}

function db_ip() {
  db $@ | awk -F "/" '{print $3}' | awk -F "@" '{print $2}' | awk -F ':' '{print $1}' | tr -d '\n';
}

function deploy() {
  enable_nvm
  cd $HOME/Code/FxBo/crm/
  mkdir -p ./.deploy;
  # nohup ./bin/dep/deploy $@ > ./.deploy/$@.log &;
  nohup sh -c "./bin/dep/build $@ && ./bin/dep/publish $@" > ./.deploy/$@.log &
  tail -f ./.deploy/$@.log;
}

function build() {
  enable_nvm
  cd $HOME/Code/FxBo/crm/
  mkdir -p ./.deploy;
  nohup ./bin/dep/build $@ > ./.deploy/$@.log &;
  tail -f ./.deploy/$@.log;
}

function publish() {
  cd $HOME/Code/FxBo/crm/
  mkdir -p ./.deploy;
  nohup ./bin/dep/publish $@ > ./.deploy/$@.log &;
  tail -f ./.deploy/$@.log;
}

function dl() {
  tail -f ${HOME}/Code/FxBO/crm/.deploy/$@.log;
}

function projip() {
  echo $(ssh -G $@ | awk '/^hostname / { print $2 } ') | tr -d "\n";
}

function fzf_complete_ssh() {
    setopt localoptions nonomatch
    command cat <(cat ~/.ssh/config ~/.ssh/config.d/* /etc/ssh/ssh_config 2> /dev/null | command grep -i '^\s*host\? ' | command grep -v '[*?]' | awk '{for (i = 2; i <= NF; i++) print $1 " " $i}') |
        awk '{if (length($2) > 0) {print $2}}' | sort -u
}

_fzf_complete_ssh() { _fzf_complete '+m' "$@" < <(fzf_complete_ssh) }
_fzf_complete_deploy() { _fzf_complete '+m' "$@" < <(fzf_complete_ssh) }
_fzf_complete_build() { _fzf_complete '+m' "$@" < <(fzf_complete_ssh) }
_fzf_complete_publish() { _fzf_complete '+m' "$@" < <(fzf_complete_ssh) }
_fzf_complete_db() { _fzf_complete '+m' "$@" < <(fzf_complete_ssh) }
_fzf_complete_db_access() { _fzf_complete '+m' "$@" < <(fzf_complete_ssh) }
_fzf_complete_dl() { _fzf_complete '+m' "$@" < <(fzf_complete_ssh) }
_fzf_complete_projip() { _fzf_complete '+m' "$@" < <(fzf_complete_ssh) }
