cask "tend-app" do
  version "0.10.4"
  sha256 "6098894109f43b89e91925cfb1b74730d6bb4e4fe5d6274d619cf5cf47e2fbf9"

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
