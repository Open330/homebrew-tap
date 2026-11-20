cask "tend-app" do
  version "0.10.29"
  sha256 "a1749105e71b0d76275643d6709ff56a915c46e7ea5d9e93f7c447c39d171fc8"

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
