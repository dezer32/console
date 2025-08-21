eval "$(/opt/homebrew/bin/brew shellenv)"

export XDG_CONFIG_HOME="$HOME/.config"
export ANDROID_HOME="$HOME/Library/Android/sdk"

#Для подгрузки автокомплита с homebrew
#сперва проверяем наличие brew
if type brew &>/dev/null
then
FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"
FPATH="$HOMEBREW_PREFIX/share/zsh-completions:$FPATH"
FPATH="$HOME/.config/completion:$FPATH"
fi

# [[ /opt/homebrew/bin/orbctl ]] && source <(orbctl completion zsh)


# Remove write permission
# compaudit | xargs chmod g-w

ENABLE_CORRECTION="true"

# Путь к файлу кэша
zcompdump="${ZDOTDIR:-${HOME}}/.zcompdump-${HOST}-${ZSH_VERSION}"

# Загрузка кэша compinit, если он существует и не устарел
if [[ -s "${zcompdump}" ]] && (( $+commands[compinit] )); then
  autoload -Uz compinit
  compinit -C -d "${zcompdump}"
else
  autoload -Uz compinit
  compinit -d "${zcompdump}"
fi


# Запуск автокомплита
autoload -U promptinit
promptinit;

autoload -U +X bashcompinit && bashcompinit

# загружаем список цветов
autoload colors && colors

# экранируем спецсимволы в url, например &amp;, ?, ~ и так далее
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# куда же мы без калькулятора
autoload -U zcalc


# Файл для хранения истории
HISTFILE=~/.zhistory
## Число команд, сохраняемых в HISTFILE
SAVEHIST=5000
## Чucлo команд, coxpaняeмыx в сеансе
HISTSIZE=5000
DIRSTACKSIZE=20
# Опции истории команд
#Добавляет в историю время выполнения команды.
setopt extended_history
alias history='fc -il 1'

#История становится общей между всеми сессиями / терминалами.
setopt share_history

# Дополнение файла истрии
setopt  APPEND_HISTORY

#Добавить команду в историю не после выполнения а перед
setopt INC_APPEND_HISTORY

# Игнopupoвaть вce пoвтopeнuя команд
setopt  HIST_IGNORE_ALL_DUPS

# Удалять из файл истории пустые строки
setopt  HIST_REDUCE_BLANKS

# команды «history» и «fc» в историю заноситься не будут
setopt HIST_NO_STORE

# если набрали путь к директории без комманды CD, то перейти
setopt AUTO_CD

#Сообщать при изменении статуса фонового задания
setopt NOTIFY

#Перемещение стрелочками по выбору
setopt menucomplete
zstyle ':completion:*' menu select=1 _complete _ignored _approximate

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' list-colors ''

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' use-cache yes

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

#Регистронезависимый автокомплит
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 

#Настройка вывода для инфо по текущему гиту
#zstyle ':vcs_info:git*' formats "%{$fg[grey]%}%s:%{$reset_color%}%{$fg[blue]%}%b%{$reset_color%}(%a)%{$fg[green]%}%m%u%c%{$reset_color%}"
#zstyle ':vcs_info:*' check-for-changes true

#Вести себя как в BASH
#setopt AUTO_MENU BASH_AUTO_LIST

# исправлять неверно набранные комманды
setopt CORRECT_ALL
# вопрос на автокоррекцию
SPROMPT='zsh: Заменить '\''%R'\'' на '\''%r'\'' ? [Yes/No/Abort/Edit] '

#Можно вводить комментарии начинающиеся с #.
#setopt interactive_comments

#Дополняем спрятанные .файлы:
_comp_options+=(globdots)

# Включение поддержки выражений вроде «{1-3}» или «{a-d}» — они будут разворачиваться
# в «1 2 3» и «a b c d» соответственно
setopt BRACECCL

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias df='df -k --print-type --human-readable'
#alias du='du -k --total --human-readable'
alias -g  HE='2>>( sed -ue "s/.*/$fg_bold[red]&$reset_color/" 1>&2 )' # Highlight Errors

# разукрашиваем команды с помощью grc
if [ -f /usr/bin/grc ]; then
alias ping='grc --colour=auto ping'
alias traceroute='grc --colour=auto traceroute'
alias make='grc --colour=auto make'
alias diff='grc --colour=auto diff»'
alias cvs='grc --colour=auto cvs'
alias netstat='grc --colour=auto netstat'
# разукрашиваем логи с помощью grc
alias logc="grc cat"
alias tail='grc --colour=auto tail -n 200 -f'
alias logh="grc head"
fi

alias vim="nvim"
alias lg="lazygit"

alias bu="brew update && brew upgrade && brew upgrade --greedy"
alias backup="~/.backup.sh"
alias extbackup="~/.external_backup.sh"
alias crypt_drive="mega-webdav /data > /dev/null 2>&1 || true && rclone mount mega-crypt: ~/Crypt --vfs-cache-mode writes --vfs-cache-max-age 1h --vfs-cache-max-size 10G --daemon-timeout=10s --umask 022 --allow-other --file-perms 0644 --dir-perms 0755 --daemon"

function enable_nvm ()
{
  [ -d "$HOME/.nvm" ] || mkdir -p "$HOME/.nvm"
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
}

#enable by defaul
enable_nvm

#Красивый вывод mysql
export MYSQL_PS1="mysql: \d|> "

#Копирование и вставка инфы в буфер обмена
function clipcopy() { cat "${1:-/dev/stdin}" | pbcopy; }
alias cc=clipcopy
function clippaste() { pbpaste; }
# alias pp=clippaste

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export COMPOSER_MEMORY_LIMIT=-1

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

zstyle ':vcs_info:git:*' formats '%F{240}(%b)%f'
zstyle ':vcs_info:*' enable git

export PS1=$'\n'"%B%F{33}%n%{$reset_color%}@%B%F{33}%m%{$reset_color%}:%B%{$fg[cyan]%}%0~%{$reset_color%} "\$vcs_info_msg_0_$'\n'"%B%(?.%F{33}.%F{red})%b "

# export PS1=$'\n'"%B%F{33}%n%{$reset_color%}@%B%F{33}%m%{$reset_color%}:%B%{$fg[cyan]%}%0~%{$reset_color%} "\$vcs_info_msg_0_$'\n'"%B%(?.%F{33}.%F{red})%b "

# export RPROMPT='%*'

#autoload -Uz compinit; compinit

# [[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
# [[ /usr/local/bin/docker ]] && source <(docker completion zsh)
# [[ /opt/homebrew/bin/orbctl ]] && source <(orbctl completion zsh)

export GPG_TTY=$(tty)
export EDITOR=vim
export GOPATH="${HOME}/Code/go"

export PATH="${HOME}/.local/bin:${HOME}/.composer/vendor/bin:${PATH}"
export PATH="${HOME}/.jetbrains/bin:${PATH}"
# export PATH="${HOME}/Library/Python/3.9/bin:$PATH"
export PATH="$(brew --prefix python)/libexec/bin:${PATH}"
export PATH="${HOMEBREW_PREFIX}/opt/mysql-client/bin:$PATH"
export PATH="${HOMEBREW_PREFIX}/opt/libpq/bin:$PATH"
export PATH="${HOMEBREW_PREFIX}/opt/ruby/bin:$PATH"
export PATH="${HOMEBREW_PREFIX}/opt/openssh/bin:$PATH"

export PATH="${GOPATH}/bin:${PATH}"

export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"

export DOCKER_DEFAULT_PLATFORM=linux/arm64/v8
export BAT_THEME="gruvbox-dark"

export BORG_PASSCOMMAND="/usr/bin/security find-generic-password -a backup -s backup_passphrase -w"

# zsh
eval "$(fzf --zsh)"

# fzf configuration
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey "ç" fzf-cd-widget
FZF_FD_OPTS="--hidden --follow --no-ignore --exclude '.git'"

export FZF_DEFAULT_COMMAND="fd ${FZF_FD_OPTS}"
export FZF_CTRL_T_COMMAND="fd ${FZF_FD_OPTS}"
export FZF_ALT_C_COMMAND="fd --type d ${FZF_FD_OPTS}"

_fzf_compgen_path() {
  fd ${FZF_FD_OPTS} . "${1}"
}

_fzf_compgen_dir() {
  fd --type d ${FZF_FD_OPTS} . "${1}"
}

export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
    --bind 'ctrl-/:toggle-preview'
      --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
        --color header:italic
          --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

bindkey ^K up-line-or-search
bindkey ^J down-line-or-search


# iTerm2
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true



[ -f ~/.zprofile ] && source ~/.zprofile
[ -f ~/.zalias ] && source ~/.zalias
[ -f ~/.alias.local ] && source ~/.alias.local


# export PATH="$(gem env gemhome)/bin:$PATH"



alias claude="/Users/vladislav_k/.claude/local/claude"
