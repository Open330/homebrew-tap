class Tend < Formula
  desc "Agent CLI observability and orchestration layer for terminal multiplexers"
  homepage "https://github.com/Open330/tend"
  version "0.10.10"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "a6c1646e3fbec7be3d8db58d42de88a29b67b4532650dc36f35b66a67bb457cf"
    else
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "0ff4d4e9359c6e33e7f84d65f7b28edff7e1cd2bc6292153c468f0030955c21d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3592be0c5e2d24c7602ee869d0d287884acce6854dd45d47bf5f9bfdbcde9732"
    else
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f24a4dfc5044fff97b85b962f18f0e899c5d5002a9ab5a669419df69be724730"
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
