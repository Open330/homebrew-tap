class Tend < Formula
  desc "Agent CLI observability and orchestration layer for terminal multiplexers"
  homepage "https://github.com/Open330/tend"
  version "0.10.1"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "b0299af48328f517f9f0e78eefc0219e545bb6b2c7c730a02a9131c2c62ae135"
    else
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "594d20fc7a0872005b538b03276dffd0afc4d0ef462fda02389e2b0c4feb1454"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "904a177e23af6f82d508a05199346a8c972ed87ae00fe5e4e8f5b31414f8dc20"
    else
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f5b2da6b33de78153fc7409be6425ac90cc4b8c5dfb9c1de68950b6d4c3a6b53"
    end
  end

  def install
    bin.install "tend"
    bin.install "tendd"
  end

  # No backticks or unescaped dollar signs in here: this file is
  # written from an unquoted shell heredoc, which would run the one
  # as a command and expand the other.
  def caveats
    <<~CAVEATS
      Upgrading does not replace a tendd that is already running: the
      new binary lands on disk, and the live process keeps serving
      from the old one. This version of tendd notices the swap on its
      own and re-execs onto the new build within about 30 seconds.

      To pick it up immediately, or after disabling that in
      [daemon] restart_on_new_binary:

        tend daemon restart

      Run 'tend doctor' if anything looks stale; it reports a daemon
      whose version has drifted from the CLI's.
    CAVEATS
  end

  service do
    run [opt_bin/"tendd"]
    keep_alive true
    log_path var/"log/tendd.log"
    error_log_path var/"log/tendd.err.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tend --version")
  end
end
