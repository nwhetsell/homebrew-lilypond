class LilypondUnstable < Formula
  desc "Music engraving system"
  homepage "https://lilypond.org"
  url "https://lilypond.org/download/sources/v2.23/lilypond-2.23.80.tar.gz"
  sha256 "2b0c80d4ca73a7208eb593682a0cef79bae5ee86780f3c24b18c995c9264cff9"
  license all_of: [
    "GPL-3.0-or-later",
    "GPL-3.0-only",
    "OFL-1.1-RFN",
    "GFDL-1.3-no-invariants-or-later",
    :public_domain,
    "MIT",
  ]

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/lilypond-unstable-2.23.14"
    sha256 monterey:     "182a78ecc18789b962e544c507a08e45950bb0443c2737a6f036d608c0416166"
    sha256 big_sur:      "677c0bd8a31765ae29c38f6a7cbf5d6427d6c8ac4004365a5c28b4b23d7e3848"
    sha256 x86_64_linux: "a0ecefa59838d8337d60a99c6db796f30700103b0b6cc0ad3cbe05740d7f9508"
  end

  head do
    url "https://gitlab.com/lilypond/lilypond.git", branch: "master"
    mirror "https://github.com/lilypond/lilypond.git"
    mirror "https://git.savannah.gnu.org/git/lilypond.git"

    depends_on "autoconf" => :build
  end

  keg_only :versioned_formula

  depends_on "bison" => :build # bison >= 2.4.1 is required
  depends_on "fontforge" => :build
  depends_on "gettext" => :build
  depends_on "pkg-config" => :build
  depends_on "t1utils" => :build
  depends_on "texinfo" => :build # makeinfo >= 6.1 is required
  depends_on "texlive" => :build
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "ghostscript"
  depends_on "guile"
  depends_on "imagemagick"
  depends_on "pango"
  depends_on "python@3.10"

  uses_from_macos "flex" => :build
  uses_from_macos "perl" => :build

  def install
    system "./autogen.sh", "--noconfigure" if build.head?

    args = %W[
      --datadir=#{share}
      --disable-documentation
      --prefix=#{prefix}
    ]
    args << "--with-flexlexer-dir=#{Formula["flex"].include}" if OS.linux?
    args << "GUILE_FLAVOR=guile-3.0"
    system "./configure", *args

    system "make"
    system "make", "install"
    system "make", "bytecode"
    system "make", "install-bytecode"

    elisp.install share.glob("emacs/site-lisp/*.el")
  end

  test do
    (testpath/"test.ly").write "\\relative { c' d e f g a b c }"
    system bin/"lilypond", "--loglevel=ERROR", "test.ly"
    assert_predicate testpath/"test.pdf", :exist?
  end
end
