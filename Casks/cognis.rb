cask "cognis" do
  arch arm: "arm64", intel: "x86_64"

  version "0.18.3"
  sha256 arm:   "8d155d1278fc1bf5a2dd0a62c350b47fda365407fdc73a25c1dfc70d40a4da7c",
         intel: "0d5b00f9f9dd75e0439f749f52c6f0c4997212a2ada45854b548bf02a94a202a"

  url "https://github.com/fpytloun/cognis/releases/download/macos-v#{version}/cognis-#{version}-macos-#{arch}.dmg"
  name "Cognis"
  desc "Desktop companion for Cognis"
  homepage "https://github.com/fpytloun/cognis"

  depends_on macos: :sequoia

  app "Cognis.app"

  caveats <<~EOS
    This release is ad-hoc signed, not Apple Developer ID signed or notarized.
    After attempting to open Cognis, use System Settings > Privacy & Security >
    Open Anyway only if you trust this download. Managed devices may prohibit
    this override; contact your administrator. Do not disable Gatekeeper.
  EOS
end
