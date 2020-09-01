class MacTeXRequirement < Requirement
  fatal true

  satisfy { Dir.exist?("/Library/TeX") }

  def message
    <<~EOS
      MacTeX is required. You can install it by running one of:
        brew cask install mactex-no-gui
        brew cask install mactex
      or by downloading and running an installer from
        https://tug.org/mactex/mactex-download.html
    EOS
  end
end

class LinkingGuileAT1Requirement < Requirement
  fatal true

  satisfy(build_env: false) do
    guile_path = which("guile")
    !guile_path.nil? && File.realpath(guile_path).match?(%r{^#{HOMEBREW_PREFIX}/Cellar/guile@1/#{Formula["guile@1"].version}/bin/guile$})
  end

  def message
    <<~EOS
      guile@1 needs to be linked:
        brew link --force guile@1
    EOS
  end

  def display_s
    "linking guile@1"
  end
end

class Lilypond < Formula
  desc "Music engraving system"
  homepage "https://lilypond.org"
  url "https://lilypond.org/download/sources/v2.20/lilypond-2.20.0.tar.gz"
  sha256 "595901323fbc88d3039ca4bdbc2d8c5ce46b182edcb3ea9c0940eba849bba661"
  license all_of: ["GPL-3.0-or-later", "GPL-3.0-only", "OFL-1.1-RFN"]
  revision 2
  head "https://git.savannah.gnu.org/git/lilypond.git"

  option "with-documentation", "Build with documentation (requires --HEAD)"

  depends_on "autoconf" => :build
  depends_on "bison" => :build
  depends_on "fontforge" => :build
  depends_on "texinfo" => :build # makeinfo >= 6.1 is required
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gmp"
  depends_on "harfbuzz"
  depends_on "libtool"
  depends_on :macos # Due to Python 2
  depends_on MacTeXRequirement
  depends_on "nwhetsell/lilypond/guile@1"
  depends_on "pango"

  uses_from_macos "flex" => :build
  uses_from_macos "perl" => :build

  if build.with? "documentation"
    depends_on "ghostscript"
    depends_on "imagemagick"
    depends_on LinkingGuileAT1Requirement
    depends_on "nwhetsell/lilypond/extractpdfmark"
    depends_on "nwhetsell/lilypond/texi2html@1"
  end

  resource "font-urw-base35" do
    url "https://github.com/ArtifexSoftware/urw-base35-fonts/archive/20170801.zip"
    sha256 "4505042c8859166f5bff77e33907e244b66eb4e04b56646e14e0a97e5757cd21"
  end

  def install
    ENV.append_path "PATH", "/Library/TeX/texbin"

    resource("font-urw-base35").stage buildpath/"urw"

    inreplace "config.make.in",
      %r{^elispdir\s*=\s*\$\(datadir\)/emacs/site-lisp$},
      "elispdir = $(datadir)/emacs/site-lisp/lilypond"

    system "./autogen.sh", "--noconfigure"

    mkdir "build" do
      args = %W[
        --prefix=#{prefix}
        --with-texgyre-dir=/Library/TeX/Root/texmf-dist/fonts/opentype/public/tex-gyre
        --with-urwotf-dir=#{buildpath}/urw/fonts
      ]

      args << "--disable-documentation" if build.without? "documentation"

      system "../configure", *args
      system "make"
      system "make", "install"
    end
  end

  def caveats
    <<~EOS
      For LilyPond to find Guile libraries, you may need to add to #{shell_profile}:
        export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:#{Formula["guile@1"].opt_lib}"
      or link guile@1 by running:
        brew link --force guile@1
    EOS
  end

  test do
    (testpath/"test.ly").write <<~EOS
      \\relative { c' d e f g a b c }
    EOS

    ENV["DYLD_LIBRARY_PATH"] = Formula["guile@1"].lib
    system bin/"lilypond", "test.ly"

    assert_predicate testpath/"test.pdf", :exist?
  end
end
