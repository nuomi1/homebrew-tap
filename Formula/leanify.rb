class Leanify < Formula
  desc "Lightweight lossless file minifier/optimizer"
  homepage "https://github.com/JayXon/Leanify"
  url "https://github.com/JayXon/Leanify/archive/v0.4.3.tar.gz"
  sha256 "ae37565be8c4d8cb89e9e584fb43e8a5f22277a2db4486e388663f98e34ff526"
  license "MIT"
  head "https://github.com/JayXon/Leanify.git", branch: "master"

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

    assert_match "a5caf07fb8e55709f3f8117360a4689c5a8a48f20f296a7f471f6d7a4cea4e8a", image_sha256
  end
end
