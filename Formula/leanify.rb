class Leanify < Formula
  desc "Lightweight lossless file minifier/optimizer"
  homepage "https://github.com/JayXon/Leanify"
  url "https://github.com/JayXon/Leanify/archive/refs/tags/v0.4.3.tar.gz"
  sha256 "ae37565be8c4d8cb89e9e584fb43e8a5f22277a2db4486e388663f98e34ff526"
  license "MIT"
  head "https://github.com/JayXon/Leanify.git", branch: "master"

  bottle do
    root_url "https://github.com/nuomi1/homebrew-tap/releases/download/leanify-0.4.3"
    sha256 cellar: :any_skip_relocation, ventura:      "c91e1a655efbab7a134a52cc42220b248ba3fd27782aa5d00726070d8d31af0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e304424d7c956c251508f49fc36f84f6aa37d014890e6a9edf978511fa25eab2"
  end

  def install
    filename = "Makefile"
    text = File.read(filename)
    content = text.gsub("CFLAGS      += -Wall -O3 -msse2 -mfpmath=sse", "CFLAGS      += -Wall -O3")
    File.open(filename, "w") { |file| file << content }
    system "make"
    bin.install "leanify"
  end

  test do
    require "open-uri"

    url = "https://www.w3schools.com/xml/note.xml"
    filepath = testpath / "note.xml"
    matched = "f6ac01f8195108abfdd118de7153cb6a85ca1fb68b1a4b28560a73b98c1d5813"

    URI.parse(url).open do |file|
      File.binwrite(filepath, file.read)
    end

    system "#{bin}/leanify", filepath.to_s

    file_sha256 = Digest::SHA256.file(filepath).to_s

    assert_match matched, file_sha256
  end
end
