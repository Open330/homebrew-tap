class Muxa < Formula
  desc "Agent CLI observability and orchestration layer for terminal multiplexers"
  homepage "https://github.com/Open330/muxa"
  version "0.8.27"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "8792dec40493fa4c880b6e5544a9711afe905f4972bb81c5aedb08e8289f51b8"
    else
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "2045ac544019270b5ff1cb530973938a055104922ce98ddfa4dd0d3c45200c93"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5b8fc15e6ef717ce485f142337afc446ffc81dc01f9630681457509cf0c80e19"
    else
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4f3834295b05cfdfa4eff568451a1ef5e4f49980acb19210d6733586f8462c23"
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
