class Leanify < Formula
  desc "Lightweight lossless file minifier/optimizer"
  homepage "https://github.com/JayXon/Leanify"
  url "https://github.com/JayXon/Leanify/archive/refs/tags/v0.4.3.tar.gz"
  sha256 "ae37565be8c4d8cb89e9e584fb43e8a5f22277a2db4486e388663f98e34ff526"
  license "MIT"
  head "https://github.com/JayXon/Leanify.git", branch: "master"

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
