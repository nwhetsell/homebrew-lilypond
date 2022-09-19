class LilypondUnstable < Formula
  desc "Music engraving system"
  homepage "https://lilypond.org"
  url "https://lilypond.org/download/sources/v2.23/lilypond-2.23.13.tar.gz"
  sha256 "17a9d1ad0ec7d1b7501b742d6b65ef371c88007537a7b8cbc9d54573270ddf0a"
  license all_of: [
    "GPL-3.0-or-later",
    "GPL-3.0-only",
    "OFL-1.1-RFN",
    "GFDL-1.3-no-invariants-or-later",
    :public_domain,
    "MIT",
  ]

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/lilypond-unstable-2.23.13"
    sha256 monterey:     "6e75d45d9ec3b53903722ca2a2813e2b80729542c663fa65d3fe06cb01b276d6"
    sha256 big_sur:      "544b43a964d15707d50ebc3af607f82c11f3eeb4159b6b066d27404c0db5c3ea"
    sha256 x86_64_linux: "c7879c97a54204509910ec8e73338c416ae40a625ad7210dfed0b20f6c931b4e"
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
    system "make", "bytecode"
    system "make", "install"
    system "make", "install-bytecode"

    elisp.install share.glob("emacs/site-lisp/*.el")
  end

  test do
    (testpath/"test.ly").write "\\relative { c' d e f g a b c }"
    system bin/"lilypond", "--loglevel=ERROR", "test.ly"
    assert_predicate testpath/"test.pdf", :exist?
  end
end
