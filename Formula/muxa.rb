class Muxa < Formula
  desc "Agent CLI observability and orchestration layer for terminal multiplexers"
  homepage "https://github.com/Open330/muxa"
  version "0.8.21"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "b33191358c952f587394cd50a0399cba1a5214878790d3ad9ccbc618d771d8ab"
    else
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "6f71e8dc31ebf34b4ce1a9cded5e2c360ff69beb583ea88ded29b01751bf6eb3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a34bc0de1613c69b3d6445ace574bd61d319662ec7a85941bc6563e380636f7a"
    else
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4ae91390dd0491c86a4f322f1063ecfb1ea944fdfbc1d1a81cb31a132c3f230e"
    end
  end

  def install
    bin.install "muxa"
    bin.install "muxad"
  end

  service do
    run [opt_bin/"muxad"]
    keep_alive true
    log_path var/"log/muxad.log"
    error_log_path var/"log/muxad.err.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/muxa --version")
  end
end
