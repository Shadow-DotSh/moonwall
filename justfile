install:
  sudo install -Dm755 "./src/moonwall"                "/usr/bin/moonwall"
  sudo install -Dm755 "./src/etc/moonwall-daemon.sh"  "/etc/moonwall/moonwall-daemon.sh"
  sudo install -Dm644 "./src/etc/moonwall.rasi"       "/etc/moonwall/moonwall.rasi"
  sudo install -Dm644 "./src/etc/mpv.conf"            "/etc/moonwall/mpv.conf"

uninstall:
  sudo rm -f    "/usr/bin/moonwall"
  sudo rm -rf   "/etc/moonwall"

install-dependences:
  sudo pacman -S ffmpegthumbnailer mpv rofi socat xdg-user-dirs --needed

uninstall-dependences:
  sudo pacman -Rns ffmpegthumbnailer mpv rofi socat xdg-user-dirs
