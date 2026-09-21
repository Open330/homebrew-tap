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
| [`barshelf`](Casks/barshelf.rb)     | Scriptable menu bar widget platform (arm64).                                | `brew install --cask open330/tap/barshelf`  |
| [`muxa-app`](Casks/muxa-app.rb)     | Native workbench for the muxa agent orchestration daemon.                   | `brew install --cask open330/tap/muxa-app`  |

## Keeping formulae up to date

Each formula and cask pins a version + SHA256 tuple that points at a GitHub
Release artifact in the upstream repo. Three things keep those current, in
order of preference:

1. **[`sync-upstream.yml`](.github/workflows/sync-upstream.yml) in this repo.**
   Runs daily, finds newer releases with `brew livecheck`, and rewrites the
   pinned tuple with `brew bump-cask-pr` / `brew bump-formula-pr`, which
   recompute the SHA256 from the artifact itself. It pushes with the automatic
   `GITHUB_TOKEN`, so there is no cross-repo PAT to mint, rotate or lose.
   Covers `barshelf` and `barshelf-cli`; add an entry to its `ITEMS` list to
   cover more.
2. **A tap bump workflow in the upstream repo.** `muxa` pushes here the moment
   it publishes a release, driven by a `TAP_GITHUB_TOKEN` fine-grained PAT with
   Contents read/write on this repo. Instant rather than within a day, at the
   cost of a long-lived secret.
3. **By hand**: update `version`, `url`, and `sha256`, then run `brew style`
   and `brew audit --strict` on the changed file.

Entries that ship one URL and SHA256 *per platform* — `aas`, `agt`, `muxa` —
cannot be bumped from a version alone, so 1 does not cover them.

This matters more than it looks. The `barshelf` cask and the `barshelf-cli`
formula sat at 0.1.3 while that project shipped 0.3.0, because only method 3
applied and nobody applied it. BarShelf refuses to self-update a
Homebrew-installed copy — correctly, since replacing it would desync brew's
records — and points at `brew upgrade`, which reported the user was already
current. Those users had no update path at all.

## License

Tap scaffolding is [MIT](LICENSE). Individual formulae inherit the license
of their upstream project.
