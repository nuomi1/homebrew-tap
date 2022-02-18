class Leanify < Formula
  desc "Lightweight lossless file minifier/optimizer"
  homepage "https://github.com/JayXon/Leanify"
  url "https://github.com/JayXon/Leanify/archive/v0.4.3.tar.gz"
  sha256 "ae37565be8c4d8cb89e9e584fb43e8a5f22277a2db4486e388663f98e34ff526"
  license "MIT"
  head "https://github.com/JayXon/Leanify.git"

  def install
    system "make"
    bin.install "leanify"
  end

  test do
    require "open-uri"

    image_filepath = testpath / "image.png"

    open("https://httpbin.org/image/png") do |image|
      File.binwrite(image_filepath, image.read)
    end

    system "#{bin}/leanify", image_filepath.to_s

    image_sha256 = Digest::SHA256.file(image_filepath).to_s

    assert_match "b6560c2651ccadd730eec38aa7d3e5be9ded68e87087f3e032d22429eb371745", image_sha256
  end
end
