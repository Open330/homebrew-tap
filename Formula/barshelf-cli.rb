class BarshelfCli < Formula
  desc "Widget developer CLI for the BarShelf macOS menu bar app"
  homepage "https://github.com/Open330/barshelf"
  version "0.3.0"
  url "https://github.com/Open330/barshelf/releases/download/v#{version}/barshelf-cli-#{version}-arm64.tar.gz"
  sha256 "c11373a6ef2f6ed2611ce30f6cb95cece8e81cfd64a9989a3ac43829bac7c18b"
  license "MIT"

  # Upstream ships Apple Silicon binaries only.
  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "barshelf"
    bin.install "bsf"
  end

  # No backticks or unescaped dollar signs in here: the release workflow
  # writes this file from an unquoted shell heredoc.
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
