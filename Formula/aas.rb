class Aas < Formula
  desc "Agent Account Switcher: multi-account switcher for LLM coding agents"
  homepage "https://github.com/Open330/aas"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-aarch64-apple-darwin.tar.gz"
      sha256 "7abd723baadceb8fa1f6789d393637464b3355fdf68faae70b5a25f696c3121b"
    else
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-x86_64-apple-darwin.tar.gz"
      sha256 "cdf4279a3354c061b41ed1ab8ee619a05ffd80699762402c54df1ee649f11ba8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-aarch64-unknown-linux-musl.tar.gz"
      sha256 "59ee937abb88c7fd4c4e4fd3d8e7f17cd182033a2772d81111a75985b5fffaac"
    else
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a0b0825fbb6f74aa85bc92462f04a7d4332eb41431e1df4ed09c3f29292dd948"
    end
  end

  def install
    bin.install "aas"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aas --version")
  end
end
