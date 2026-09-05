class Muxa < Formula
  desc "Agent CLI observability and orchestration layer for terminal multiplexers"
  homepage "https://github.com/Open330/muxa"
  version "0.8.44"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "04827d953093d5bab7b9015fcfe24074e14085041c004f1ea693d85b5d52a72e"
    else
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "7709890f4dc840e3e9fd36ae01a8c8563e4fb5d226d2de36ce08371d53910b03"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2ffecb157db8660fe208be1cb43b8763c76ef358632cda66cb816a23372e0808"
    else
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "36e92d91958b5ddb73ea6b3c00d0bd857c31931a6a7bf6e17839355e076fa130"
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
