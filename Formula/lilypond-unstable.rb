class LilypondUnstable < Formula
  desc "Music engraving system"
  homepage "https://lilypond.org"
  url "https://lilypond.org/download/sources/v2.23/lilypond-2.23.12.tar.gz"
  sha256 "48b67dfc9c9b96d77cfb51c0364f294c61d16fb32e6522490c363f4b82b0cff9"
  license all_of: [
    "GPL-3.0-or-later",
    "GPL-3.0-only",
    "OFL-1.1-RFN",
    "GFDL-1.3-no-invariants-or-later",
    :public_domain,
    "MIT",
  ]

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/lilypond-unstable-2.23.12"
    sha256 monterey:     "edf8d180588ebb504d57269874b67ee9c142a4b977b5f0ebf9b758f26bf977b5"
    sha256 big_sur:      "eeee96f773a3380d8646f62e30184ffe1a03edaede713b4ddb1511ac36e68cab"
    sha256 catalina:     "78e5514524add841f8e017383a9df9973e4ad35661e491ea9dc36d83141e8f57"
    sha256 x86_64_linux: "9f3077671ae1f32414720fdbf71d1052ff7d1058106ce35f4dcd501a3f3f5ca1"
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
  depends_on "guile@2"
  depends_on "imagemagick"
  depends_on "pango"
  depends_on "python@3.10"

  uses_from_macos "flex" => :build
  uses_from_macos "perl" => :build

  def install
    system "./autogen.sh", "--noconfigure" if build.head?

    system "./configure", "--prefix=#{prefix}",
                          "--datadir=#{share}",
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
