#!/usr/bin/env sh
set -eu

PACKAGE_ROOT='@PACKAGE_ROOT@'
DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
DEST="$DATA_HOME/nyxt-starintel"
LOADER="$CONFIG_HOME/nyxt/nyxt-starintel.lisp"

rm -rf "$DEST"
rm -f "$LOADER"

printf '%s\n' "Removed nyxt-starintel package data from $DEST"
printf '%s\n' "Removed Nyxt loader $LOADER"
printf '%s\n' "If config.lisp loads nyxt-starintel.lisp, remove that load form manually."
