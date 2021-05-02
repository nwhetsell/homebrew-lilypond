require_relative "../Library/MacTeXRequirement"

class DejaVuFontsRequirement < Requirement
  fatal true

  satisfy do
    require "open3"
    stdout, = Open3.capture2 "osascript", stdin_data: <<~EOS
      use framework "AppKit"
      return (current application's NSFontManager's sharedFontManager's availableFontFamilies) as list
    EOS
    fonts = stdout.chomp.split(/\s*,\s*/)
    (["DejaVu Sans", "DejaVu Sans Mono", "DejaVu Serif"] - fonts).empty?
  end

  def message
    <<~EOS
      DejaVu fonts are required.

      To install DejaVu fonts included with MacTeX, run:
        ln -s /Library/TeX/Root/texmf-dist/fonts/truetype/public/dejavu ~/Library/Fonts

      To install DejaVu fonts as a cask, run:
        brew tap homebrew/cask-fonts
        brew install --cask font-dejavu
    EOS
  end

  def display_s
    "DejaVu fonts"
  end
end

class Lilypond < Formula
  desc "Music engraving system"
  homepage "https://lilypond.org"
  url "https://lilypond.org/download/sources/v2.22/lilypond-2.22.1.tar.gz"
  sha256 "72ac2d54c310c3141c0b782d4e0bef9002d5519cf46632759b1f03ef6969cc30"
  license all_of: ["GPL-3.0-or-later", "GPL-3.0-only", "OFL-1.1-RFN",
                   "GFDL-1.3-no-invariants-or-later", :public_domain, "MIT"]
  revision 1

  head do
    url "https://git.savannah.gnu.org/git/lilypond.git"
    mirror "https://github.com/lilypond/lilypond.git"
  end

  option "with-html-documentation", "Build HTML documentation (may take an hour or more)"

  depends_on "./dblatex" => :build
  depends_on "./texi2html@1" => :build
  depends_on "autoconf" => :build
  depends_on "bison" => :build # bison >= 2.4.1 is required
  depends_on DejaVuFontsRequirement => :build if build.with? "html-documentation"
  depends_on "fontforge" => :build
  depends_on "gettext" => :build
  depends_on MacTeXRequirement => :build
  depends_on "texinfo" => :build # makeinfo >= 6.1 is required
  depends_on "./extractpdfmark"
  depends_on "./guile@1"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "ghostscript"
  depends_on "imagemagick"
  depends_on :macos
  depends_on "pango"
  depends_on "python@3.9"

  uses_from_macos "flex" => :build
  uses_from_macos "perl" => :build
  uses_from_macos "zip" => :build

  resource "font-urw-base35" do
    # Use the same URL as the font-urw-base35 cask:
    # https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-urw-base35.rb
    url "https://github.com/ArtifexSoftware/urw-base35-fonts/archive/20170801.zip"
    sha256 "4505042c8859166f5bff77e33907e244b66eb4e04b56646e14e0a97e5757cd21"
  end

  def install
    system "./autogen.sh", "--noconfigure"

    inreplace "config.make.in",
      %r{^\s*elispdir\s*=\s*\$\(datadir\)/emacs/site-lisp\s*$},
      "elispdir = $(datadir)/emacs/site-lisp/lilypond"

    mkdir "build" do
      resource("font-urw-base35").stage buildpath/"urw"

      ENV.append_path "PATH", "/Library/TeX/texbin"

      system "../configure", "--prefix=#{prefix}",
                             "--with-texgyre-dir=/Library/TeX/Root/texmf-dist/fonts/opentype/public/tex-gyre",
                             "--with-urwotf-dir=#{buildpath}/urw/fonts"

      ENV.prepend_path "LTDL_LIBRARY_PATH", Formula["guile@1"].lib

      system "make"
      system "make", "install"

      libexec.install bin/"lilypond"

      (bin/"lilypond").write <<~EOS
        #!/bin/sh
        GUILE_WARN_DEPRECATED=no LTDL_LIBRARY_PATH="#{Formula["guile@1"].lib}:$LTDL_LIBRARY_PATH" #{opt_libexec}/lilypond "$@"
      EOS

      pkgshare.install_symlink version => "current"

      if build.with? "html-documentation"
        system "make", "doc"
        system "make", "install-doc"
      end
    end
  end

  test do
    (testpath/"test.ly").write "\\relative { c' d e f g a b c }"
    system bin/"lilypond", "--loglevel=ERROR", "test.ly"
    assert_predicate testpath/"test.pdf", :exist?
  end
end
