cask "wgtoggle" do
  version "1.12.2"
  sha256 "09bcb7f1e7389f5c588efacbf3168a6abcd9d00e15008d176003c0e96ccce4a0"

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
  binary "#{appdir}/WGToggle.app/Contents/Resources/wgtoggle"
  bash_completion "#{appdir}/WGToggle.app/Contents/Resources/completions/wgtoggle.bash"
  zsh_completion "#{appdir}/WGToggle.app/Contents/Resources/completions/_wgtoggle"
  fish_completion "#{appdir}/WGToggle.app/Contents/Resources/completions/wgtoggle.fish"

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
