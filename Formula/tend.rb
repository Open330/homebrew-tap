class Tend < Formula
  desc "Agent CLI observability and orchestration layer for terminal multiplexers"
  homepage "https://github.com/Open330/tend"
  version "0.10.8"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "13c85df40cd57a1bba5303e191b33a185292917810a870b66acd887543413bd2"
    else
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "3eb53e5e3321229d530a4476bc8d7dae92902408397d799a68c79b3187f40dc1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2ef089aa8826ba07a098e0484ef3f83822b65dfa76825fd29d0990e0776485eb"
    else
      url "https://github.com/Open330/tend/releases/download/v#{version}/tend-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d893419b050225ec016d517a8196f30e97f02b47d1d878e5a6019c38a12ed172"
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
