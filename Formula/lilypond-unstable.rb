class LilypondUnstable < Formula
  desc "Music engraving system"
  homepage "https://lilypond.org"
  url "https://lilypond.org/download/sources/v2.23/lilypond-2.23.8.tar.gz"
  sha256 "b1ab55c88d133f6576ef03e010686294f259792b7b20fb230bd88b373ce169ca"
  license all_of: [
    "GPL-3.0-or-later",
    "GPL-3.0-only",
    "OFL-1.1-RFN",
    "GFDL-1.3-no-invariants-or-later",
    :public_domain,
    "MIT",
  ]

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/lilypond-unstable-2.23.7"
    sha256 big_sur: "e11ca317a1accf949c1f8202a258c9b5fb07dad0c3a8a031f26fa8d07490f63e"
  end

  head do
    url "https://git.savannah.gnu.org/git/lilypond.git", branch: "master"
    mirror "https://github.com/lilypond/lilypond.git"

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
  depends_on "guile@2"
  depends_on "imagemagick"
  depends_on "pango"
  depends_on "python@3.9"

  uses_from_macos "flex" => :build
  uses_from_macos "perl" => :build

  def install
    system "./autogen.sh", "--noconfigure" if build.head?

    texgyre_dir = "#{Formula["texlive"].opt_share}/texmf-dist/fonts/opentype/public/tex-gyre"
    system "./configure", "--prefix=#{prefix}",
                          "--datadir=#{share}",
                          "--with-texgyre-dir=#{texgyre_dir}",
                          "--disable-documentation"

    ENV.prepend_path "LTDL_LIBRARY_PATH", Formula["guile@2"].opt_lib
    system "make"
    system "make", "install"

    elisp.install share.glob("emacs/site-lisp/*.el")

    libexec.install bin/"lilypond"

    (bin/"lilypond").write_env_script libexec/"lilypond",
      GUILE_WARN_DEPRECATED: "no",
      LTDL_LIBRARY_PATH:     "#{Formula["guile@2"].opt_lib}:$LTDL_LIBRARY_PATH"
  end

  test do
    (testpath/"test.ly").write "\\relative { c' d e f g a b c }"
    system bin/"lilypond", "--loglevel=ERROR", "test.ly"
    assert_predicate testpath/"test.pdf", :exist?
  end
end
