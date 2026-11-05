cask "muxa-app" do
  version "0.9.5"
  sha256 "739585a6296f7f890fa19ecafc5f7e760b0d22d2c0d2b4c0a4bcdf4075b12f0a"

  url "https://github.com/Open330/muxa/releases/download/v#{version}/Muxa-#{version}.dmg"
  name "Muxa"
  desc "Native workbench for the muxa agent orchestration daemon"
  homepage "https://github.com/Open330/muxa"

  # No Sparkle in this app: Homebrew is the update path, so leave
  # auto_updates at its default of false.
  depends_on macos: :ventura

  app "Muxa.app"

  uninstall quit: "dev.muxa.mac"

  # Only what the app alone owns. The muxa CLI shares
  # ~/Library/Application Support/muxa, config.toml included, and
  # removing the app must not take the daemon's configuration with
  # it.
  zap trash: [
    "~/Library/Caches/dev.muxa.mac",
    "~/Library/HTTPStorages/dev.muxa.mac",
    "~/Library/Preferences/dev.muxa.mac.plist",
    "~/Library/Saved Application State/dev.muxa.mac.savedState",
  ]
end
