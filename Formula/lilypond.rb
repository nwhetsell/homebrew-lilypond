class Lilypond < Formula
  desc "Music engraving system"
  homepage "https://lilypond.org"
  url "https://lilypond.org/download/sources/v2.23/lilypond-2.23.5.tar.gz"
  sha256 "72ac2d54c310c3141c0b782d4e0bef9002d5519cf46632759b1f03ef6969cc30"
  license all_of: [
    "GPL-3.0-or-later",
    "GPL-3.0-only",
    "OFL-1.1-RFN",
    "GFDL-1.3-no-invariants-or-later",
    :public_domain,
    "MIT",
  ]

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/lilypond-2.22.1_3"
    sha256 catalina: "e2f2a8855f4dd46b8af41886472ba9f661bb75fe46d3a8c0e13996eba2d4fe9b"
  end

  head do
    url "https://git.savannah.gnu.org/git/lilypond.git"
    mirror "https://github.com/lilypond/lilypond.git"

    depends_on "autoconf" => :build
  end

  depends_on "./dblatex" => :build
  depends_on "./extractpdfmark" => :build
  depends_on "./texi2html@1" => :build
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

  conflicts_with "lilypond", because: "both install `lilypond` binaries"

  resource "font-urw-base35" do
    # In case it's already installed (and therefore possibly cached), use the
    # same URL as the font-urw-base35 cask:
    #   https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-urw-base35.rb
    # Replacing the "tar.gz" extension with "zip" is a hack to circumvent
    # Homebrew's requirement of GitHub tarballs.
    url "https://github.com/ArtifexSoftware/urw-base35-fonts/archive/20200910.tar.gz".sub(/tar\.gz$/, "zip")
    sha256 "66eed7ca2dfbf44665aa34cb80559f4a90807d46858ccf76c34f9ac1701cfa27"
  end

  def install
    system "./autogen.sh", "--noconfigure" if build.head?

    mkdir "build" do
      resource("font-urw-base35").stage buildpath/"urw"

      texgyre_dir = "#{Formula["texlive"].opt_share}/texmf-dist/fonts/opentype/public/tex-gyre"
      system "../configure", "--prefix=#{prefix}",
                             "--datadir=#{share}",
                             "--with-texgyre-dir=#{texgyre_dir}",
                             "--with-urwotf-dir=#{buildpath}/urw/fonts"

      ENV.prepend_path "LTDL_LIBRARY_PATH", Formula["guile@2"].opt_lib

      system "make"
      system "make", "install"

      elisp.install share.glob("emacs/site-lisp/*.el")

      libexec.install bin/"lilypond"

      (bin/"lilypond").write_env_script libexec/"lilypond",
        GUILE_WARN_DEPRECATED: "no",
        LTDL_LIBRARY_PATH:     "#{Formula["guile@2"].opt_lib}:$LTDL_LIBRARY_PATH"
    end
  end

  test do
    (testpath/"test.ly").write "\\relative { c' d e f g a b c }"
    system bin/"lilypond", "--loglevel=ERROR", "test.ly"
    assert_predicate testpath/"test.pdf", :exist?
  end
end
