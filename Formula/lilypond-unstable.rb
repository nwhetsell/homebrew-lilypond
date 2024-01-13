class LilypondUnstable < Formula
  desc "Music engraving system"
  homepage "https://lilypond.org"
  url "https://lilypond.org/download/source/v2.25/lilypond-2.25.12.tar.gz"
  sha256 "eb339afa6bd737549062052299dc64610fc487e89a09bf857977bf76095b1e69"
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
  revision 1

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/lilypond-unstable-2.25.12_1"
    sha256 ventura:      "ffff31b812e609c740a2e340e9cbbfda80dab32052db12999e7ea5d697de030e"
    sha256 x86_64_linux: "bc4412146e0caefd4ba4b533b89b941d139b61a393e8cad541141c01c6f26807"
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
    (testpath/"test.ly").write <<~EOS
      \\relative { c' d e f g a b c }

      #(define-markup-command (pretty-print layout properties markup) (markup?)
        (let ((stencil (interpret-markup layout properties markup)))
          (pretty-print (ly:stencil-expr stencil))
          stencil))

      test-markup = \\markup {
        \\pretty-print "test"
        \\pretty-print \\bold "test"
        \\pretty-print \\italic "test"
        \\pretty-print \\bold \\italic "test"

        \\pretty-print \\sans "test"
        \\pretty-print \\sans \\bold "test"
        \\pretty-print \\sans \\italic "test"
        \\pretty-print \\sans \\bold \\italic "test"

        \\pretty-print \\typewriter "test"
        \\pretty-print \\typewriter \\bold "test"
        \\pretty-print \\typewriter \\italic "test"
        \\pretty-print \\typewriter \\bold \\italic "test"
      }

      \\test-markup

      \\markup \\override #'(fonts . ((serif      . "TeX Gyre Schola")
                                      (sans       . "TeX Gyre Heros")
                                      (typewriter . "TeX Gyre Cursor"))) {
        \\test-markup
      }
    EOS

    output = shell_output("#{bin}/lilypond --loglevel=ERROR test.ly")

    assert_predicate testpath/"test.pdf", :exist?

    common_styles = %w[Regular Bold Italic BoldItalic]
    {
      "C059"          => ["Roman", *common_styles[1..2], "BdIta"],
      "NimbusMonoPS"  => common_styles,
      "NimbusSans"    => common_styles,
      "TeXGyreCursor" => common_styles,
      "TeXGyreHeros"  => common_styles,
      "TeXGyreSchola" => common_styles,
    }.each do |family, styles|
      styles.each do |style|
        assert_match(/^\s*"#{family}-#{style}"$/, output)
      end
    end
  end
end
