class Extractpdfmark < Formula
  desc "Extract page mode and named destinations as PDFmark"
  homepage "https://github.com/trueroad/extractpdfmark"
  url "https://github.com/trueroad/extractpdfmark/archive/v1.1.0.tar.gz"
  sha256 "edc553051ab49b56cd9120a91b5548a88ee2fb92481330aaf4d45d0e3250761c"
  license "GPL-3.0-or-later"
  revision 1

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
