# Homebrew cask for amux. Publish to Open330/homebrew-tap so users can
# `brew install --cask open330/tap/amux`.
#
# `version` + `sha256` identify the most recent immutable published release.
# Update both after the release workflow prints the new DMG checksum.
cask "amux" do
  version "0.2.0"
  sha256 "fc770cf3403aba9728dbe0fb03c6d151a910518d3de3dec312975573ae737482"

  url "https://github.com/Open330/amux/releases/download/v#{version}/amux-macos.dmg"
  name "amux"
  desc "Agent-first terminal with tmux-native workspaces"
  homepage "https://github.com/Open330/amux"

  # amux ships Sparkle; let it self-update once installed.
  auto_updates true
  depends_on macos: :sonoma

  app "amux.app"

  zap trash: [
    "~/Library/Application Support/com.open330.amux",
    "~/Library/Caches/com.open330.amux",
    "~/Library/LaunchAgents/com.open330.amux.muxad.plist",
    "~/Library/Preferences/com.open330.amux.plist",
  ]
end
