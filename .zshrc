#Для подгрузки автокомплита с homebrew
#сперва проверяем наличие brew
if type brew &>/dev/null
then
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Запуск автозагрузки автокомплита
autoload -U compinit promptinit
compinit
promptinit;

# загружаем список цветов
autoload colors && colors

# экранируем спецсимволы в url, например &amp;, ?, ~ и так далее
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# куда же мы без калькулятора
autoload -U zcalc

#Запуск вывода инфы по гиту
#autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable git svn
#precmd() {
#    vcs_info
#}
#setopt prompt_subst

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

autoload -U +X bashcompinit && bashcompinit

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

#Красивый вывод mysql
export MYSQL_PS1="mysql: \d|> "

eval "$(/opt/homebrew/bin/brew shellenv)"

ENABLE_CORRECTION="true"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

#Копирование и вставка инфы в буфер обмена
function clipcopy() { cat "${1:-/dev/stdin}" | pbcopy; }
function clippaste() { pbpaste; }

export PATH="$PATH:$(brew --prefix openssh)/bin"
export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export COMPOSER_MEMORY_LIMIT=-1
#export PS1="%n@%m:%0~\$ "
#export PS1="%{$fg[green]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:%{$fg[blue]%}%0~%{$reset_color%}$ "
export PS1=$'\n'"%B%{$fg[green]%}%n%{$reset_color%}@%B%{$fg[green]%}%m%{$reset_color%}:%B%{$fg[cyan]%}%0~%{$reset_color%}"$'\n'"%B%{$fg[blue]%}❯%b"

#export PS1=$'\n'"%B%{$fg[green]%}my%{$reset_color%}@%B%{$fg[green]%}computer%{$reset_color%}:%B%{$fg[cyan]%}%0~%{$reset_color%}"$'\n'"%B%{$fg[blue]%}❯%b"

#autoload -Uz compinit; compinit

[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)


# The next line updates PATH for Yandex Cloud CLI.
if [ -f '/Users/dezer/yandex-cloud/path.bash.inc' ]; then source '/Users/dezer/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/Users/dezer/yandex-cloud/completion.zsh.inc' ]; then source '/Users/dezer/yandex-cloud/completion.zsh.inc'; fi

export GPG_TTY=$(tty)
export EDITOR=vim
export PATH=${HOME}/.composer/vendor/bin:${PATH}
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

