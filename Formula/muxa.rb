class Muxa < Formula
  desc "Agent CLI observability and orchestration layer for terminal multiplexers"
  homepage "https://github.com/Open330/muxa"
  version "0.9.6"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "540244eb7688ccb0e957221d69d65f7550ab71c070018c4bd6be88a7ad77b68b"
    else
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "82928b08420b0566e203a36ea1f39d6a33501b95eea677d1ce98da8be99a887e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ca9c5221ceafcc948ba62c89d04ebbbdb920532c155f91d6bc4a8590998cfbd0"
    else
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "102974869f983b8f85175bf8de0fcb80d4223a5d173d2b54d76ff0891de26569"
    end
  end

  def install
    bin.install "muxa"
    bin.install "muxad"
  end

  # No backticks or unescaped dollar signs in here: this file is
  # written from an unquoted shell heredoc, which would run the one
  # as a command and expand the other.
  def caveats
    <<~CAVEATS
      Upgrading does not replace a muxad that is already running: the
      new binary lands on disk, and the live process keeps serving
      from the old one. This version of muxad notices the swap on its
      own and re-execs onto the new build within about 30 seconds.

      To pick it up immediately, or after disabling that in
      [daemon] restart_on_new_binary:

        muxa daemon restart

      Run 'muxa doctor' if anything looks stale; it reports a daemon
      whose version has drifted from the CLI's.
    CAVEATS
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
