cask "muxa-app" do
  version "0.8.56"
  sha256 "fded7790d33fe84b28da54a0f22f80c3dd7c372fdf26a78c91bc543b00e9d8e0"

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
