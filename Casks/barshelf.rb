cask "barshelf" do
  version "0.3.8"
  sha256 "1d4ece5029899dd34c6dfdedd0327b134a1897df34151166f489932f8335bc8c"

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
