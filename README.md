# nyxt-guard

Installable Nyxt extension package with modular browser modes and integrations.

StarIntel is one module in this package, not the package identity. Personal dotfiles should consume `nyxt-guard` as a package/flake input rather than owning its implementation.

## Layout

- `src/nyxt-guard.lisp` — package bootstrap/module loader.
- `modules/` — independently maintained Nyxt integrations such as `starintel.lisp`.
- `loader.lisp` — tiny Nyxt-side loader installed into the user's config directory.
- `flake.nix` — Nix package plus install/uninstall apps.
- `scripts/install.sh` — non-flake installer.
- `scripts/uninstall.sh` — non-flake uninstaller.

## Nix / flake install

```sh
nix run github:lost-rob0t/nyxt-guard#install
```

Or install the package:

```sh
nix profile install github:lost-rob0t/nyxt-guard
nyxt-guard-install
```

## Non-flake install

```sh
git clone https://github.com/lost-rob0t/nyxt-guard.git
cd nyxt-guard
./scripts/install.sh
```

The installer copies package source to `${XDG_DATA_HOME:-~/.local/share}/nyxt-guard/` and installs a tiny loader at `${XDG_CONFIG_HOME:-~/.config}/nyxt/nyxt-guard.lisp`.

Add this one line to Nyxt `config.lisp` if it is not already present:

```lisp
(nyxt::load-lisp "~/.config/nyxt/nyxt-guard.lisp")
```

The package implementation stays outside personal Nyxt configuration. Modules may define their own runtime configuration paths; for example, the planned StarIntel module will read its API key from `~/.config/starintel/nyxt.key`.
