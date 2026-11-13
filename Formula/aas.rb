class Aas < Formula
  desc "Agent Account Switcher: multi-account switcher for LLM coding agents"
  homepage "https://github.com/Open330/aas"
  version "0.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-aarch64-apple-darwin.tar.gz"
      sha256 "589a80d9a8b21ee2dfef76f80f3fc8d6df5e828d32099473fd5d1ed41e31b986"
    else
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-x86_64-apple-darwin.tar.gz"
      sha256 "61ae4422d8eed7c5d388c81ec7f306309fef5c615acce484abfde1fc6aa1d075"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f2b06961ffd6c386e61b0261d9a062ab7213a01fd0b0df8199088271fd4eabf4"
    else
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-x86_64-unknown-linux-musl.tar.gz"
      sha256 "477b7cb0da9b28e3b042514bccaa8372dd5573e2c14dc80aa6ee18920b2d042e"
    end
  end

  def install
    bin.install "aas"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aas --version")
  end
end
