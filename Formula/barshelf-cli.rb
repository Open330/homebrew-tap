class BarshelfCli < Formula
  desc "Widget developer CLI for the BarShelf macOS menu bar app"
  homepage "https://github.com/Open330/barshelf"
  # The version is spelled out in the URL rather than interpolated from a
  # `version` stanza: that is what `brew bump-formula-pr` substitutes into, and
  # sync-upstream.yml relies on it.
  url "https://github.com/Open330/barshelf/releases/download/v0.7.14/barshelf-cli-0.7.14-arm64.tar.gz"
  sha256 "ee02eab91ada16838f563cc5e53efb3fc6e3d07c88d30ef788404930b381a9aa"
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
