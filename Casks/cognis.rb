cask "cognis" do
  arch arm: "arm64", intel: "x86_64"

  version "0.18.2"
  sha256 arm:   "33172a60de2171ab9f9b0e25f4a4844c13f99d9cc728831a365a64e55059b5fc",
         intel: "2a9f3dd045a0f3252bfb89d846ae5c7b856a815b0352ddf74efdc213b26210b8"

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
