class MacTeXRequirement < Requirement
  fatal true
  satisfy { Dir.exist?("/Library/TeX/texbin") }
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

class Lilypond < Formula
  desc "Music engraving system"
  homepage "https://lilypond.org"
  url "https://lilypond.org/download/sources/v2.20/lilypond-2.20.0.tar.gz"
  sha256 "595901323fbc88d3039ca4bdbc2d8c5ce46b182edcb3ea9c0940eba849bba661"
  license all_of: ["GPL-3.0-or-later", "GPL-3.0-only", "OFL-1.1-RFN"]
  head "https://git.savannah.gnu.org/git/lilypond.git"

  depends_on "autoconf" => :build
  depends_on "texinfo" => :build # makeinfo >= 6.1 is required
  depends_on "fontforge"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "ghostscript"
  depends_on "imagemagick"
  depends_on :macos # Due to Python 2
  depends_on MacTeXRequirement
  depends_on "nwhetsell/lilypond/guile@1"
  depends_on "pango"

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build
  uses_from_macos "perl" => :build

  resource "font-tex-gyre-cursor" do
    url "http://www.gust.org.pl/projects/e-foundry/tex-gyre/cursor/qcr2.004otf.zip"
    sha256 "ae8db1c134ec5c1b8c3999116b0610a5ad1c6f47520c3b4712b9bc914458dce9"
  end

  resource "font-tex-gyre-heros" do
    url "http://www.gust.org.pl/projects/e-foundry/tex-gyre/heros/qhv2.004otf.zip"
    sha256 "755954b7349b803fc1c3d82fe9d9c4f7cf66467af718eaaf4f78ae1a09bf265d"
  end

  resource "font-tex-gyre-schola" do
    url "http://www.gust.org.pl/projects/e-foundry/tex-gyre/schola/qcs2.005otf.zip"
    sha256 "24063368bfdc1046439e290299157621a437294ecbb39a938d2ddb2afa3daaf8"
  end

  resource "font-urw-base35" do
    url "https://github.com/ArtifexSoftware/urw-base35-fonts/archive/20170801.zip"
    sha256 "4505042c8859166f5bff77e33907e244b66eb4e04b56646e14e0a97e5757cd21"
  end

  def install
    ENV.append "LDFLAGS", "-L#{Formula["guile@1"].lib}"
    ENV.append_path "PATH", Formula["guile@1"].bin
    ENV.append_path "PATH", "/Library/TeX/texbin"

    %w[cursor heros schola].each do |suffix|
      resource("font-tex-gyre-#{suffix}").stage buildpath/"texgyre"
    end
    resource("font-urw-base35").stage buildpath/"urw"

    inreplace "config.make.in",
      %r{^elispdir\s*=\s*\$\(datadir\)/emacs/site-lisp$},
      "elispdir = $(datadir)/emacs/site-lisp/lilypond"

    mkdir "build" do
      system "../configure", "--disable-documentation",
                             "--prefix=#{prefix}",
                             "--with-texgyre-dir=#{buildpath}/texgyre",
                             "--with-urwotf-dir=#{buildpath}/urw/fonts"
      system "make"
      system "make", "install"
    end
  end

  def caveats
    <<~EOS
      For LilyPond to find Guile libraries, you may need to add to #{shell_profile}:
        export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:#{Formula["guile@1"].opt_lib}"
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
