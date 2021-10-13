class GuileAT1 < Formula
  desc "GNU Ubiquitous Intelligent Language for Extensions"
  homepage "https://www.gnu.org/software/guile/"
  url "https://ftp.gnu.org/gnu/guile/guile-1.8.8.tar.gz"
  mirror "https://ftpmirror.gnu.org/guile/guile-1.8.8.tar.gz"
  sha256 "c3471fed2e72e5b04ad133bbaaf16369e8360283679bcf19800bc1b381024050"
  license "LGPL-2.1-or-later"
  revision 2

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/guile@1-1.8.8_2"
    sha256 catalina: "f012a39e0676dc03d656e38080129c3087993778f8bfd5b44b17e75ba2ed7a37"
  end

  keg_only :versioned_formula

  deprecate! date: "2021-10-13", because: "nwhetsell/lilypond is no longer maintained"

  depends_on "bdw-gc"
  depends_on "gmp"
  depends_on "libffi"
  depends_on "libtool"
  depends_on "libunistring"
  depends_on "pkg-config" # guile-config is a wrapper around pkg-config.
  depends_on "readline"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-libgmp-prefix=#{Formula["gmp"].opt_prefix}",
                          "--with-libreadline-prefix=#{Formula["readline"].opt_prefix}"
    system "make", "install"

    Pathname.glob("#{lib}/*.dylib") do |dylib|
      lib.install_symlink dylib.basename => "#{dylib.basename(".dylib")}.so"
    end
  end

  test do
    (testpath/"test.scm").write '(display "hello, world")(newline)'

    ENV["GUILE_AUTO_COMPILE"] = "0"

    output = shell_output "#{bin}/guile test.scm"
    assert_match(/^hello, world$/, output)
  end
end
