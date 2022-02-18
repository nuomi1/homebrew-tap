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

    filepath = testpath / "leanify.tar.gz"

    open("https://github.com/JayXon/Leanify/archive/v0.4.3.tar.gz") do |file|
      File.binwrite(filepath, file.read)
    end

    system "#{bin}/leanify", filepath.to_s

    file_sha256 = Digest::SHA256.file(filepath).to_s

    assert_match "e31544d1d81712addfb99b82a9f19c27ee58aa080ade6d61485f325c2ff04df6", file_sha256
  end
end
