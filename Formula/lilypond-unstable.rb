class LilypondUnstable < Formula
  desc "Music engraving system"
  homepage "https://lilypond.org"
  url "https://lilypond.org/download/source/v2.25/lilypond-2.25.34.tar.gz"
  sha256 "fba01416abb1d1c917042514ad2a07eef381474164d9b9916a0492001ad233c7"
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
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/lilypond-unstable-2.25.34"
    sha256 arm64_tahoe:   "2ad228330c45c1dba0c10417b9f70a1d4ba53348ffce053383bf2715f6574f2a"
    sha256 arm64_sequoia: "360193ecce1c931b2b8c6e2504426762929ed52c575787e830bdc3f6f0b77c85"
    sha256 arm64_sonoma:  "d1a4071309d9f098b58069021017f6814a1287a49f489d3213d3b39b410c37e3"
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
  depends_on "make" => :build # make >= 4.2 is required
  depends_on "pkg-config" => :build
  depends_on "t1utils" => :build
  depends_on "texinfo" => :build # makeinfo >= 6.1 is required
  depends_on "texlive" => :build
  depends_on "bdw-gc"
  depends_on "cairo"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "ghostscript"
  depends_on "glib"
  depends_on "guile"
  depends_on "libpng"
  depends_on "pango"
  depends_on "python@3.14"

  uses_from_macos "flex" => :build
  uses_from_macos "perl" => :build
  uses_from_macos "zlib"

  on_macos do
    depends_on "gettext"
    depends_on "harfbuzz"
  end

  on_linux do
    depends_on "gettext" => :build
  end

  resource "font-urw-base35" do
    url "https://github.com/ArtifexSoftware/urw-base35-fonts/archive/refs/tags/20200910.tar.gz"
    sha256 "e0d9b7f11885fdfdc4987f06b2aa0565ad2a4af52b22e5ebf79e1a98abd0ae2f"
  end

  def install
    system "./autogen.sh", "--noconfigure" if build.head?

    system "./configure", "--datadir=#{share}",
                          "--disable-documentation",
                          *("--with-flexlexer-dir=#{Formula["flex"].include}" if OS.linux?),
                          *std_configure_args

    system "make"
    system "make", "install"

    system "make", "bytecode"
    system "make", "install-bytecode"

    elisp.install share.glob("emacs/site-lisp/*.el")

    fonts = share/"lilypond"/File.read("out/VERSION").chomp/"fonts/otf"

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
    assert_path_exists testpath/"test.pdf"

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
