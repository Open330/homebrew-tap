cask "tend-app" do
  version "0.10.5"
  sha256 "1a7da93f970f5c8d353aab7e3e8cee81d01ce755ba0b34f86e78b930d66b0618"

  url "https://github.com/Open330/tend/releases/download/v#{version}/Tend-#{version}.dmg"
  name "Tend"
  desc "Native workbench for the tend agent orchestration daemon"
  homepage "https://github.com/Open330/tend"

  # No Sparkle in this app: Homebrew is the update path, so leave
  # auto_updates at its default of false.
  depends_on macos: :ventura

  app "Tend.app"

  uninstall quit: "dev.tend.mac"

  # Only what the app alone owns. The tend CLI shares
  # ~/Library/Application Support/tend, config.toml included, and
  # removing the app must not take the daemon's configuration with
  # it.
  zap trash: [
    "~/Library/Caches/dev.tend.mac",
    "~/Library/HTTPStorages/dev.tend.mac",
    "~/Library/Preferences/dev.tend.mac.plist",
    "~/Library/Saved Application State/dev.tend.mac.savedState",
  ]
end
