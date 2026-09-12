# Open330 Homebrew Tap

Formulae and casks for projects under [Open330](https://github.com/Open330).

## Install

```bash
brew tap open330/tap
brew install muxa
brew install --cask muxa-app
```

Or install without adding the tap permanently:

```bash
brew install open330/tap/muxa
brew install --cask open330/tap/muxa-app
```

## Formulae

| Name                                         | Description                                                                   | Install                                 |
| -------------------------------------------- | ----------------------------------------------------------------------------- | --------------------------------------- |
| [`aas`](Formula/aas.rb)                      | Agent Account Switcher: multi-account switcher for LLM coding agents.         | `brew install open330/tap/aas`          |
| [`agt`](Formula/agt.rb)                      | Modular toolkit for extending AI coding agents with skills, personas, hooks.  | `brew install open330/tap/agt`          |
| [`barshelf-cli`](Formula/barshelf-cli.rb)    | `barshelf` / `bsf` widget developer CLI for BarShelf (Apple Silicon only).    | `brew install open330/tap/barshelf-cli` |
| [`muxa`](Formula/muxa.rb)                    | Agent CLI observability & orchestration layer for tmux.                       | `brew install open330/tap/muxa`         |

Platform notes:

- `agt` has no Intel macOS build upstream; Homebrew reports it as unsupported on
  `x86_64` Macs. Apple Silicon macOS and Linux (`arm64`, `x86_64`) are covered.
- `barshelf-cli` is macOS Apple Silicon only.

## Casks

| Name                                | Description                                                                 | Install                                     |
| ----------------------------------- | --------------------------------------------------------------------------- | ------------------------------------------- |
| [`amux`](Casks/amux.rb)             | Agent-first terminal with tmux-native workspaces.                           | `brew install --cask open330/tap/amux`      |
| [`barshelf`](Casks/barshelf.rb)     | Menu bar app: OTP codes, LLM usage, recent files, CI status widgets (arm64). | `brew install --cask open330/tap/barshelf`  |
| [`muxa-app`](Casks/muxa-app.rb)     | Native workbench for the muxa agent orchestration daemon.                   | `brew install --cask open330/tap/muxa-app`  |

## Keeping formulae up to date

Each formula and cask pins a version + SHA256 tuple that points at a GitHub
Release artifact in the upstream repo. Where the upstream project has a tap
bump workflow (`muxa` uses `.github/workflows/tap-bump.yml`, driven by a
`TAP_GITHUB_TOKEN` fine-grained PAT with Contents read/write on this repo), a
new release pushes the updated `Formula/*.rb` / `Casks/*.rb` here directly.
Other projects are bumped by hand: update `version`, `url`, and `sha256`, then
run `brew style` and `brew audit --strict` on the changed file.

## License

Tap scaffolding is [MIT](LICENSE). Individual formulae inherit the license
of their upstream project.
