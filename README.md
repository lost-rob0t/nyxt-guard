# nyxt-starintel

Installable StarIntel client package for the Nyxt browser.

The package owns StarIntel-specific Nyxt source and exposes both Nix-flake and non-flake installation paths. Personal dotfiles should consume this package rather than carrying the implementation.

## Layout

- `src/starintel.lisp` — Nyxt StarIntel client source.
- `loader.lisp` — small Nyxt loader used by installers.
- `flake.nix` — Nix package plus install app.
- `scripts/install.sh` — non-flake installer.
- `scripts/uninstall.sh` — non-flake uninstaller.

## Nix / flake install

```sh
nix run github:lost-rob0t/nyxt-guard#install
```

The flake package itself can also be installed with:

```sh
nix profile install github:lost-rob0t/nyxt-guard
nyxt-starintel-install
```

## Non-flake install

```sh
git clone https://github.com/lost-rob0t/nyxt-guard.git
cd nyxt-guard
./scripts/install.sh
```

The installer copies package source to `${XDG_DATA_HOME:-~/.local/share}/nyxt-starintel/` and installs a tiny loader at `${XDG_CONFIG_HOME:-~/.config}/nyxt/nyxt-starintel.lisp`. Add this one line to the user's Nyxt `config.lisp` if it is not already present:

```lisp
(nyxt::load-lisp "~/.config/nyxt/nyxt-starintel.lisp")
```

The package source remains separate from the user's Nyxt config.

## Configuration

The package will standardize StarIntel credentials and runtime settings under `${XDG_CONFIG_HOME:-~/.config}/starintel/`. Planned client work is tracked in this repository's issues.
