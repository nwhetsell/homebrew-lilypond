class Texi2htmlAT1 < Formula
  desc "Convert TeXinfo files to HTML"
  homepage "https://www.nongnu.org/texi2html/"
  url "https://download.savannah.gnu.org/releases/texi2html/texi2html-1.82.tar.gz"
  sha256 "6c7c94a2d88ffe218a33e91118c2b039336cbe3f2f8b4e3a78e4fd1502072936"
  license "GPL-2.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/texi2html@1-1.82_1"
    sha256 cellar: :any_skip_relocation, catalina: "14b6b0d18e3f4a2eeae4c507131b39fa23904563025e41de1be85c69f68ca6be"
  end

  keg_only :versioned_formula

  deprecate! date: "2021-10-13", because: "nwhetsell/lilypond is no longer maintained"

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
    assert_match(/hello, world/, File.read("test.html"))
  end
end
