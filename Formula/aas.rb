class Aas < Formula
  desc "Agent Account Switcher: multi-account switcher for LLM coding agents"
  homepage "https://github.com/Open330/aas"
  version "0.2.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-aarch64-apple-darwin.tar.gz"
      sha256 "a026d886cb7f7882cbbb0f7c9395640660cf8c00c90f03726321538ae9b0b120"
    else
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-x86_64-apple-darwin.tar.gz"
      sha256 "7d29325d4f0171d67bf5f651709cb404b70ec6df91e58d9ade2425c498341919"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-aarch64-unknown-linux-musl.tar.gz"
      sha256 "86e0b1be5fbd612c68121b26b9ccea3520ec278d4740a6a797d6666d2c34f9e7"
    else
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4e79d8271e360f996ff01b5c5de5116def6b4af0366d8fd95e114f6bd37c704b"
    end
  end

  def install
    bin.install "aas"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aas --version")
  end
end
