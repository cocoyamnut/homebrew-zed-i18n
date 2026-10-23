cask "zed-i18n" do
  arch arm: "aarch64", intel: "x86_64"
  version "1.25.2,1"
  sha256 arm: "76ccf66e1c43c1dd5c93069c2531d15ba68e85f9756b242c99478b4d2ef501e5", intel: "1f045fccdd68af4f6f12c39f4be9408c2a0397e2ef421e519ca860f8097e2648", arm64_linux: "e82c585d95f1f30acc2e244fcd07d84f2e6dafc8dd17937b82a1dc441566cb3d", x86_64_linux: "7e78ffb98e7cb76eb9402bdcc46d4b56d7c40993cbdfb1a1f582dee7597e3087"

  on_macos do
    url "https://github.com/cocoyamnut/zed-i18n/releases/download/v#{version.csv.first}-i18n.#{version.csv.second}/Zed-i18n-macos-#{arch}.dmg"
    auto_updates true
    app "Zed i18n.app"
    binary "#{appdir}/Zed i18n.app/Contents/MacOS/cli", target: "zed-i18n"
  end

  on_linux do
    url "https://github.com/cocoyamnut/zed-i18n/releases/download/v#{version.csv.first}-i18n.#{version.csv.second}/zed-i18n-linux-#{arch}.tar.gz"
    command_wrapper "zed-i18n", content: <<~SH
      #!/bin/sh
      for arg in "$@"; do
        case "$arg" in
          --) break ;;
          --uninstall)
            echo "Remove this installation with: brew uninstall --cask zed-i18n" >&2
            exit 1
            ;;
        esac
      done
      export ZED_UPDATE_EXPLANATION="${ZED_UPDATE_EXPLANATION:-Run brew upgrade --cask zed-i18n to update.}"
      exec "#{staged_path}/zed.app/bin/zed" "$@"
    SH
    caveats <<~EOS
      Run zed-i18n to launch. Desktop menu entries are not installed.
      Linux requires system ALSA and Vulkan libraries and a working graphics driver.
    EOS
  end

  name "Zed i18n"
  desc "Localized build of the Zed editor"
  homepage "https://github.com/cocoyamnut/zed-i18n"
end
