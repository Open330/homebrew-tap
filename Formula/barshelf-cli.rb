class BarshelfCli < Formula
  desc "Widget developer CLI for the BarShelf macOS menu bar app"
  homepage "https://github.com/Open330/barshelf"
  # The version is spelled out in the URL rather than interpolated from a
  # `version` stanza: that is what `brew bump-formula-pr` substitutes into, and
  # sync-upstream.yml relies on it.
  url "https://github.com/Open330/barshelf/releases/download/v0.7.21/barshelf-cli-0.7.21-arm64.tar.gz"
  sha256 "bf5f292d87eba472a43a0f94791737cae11bebc82fac32a842f7ba46430da972"
  license "MIT"

  # Follow GitHub's "latest" release, which excludes pre-releases. Without
  # this, livecheck reads git tags and sync-upstream shipped a pre-release
  # tag (v0.5.0) to every Homebrew user.
  livecheck do
    url :stable
    strategy :github_latest
  end

  # Upstream ships Apple Silicon binaries only.
  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "barshelf"
    bin.install "bsf"
  end

  def caveats
    <<~CAVEATS
      'barshelf upgrade' updates the app and the CLI together, but it detects a
      Homebrew-installed CLI and refuses to replace it — writing into the Cellar
      would leave brew holding the version it installed, and the next upgrade
      would revert yours. Use 'brew upgrade barshelf-cli' instead.
    CAVEATS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/barshelf --version")
    assert_match version.to_s, shell_output("#{bin}/bsf --version")
  end
end
