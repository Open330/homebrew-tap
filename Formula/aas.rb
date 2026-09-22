class Aas < Formula
  desc "Agent Account Switcher: multi-account switcher for LLM coding agents"
  homepage "https://github.com/Open330/aas"
  version "0.1.12"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-aarch64-apple-darwin.tar.gz"
      sha256 "9ddc6bfca04141a8f7939ac270d6ebe45e1611c7881e4220fcc88999f4b818ae"
    else
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-x86_64-apple-darwin.tar.gz"
      sha256 "4f8800eeb833ea1ab031900efb03146782df5ace160221a93aadc63c785fbd9a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f2d7095824bc2c0e75e49e380067888c0866c164d7a9a8a05d49baab7c5578e8"
    else
      url "https://github.com/Open330/aas/releases/download/v#{version}/aas-x86_64-unknown-linux-musl.tar.gz"
      sha256 "142fe68d7cc0a132ffa430f57915e4f43962418044a96a49d5313457455f781a"
    end
  end

  def install
    bin.install "aas"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aas --version")
  end
end
