class Texi2htmlAT1 < Formula
  desc "Convert TeXinfo files to HTML"
  homepage "https://www.nongnu.org/texi2html/"
  url "https://download.savannah.gnu.org/releases/texi2html/texi2html-1.82.tar.gz"
  sha256 "6c7c94a2d88ffe218a33e91118c2b039336cbe3f2f8b4e3a78e4fd1502072936"
  license "GPL-2.0-or-later"

  keg_only :versioned_formula

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--infodir=#{info}",
                          "--mandir=#{man}",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.texi").write <<~EOS
      @ifnottex
      @node Top
      @top hello, world
      @end ifnottex
      @bye
    EOS
    system bin/"texi2html", "test.texi"
    assert_match /hello, world/, File.read("test.html")
  end
end
