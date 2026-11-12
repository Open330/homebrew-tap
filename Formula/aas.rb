class Aas < Formula
  desc "Agent Account Switcher: multi-account switcher for LLM coding agents"
  homepage "https://github.com/Open330/aas"
  version "0.1.16"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-aarch64-apple-darwin.tar.gz"
      sha256 "d823241aba86f628873ed3194c1cd26b27f0d625535c0bf53c9edacedab7217b"
    else
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-x86_64-apple-darwin.tar.gz"
      sha256 "4a05c953c162dfd0c876d88fac3252fd99afa8d1ccfbcaca3c2fc649a76470e1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c96a636f35713c2d620213eda7998b3f42bad81477360b0599e21a6a10220a8b"
    else
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c948566aa36d5b083d649bfc0abac3195b8685b04d19969a7de35fec9dd2cb62"
    end
  end

  def install
    bin.install "aas"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aas --version")
  end
end
