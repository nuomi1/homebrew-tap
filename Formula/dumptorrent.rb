class Dumptorrent < Formula
  desc "Displays BitTorrent .torrent file information"
  homepage "https://sourceforge.net/projects/dumptorrent/"
  url "https://downloads.sourceforge.net/project/dumptorrent/dumptorrent/1.2/dumptorrent-1.2.tar.gz"
  sha256 "f583a9a2cac2d9522f98fe3245e2214734ead5bd9b9e017109beb95bd700701c"
  license "GPL-2.0-only"

  bottle do
    root_url "https://github.com/nuomi1/homebrew-tap/releases/download/dumptorrent-1.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "a8897f5476b4b5b88c7177ed95ef080006d38318f8fe0d90f3c60d632b67008b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "820a8b0451a17ab386d9321cfe58452c17498860921ac323b26527afb44380fb"
  end

  def install
    system "make"
    bin.install "dumptorrent"
  end

  test do
    require "open-uri"

    torrent_filename = "ubuntu-20.04.3-desktop-amd64.iso.torrent"

    open("https://releases.ubuntu.com/20.04/#{torrent_filename}") do |torrent|
      File.binwrite(testpath / torrent_filename, torrent.read)
    end

    torrent_info = shell_output("#{bin}/dumptorrent #{testpath / torrent_filename}")

    assert_match "ubuntu-20.04.3-desktop-amd64.iso 3071934464 (2.86G)", torrent_info
  end
end
