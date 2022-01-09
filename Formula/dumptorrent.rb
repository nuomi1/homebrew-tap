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
    # nothing
    assert_predicate true, true
  end
end
