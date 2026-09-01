class Muxa < Formula
  desc "Agent CLI observability and orchestration layer for terminal multiplexers"
  homepage "https://github.com/Open330/muxa"
  version "0.8.41"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "37638e0f19a0df22f46f1d0d9cde4d93a1997d79244b4b3149a004eb6e040d93"
    else
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "df41663402b7a21dfeab1ae01f6faeec7199d3061f6aeea651a16452b6c281f3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6a68973a35ec1e76e5778f87e9becf069a16c83b85714c9666f11cab1b7a3dd9"
    else
      url "https://github.com/Open330/muxa/releases/download/v#{version}/muxa-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5df4b7821ff72697b8423c503f9649e1e76a487af68cdaf01a0742a048936469"
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
