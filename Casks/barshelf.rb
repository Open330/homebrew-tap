cask "barshelf" do
  version "0.1.3"
  sha256 "a77facbf476e974532d338f792db652470da60a37a1d3eba7ad2500cd37cefae"

  url "https://github.com/Open330/barshelf/releases/download/v#{version}/BarShelf-#{version}-arm64.zip"
  name "BarShelf"
  desc "Menu bar app with OTP codes, LLM usage, recent files, and CI status widgets"
  homepage "https://github.com/Open330/barshelf"

  # No Sparkle feed in the bundle: Homebrew is the update path.
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "BarShelf.app"

  uninstall quit: "com.barshelf.app"

  zap trash: [
    "~/Library/Application Support/BarShelf",
    "~/Library/Caches/com.barshelf.app",
    "~/Library/HTTPStorages/com.barshelf.app",
    "~/Library/Preferences/com.barshelf.app.plist",
    "~/Library/Saved Application State/com.barshelf.app.savedState",
  ]
end
