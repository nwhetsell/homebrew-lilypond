class Extractpdfmark < Formula
  desc "Extract page mode and named destinations as PDFmark"
  homepage "https://github.com/trueroad/extractpdfmark"
  url "https://github.com/trueroad/extractpdfmark/archive/v1.1.0.tar.gz"
  sha256 "edc553051ab49b56cd9120a91b5548a88ee2fb92481330aaf4d45d0e3250761c"
  license "GPL-3.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/extractpdfmark-1.1.0_1"
    sha256 cellar: :any, catalina: "f61a9d72e9b60cb057725691b7bce95a2fdabc1e4a762aae5e6cbdc49297e277"
  end

  deprecate! date: "2021-10-13", because: "nwhetsell/lilypond is no longer maintained"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext"
  depends_on "poppler"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"extractpdfmark", test_fixtures("test.pdf")
  end
end
