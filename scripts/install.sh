#!/usr/bin/env sh
set -eu

PACKAGE_ROOT='@PACKAGE_ROOT@'

if [ "$PACKAGE_ROOT" = '@PACKAGE_ROOT@' ]; then
  REPO_ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
  PACKAGE_ROOT="$REPO_ROOT"
fi

DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
DEST="$DATA_HOME/nyxt-guard"
NYXT_CONFIG="$CONFIG_HOME/nyxt"

mkdir -p "$DEST/src" "$DEST/modules" "$NYXT_CONFIG"
install -m 0644 "$PACKAGE_ROOT/src/nyxt-guard.lisp" "$DEST/src/nyxt-guard.lisp"

if [ -d "$PACKAGE_ROOT/modules" ]; then
  for module in "$PACKAGE_ROOT"/modules/*.lisp; do
    [ -e "$module" ] || continue
    install -m 0644 "$module" "$DEST/modules/$(basename "$module")"
  done
fi

install -m 0644 "$PACKAGE_ROOT/loader.lisp" "$NYXT_CONFIG/nyxt-guard.lisp"

printf '%s\n' "Installed nyxt-guard to $DEST"
printf '%s\n' "Installed Nyxt loader to $NYXT_CONFIG/nyxt-guard.lisp"
printf '%s\n' "Ensure config.lisp contains: (nyxt::load-lisp \"~/.config/nyxt/nyxt-guard.lisp\")"
