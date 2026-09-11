#!/usr/bin/env sh
set -eu

PACKAGE_ROOT='@PACKAGE_ROOT@'

if [ "$PACKAGE_ROOT" = '@PACKAGE_ROOT@' ]; then
  REPO_ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
  PACKAGE_ROOT="$REPO_ROOT"
fi

DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
DEST="$DATA_HOME/nyxt-starintel"
NYXT_CONFIG="$CONFIG_HOME/nyxt"

mkdir -p "$DEST/src" "$NYXT_CONFIG"
install -m 0644 "$PACKAGE_ROOT/src/starintel.lisp" "$DEST/src/starintel.lisp"
install -m 0644 "$PACKAGE_ROOT/loader.lisp" "$NYXT_CONFIG/nyxt-starintel.lisp"

printf '%s\n' "Installed nyxt-starintel source to $DEST"
printf '%s\n' "Installed Nyxt loader to $NYXT_CONFIG/nyxt-starintel.lisp"
printf '%s\n' "Ensure config.lisp contains: (nyxt::load-lisp \"~/.config/nyxt/nyxt-starintel.lisp\")"
