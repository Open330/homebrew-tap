class Tend < Formula
  desc "Agent CLI observability and orchestration layer for terminal multiplexers"
  homepage "https://github.com/Open330/tend"
  version "0.10.38"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "e21e75353ed0ec438608efea067bee795929cd3cfe3ea691963797cf780effb7"
    else
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "8d22506060ae9b2331a709838aae96d65e7fae91bd7ab42da8007470ae567bf3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "763d82b52b169caf64005e8ac9d1726fe742cc5dce0ad761d51e4024ffe6bb6b"
    else
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5daf01354af0d9d36ec5406adea5d54bdb9532f5bf5d44fa03f3341ab3172557"
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
