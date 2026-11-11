cask "tend-app" do
  version "0.10.7"
  sha256 "4acc11297f33715393bb10686f679ed1cbcc8887d5bc262407301f2647578a3f"

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
