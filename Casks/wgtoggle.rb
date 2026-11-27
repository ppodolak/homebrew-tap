cask "wgtoggle" do
  version "1.4.0"
  sha256 "4adc246b41e6c0d255862d82bd25855ffa050859e78f767aa61fcf635b2dd1ba"

  url "https://github.com/ppodolak/wgtoggle/releases/download/v#{version}/WGToggle-#{version}.dmg"
  name "WGToggle"
  desc "Menu bar app for running multiple WireGuard tunnels at once"
  homepage "https://github.com/ppodolak/wgtoggle"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "wireguard-tools"
  depends_on macos: :ventura

  app "WGToggle.app"

  # The app is ad-hoc signed, not notarized: clear the quarantine flag so it opens.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/WGToggle.app"],
        writable_paths: ["WGToggle.app"],
        writable_base:  :appdir
  end

  uninstall quit: "local.wgtoggle"

  zap delete: [
        "/etc/sudoers.d/wgtoggle",
        "/Library/PrivilegedHelperTools/wgtoggle",
      ],
      trash:  [
        "~/Library/Logs/WGToggle",
        "~/Library/Preferences/local.wgtoggle.plist",
      ]
end
