cask "barshelf" do
  version "0.7.25"
  sha256 "65fe8bbc88abafc1aed6f776b3ea94010962b403b809b53008e7909148ceaa57"

  url "https://github.com/Open330/barshelf/releases/download/v#{version}/BarShelf-#{version}-arm64.zip"
  name "BarShelf"
  desc "Scriptable menu bar widget platform"
  homepage "https://github.com/Open330/barshelf"

  # Follow GitHub's "latest" release, which excludes pre-releases. Without
  # this, livecheck reads git tags and sync-upstream shipped a pre-release
  # tag (v0.5.0) to every Homebrew user.
  livecheck do
    url :url
    strategy :github_latest
  end

  # Deliberately no `auto_updates true`. BarShelf *can* replace itself, but it
  # detects a Homebrew-installed copy and refuses, pointing at
  # `brew upgrade --cask barshelf` instead. Declaring auto_updates would make
  # `brew upgrade` skip this cask, and the two together leave no update path
  # at all.
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "BarShelf.app"

  # A menu bar app is almost always running, and replacing a live bundle
  # leaves the old build in memory until the user notices.
  uninstall quit: "com.barshelf.app"

  # Everything the app owns. The widgets directory is the one that matters:
  # losing it costs the user their installed widgets, so it is zap-only and
  # never touched by a plain uninstall.
  #
  # The desktop widget extension is sandboxed: its container, the app
  # group it shares with the app, and their Application Scripts folders.
  zap trash: [
    "~/Library/Application Scripts/728FW73BS8.com.barshelf.shared",
    "~/Library/Application Scripts/com.barshelf.app.widgets",
    "~/Library/Application Support/barshelf",
    "~/Library/Caches/BarShelf",
    "~/Library/Caches/com.barshelf.app",
    "~/Library/Containers/com.barshelf.app.widgets",
    "~/Library/Group Containers/728FW73BS8.com.barshelf.shared",
    "~/Library/HTTPStorages/com.barshelf.app",
    "~/Library/Logs/BarShelf",
    "~/Library/Preferences/com.barshelf.app.plist",
    "~/Library/Saved Application State/com.barshelf.app.savedState",
  ]
end
