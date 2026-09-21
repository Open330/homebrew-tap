cask "barshelf" do
  version "0.3.4"
  sha256 "96ec8a738ca97bb1b7bb3f512714002545e4f360e44faa4256a62d7c72c7e3c2"

  url "https://github.com/Open330/barshelf/releases/download/v#{version}/BarShelf-#{version}-arm64.zip"
  name "BarShelf"
  desc "Scriptable menu bar widget platform"
  homepage "https://github.com/Open330/barshelf"

  # Deliberately no `auto_updates true`. BarShelf *can* replace itself, but it
  # detects a Homebrew-installed copy and refuses, pointing at
  # `brew upgrade --cask barshelf` instead. Declaring auto_updates would make
  # `brew upgrade` skip this cask, and the two together leave no update path
  # at all.
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "BarShelf.app"

  # A menu bar app is almost always running, and replacing a live bundle
  # leaves the old build in memory until the user notices.
  uninstall quit: "com.barshelf.app"

  # Everything the app owns. The widgets directory is the one that matters:
  # losing it costs the user their installed widgets, so it is zap-only and
  # never touched by a plain uninstall.
  zap trash: [
    "~/Library/Application Support/barshelf",
    "~/Library/Caches/BarShelf",
    "~/Library/Caches/com.barshelf.app",
    "~/Library/HTTPStorages/com.barshelf.app",
    "~/Library/Logs/BarShelf",
    "~/Library/Preferences/com.barshelf.app.plist",
    "~/Library/Saved Application State/com.barshelf.app.savedState",
  ]
end
