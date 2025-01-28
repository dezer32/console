#!/bin/bash

# Параметры
REPO="/Volumes/Storage/Backups/Repositroy"
# security add-generic-password -a backup -s backup_passphrase -w
PASSCOMMAND="/usr/bin/security find-generic-password -a backup -s backup_passphrase -w"
BACKUP_NAME="daily-$(hostname)-$(date +%Y-%m-%d)"
SOURCE="/Users/dezer/"
EXCLUDE="/Users/dezer/.config/borg/exclude.txt"

# Создание бэкапа
BORG_REPO="$REPO" BORG_PASSCOMMAND="$PASSCOMMAND" borg create --progress --stats "::$BACKUP_NAME" "$SOURCE" --exclude-from $EXCLUDE

# Очистка старых бэкапов
BORG_REPO="$REPO" BORG_PASSCOMMAND="$PASSCOMMAND" borg prune -v --list --keep-daily=7 --keep-weekly=4 --keep-monthly=6
