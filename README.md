# Open330 Homebrew Tap

Formulas for projects under [Open330](https://github.com/Open330).

## Install

```bash
brew tap Open330/tap
brew install muxa
```

Or install without adding the tap permanently:

```bash
brew install Open330/tap/muxa
```

## Formulas

| Name                       | Description                                                    |
| -------------------------- | -------------------------------------------------------------- |
| [`muxa`](Formula/muxa.rb)  | Agent CLI observability & orchestration layer for tmux.        |

## Keeping formulas up to date

Each formula pins a version + SHA256 tuple that points at a GitHub Release
artifact in the upstream repo. When upstream cuts a new release, the
release workflow (`.github/workflows/release.yml` in the project repo)
opens an update PR against this tap — reviewers bump `version`, `url`,
and `sha256` fields then merge.

## License

Tap scaffolding is [MIT](LICENSE). Individual formulas inherit the license
of their upstream project.
