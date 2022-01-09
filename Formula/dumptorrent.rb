class Dumptorrent < Formula
  desc "Displays BitTorrent .torrent file information"
  homepage "https://sourceforge.net/projects/dumptorrent/"
  url "https://downloads.sourceforge.net/project/dumptorrent/dumptorrent/1.2/dumptorrent-1.2.tar.gz"
  sha256 "f583a9a2cac2d9522f98fe3245e2214734ead5bd9b9e017109beb95bd700701c"
  license "GPL-2.0-only"

  def install
    system "make"
    bin.install "dumptorrent"
  end

  test do
    require "open-uri"

    torrent_filename = "ubuntu-20.04.3-desktop-amd64.iso.torrent"

    open("https://releases.ubuntu.com/20.04/#{torrent_filename}") do |torrent|
      File.open(testpath / torrent_filename, "wb") do |file|
        file.write(torrent.read)
      end
    end

    torrent_info = shell_output("#{bin}/dumptorrent #{testpath / torrent_filename}")

    assert_match "ubuntu-20.04.3-desktop-amd64.iso 3071934464 (2.86G)", torrent_info
  end
end
