class LilypondUnstable < Formula
  desc "Music engraving system"
  homepage "https://lilypond.org"
  url "https://lilypond.org/download/source/v2.25/lilypond-2.25.16.tar.gz"
  sha256 "018f0d7dc66c0fe243e3951ad5cf541de417a9648eab1a8040f5aaaab4432e16"
  license all_of: [
    "GPL-3.0-or-later",
    "GPL-3.0-only",
    "OFL-1.1-RFN",
    "GFDL-1.3-no-invariants-or-later",
    :public_domain,
    "MIT",
    "AGPL-3.0-only",
    "LPPL-1.3c",
  ]

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/lilypond-unstable-2.25.15"
    sha256 arm64_sonoma: "fd861cdb8e3e1d3f6acc695029a68d2ebb3123e8f254ef928eb71cffe5104a99"
    sha256 ventura:      "697691574fb6a4396ed47b81ceafe3e3966cf98baa332c13f70eb6df73a5fbb5"
    sha256 x86_64_linux: "e57c012436eaf52f0654af327771a391907dfdb81246a649a88df86f6becfbd3"
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
  depends_on "pango"
  depends_on "python@3.12"

  uses_from_macos "flex" => :build
  uses_from_macos "perl" => :build

  resource "font-urw-base35" do
    url "https://github.com/ArtifexSoftware/urw-base35-fonts/archive/refs/tags/20200910.tar.gz"
    sha256 "e0d9b7f11885fdfdc4987f06b2aa0565ad2a4af52b22e5ebf79e1a98abd0ae2f"
  end

  def install
    system "./autogen.sh", "--noconfigure" if build.head?

    system "./configure", "--datadir=#{share}",
                          "--disable-documentation",
                          *("--with-flexlexer-dir=#{Formula["flex"].include}" if OS.linux?),
                          "GUILE_FLAVOR=guile-3.0",
                          *std_configure_args

    system "make"
    system "make", "install"

    system "make", "bytecode"
    system "make", "install-bytecode"

    elisp.install share.glob("emacs/site-lisp/*.el")

    fonts = share/"lilypond"/version/"fonts/otf"

    resource("font-urw-base35").stage do
      ["C059", "NimbusMonoPS", "NimbusSans"].each do |name|
        Dir["fonts/#{name}-*.otf"].each do |font|
          fonts.install font
        end
      end
    end

    ["cursor", "heros", "schola"].each do |name|
      cp Dir[Formula["texlive"].share/"texmf-dist/fonts/opentype/public/tex-gyre/texgyre#{name}-*.otf"], fonts
    end
  end

  test do
    (testpath/"test.ly").write "\\relative { c' d e f g a b c }"
    system bin/"lilypond", "--loglevel=ERROR", "test.ly"
    assert_predicate testpath/"test.pdf", :exist?

    output = shell_output("#{bin}/lilypond --define-default=show-available-fonts")
             .encode("UTF-8", invalid: :replace, replace: "\ufffd")
    common_styles = ["Regular", "Bold", "Italic", "Bold Italic"]
    {
      "C059"            => ["Roman", *common_styles[1..]],
      "Nimbus Mono PS"  => common_styles,
      "Nimbus Sans"     => common_styles,
      "TeX Gyre Cursor" => common_styles,
      "TeX Gyre Heros"  => common_styles,
      "TeX Gyre Schola" => common_styles,
    }.each do |family, styles|
      styles.each do |style|
        assert_match(/^\s*#{family}:style=#{style}$/, output)
      end
    end
  end
end
