class BarshelfCli < Formula
  desc "Widget developer CLI for the BarShelf macOS menu bar app"
  homepage "https://github.com/Open330/barshelf"
  url "https://github.com/Open330/barshelf/releases/download/v0.1.3/barshelf-cli-0.1.3-arm64.tar.gz"
  sha256 "8a43b12e145fac6706cf73961ebff434df9820c09f09fa57ec924129a4fb90ef"
  license "MIT"

  # Upstream ships Apple Silicon binaries only.
  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "barshelf"
    bin.install "bsf"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/barshelf --version")
  end
end
