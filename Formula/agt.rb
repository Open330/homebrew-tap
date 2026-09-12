class Agt < Formula
  desc "Modular toolkit for extending AI coding agents with skills, personas, and hooks"
  homepage "https://github.com/Open330/agt"
  version "2026.7.23"
  license "MIT"

  # Upstream publishes no x86_64-apple-darwin archive, so on Intel macOS
  # Homebrew reports the formula as unsupported for that platform.
  on_macos do
    on_arm do
      url "https://github.com/Open330/agt/releases/download/v#{version}/agt-aarch64-apple-darwin.tar.gz"
      sha256 "825354f597581ccc27a2cadb9aa73d57601a67d1db981db311faac8206117ea2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Open330/agt/releases/download/v#{version}/agt-aarch64-unknown-linux-musl.tar.gz"
      sha256 "dd7a878530ec2b344ba5f77a81383ca22d390cb699f4157ec8060c7e50a4e4e1"
    end
    on_intel do
      url "https://github.com/Open330/agt/releases/download/v#{version}/agt-x86_64-unknown-linux-musl.tar.gz"
      sha256 "17b78ab33112d791caef75958b8705dac3e9fbb46a271420355a6aa1f3fedc22"
    end
  end

  def install
    bin.install "agt"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agt --version")
  end
end
