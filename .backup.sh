#!/bin/bash

# Параметры
REPO="$HOME/.backup"
if ! [ -d $REPO ]; then
  mkdir -p $REPO
  /opt/homebrew/bin/borg init --encryption=repokey $REPO
fi

# security add-generic-password -a backup -s backup_passphrase -w
PASSCOMMAND="/usr/bin/security find-generic-password -a backup -s backup_passphrase -w"
BACKUP_NAME="daily-$(date +%Y-%m-%d)"
SOURCE="$HOME"

# Создание бэкапа
BORG_REPO="$REPO" BORG_PASSCOMMAND="$PASSCOMMAND" caffeinate -i /opt/homebrew/bin/borg create \
  --noxattrs \
  --progress \
  --stats \
  "::$BACKUP_NAME" "$SOURCE" \
  --exclude "$HOME/Applications/" \
  --exclude "$HOME/Downloads/no_backup/" \
  --exclude "$HOME/Library/" \
  --exclude "$HOME/Code/Go/" \
  --exclude "$HOME/OrbStack/" \
  --exclude "$HOME/.Trash/" \
  --exclude "$HOME/.cache/" \
  --exclude "$HOME/.zcompdump*" \
  --exclude "$HOME/.nvm/" \
  --exclude "$HOME/.npm/" \
  --exclude "$HOME/.android" \
  --exclude "$HOME/.gradle" \
  --exclude "$HOME/.konan" \
  --exclude "$HOME/.backup" \
  --exclude "$HOME/.tldrc" \
  --exclude "*/.git/" \
  --exclude "*/vendor/" \
  --exclude "*/node_modules/" \
  --exclude "*/var/" \
  --exclude "*.tmp" \
  --exclude "*.log"

# Очистка старых бэкапов
BORG_REPO="$REPO" BORG_PASSCOMMAND="$PASSCOMMAND" caffeinate -i /opt/homebrew/bin/borg prune -v --list --keep-daily=7 --keep-weekly=4 --keep-monthly=12
