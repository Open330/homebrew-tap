class Tend < Formula
  desc "Agent CLI observability and orchestration layer for terminal multiplexers"
  homepage "https://github.com/Open330/tend"
  version "0.10.41"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "27c169112f98e4cbe73357fd65ad2f0c32369026dd09929e8dce0c1e4d35e09b"
    else
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "ac9f5744c294f2008a4611efdb395dbbf77d416d585b31b554458aa1881d8996"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c77b58a65f9be175ef1229eb1f305eccdcd2082083542cc357ec90c23488ad1f"
    else
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f71f3bba78fc62daf9bf3bb40fe9c1493aa763157abd0ae885d579b7511e745a"
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
