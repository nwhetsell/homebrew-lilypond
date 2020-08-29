class GuileAT1 < Formula
  desc "GNU Ubiquitous Intelligent Language for Extensions"
  homepage "https://www.gnu.org/software/guile/"
  url "https://ftp.gnu.org/gnu/guile/guile-1.8.8.tar.gz"
  mirror "https://ftpmirror.gnu.org/guile/guile-1.8.8.tar.gz"
  sha256 "c3471fed2e72e5b04ad133bbaaf16369e8360283679bcf19800bc1b381024050"
  license "LGPL-2.1-or-later"

  keg_only :versioned_formula

  depends_on "bdw-gc"
  depends_on "gmp"
  depends_on "libffi"
  depends_on "libtool"
  depends_on "libunistring"
  depends_on "pkg-config" # guile-config is a wrapper around pkg-config.
  depends_on "readline"

  def install
    # Work around Xcode 11 clang bug
    # https://bitbucket.org/multicoreware/x265/issues/514/wrong-code-generated-on-macos-1015
    ENV.append_to_cflags "-fno-stack-check" if DevelopmentTools.clang_build_version >= 1010

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-libreadline-prefix=#{Formula["readline"].opt_prefix}",
                          "--with-libgmp-prefix=#{Formula["gmp"].opt_prefix}"
    system "make", "install"

    # A really messed up workaround required on macOS --mkhl
    Pathname.glob("#{lib}/*.dylib") do |dylib|
      lib.install_symlink dylib.basename => "#{dylib.basename(".dylib")}.so"
    end
  end

  test do
    (testpath/"test.scm").write <<~EOS
      (display "hello, world")(newline)
    EOS

    ENV["GUILE_AUTO_COMPILE"] = "0"

    output = shell_output "#{bin}/guile test.scm"
    assert_match /^hello, world$/, output
  end
end
