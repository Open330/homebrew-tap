class BarshelfCli < Formula
  desc "Widget developer CLI for the BarShelf macOS menu bar app"
  homepage "https://github.com/Open330/barshelf"
  # The version is spelled out in the URL rather than interpolated from a
  # `version` stanza: that is what `brew bump-formula-pr` substitutes into, and
  # sync-upstream.yml relies on it.
  url "https://github.com/Open330/barshelf/releases/download/v0.3.12/barshelf-cli-0.3.12-arm64.tar.gz"
  sha256 "2b15676b4ea10e7d1a98b39c42cdb55753f85fa5fc6a90302a1afdf8a5778d9b"
  license "MIT"

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
