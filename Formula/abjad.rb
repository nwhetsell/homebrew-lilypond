class Abjad < Formula
  include Language::Python::Virtualenv

  desc "Python API for building LilyPond files"
  homepage "https://abjad.github.io"
  url "https://files.pythonhosted.org/packages/8b/94/d567635e5255c561d8aece5c4e03a233760e4cce26406c0fd529862422ab/abjad-3.30.tar.gz"
  sha256 "7fb4d6bc98325984e3c7643e2c154b3968d1f6d1a9995eead99c465e325ff16f"
  license "GPL-3.0-only"

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/abjad-3.29_1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "46bc09c990e53a950dc3023b45374af660c99120b67bcbbe019fdf86bf8c064d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2d4ad870dbb6558b9464c58841d79b53eb6dbf6f03e2ba4939bde8957fcbcada"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "526c5213c343b4381825a8f80fdd1df82cbeb2310e317a830e304ea6b3f26859"
  end

  depends_on "nwhetsell/lilypond/lilypond-unstable"
  depends_on "pygments"
  depends_on "python-packaging"
  depends_on "python@3.13"

  resource "babel" do
    url "https://files.pythonhosted.org/packages/7d/6b/d52e42361e1aa00709585ecc30b3f9684b3ab62530771402248b1b1d6240/babel-2.17.0.tar.gz"
    sha256 "0c54cffb19f690cdcc52a3b50bcbf71e07a808d1c80d549f2459b9d2cf0afb9d"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/ae/ed/aefcc8cd0ba62a0560c3c18c33925362d46c6075480bfa4df87b28e169a9/docutils-0.21.2.tar.gz"
    sha256 "3a6b18732edf182daa3cd12775bbb338cf5691468f91eeeb109deff6ebfa986f"
  end

  resource "imagesize" do
    url "https://files.pythonhosted.org/packages/a7/84/62473fb57d61e31fef6e36d64a179c8781605429fd927b5dd608c997be31/imagesize-1.4.1.tar.gz"
    sha256 "69150444affb9cb0d5cc5a92b3676f0b2fb7cd9ae39e947a5e11a36b4497cd4a"
  end

  resource "jinja2" do
    url "https://files.pythonhosted.org/packages/df/bf/f7da0350254c0ed7c72f3e33cef02e048281fec7ecec5f032d4aac52226b/jinja2-3.1.6.tar.gz"
    sha256 "0137fb05990d35f1275a587e9aee6d56da821fc83491a0fb838183be43f66d6d"
  end

  resource "markupsafe" do
    url "https://files.pythonhosted.org/packages/7e/99/7690b6d4034fffd95959cbe0c02de8deb3098cc577c67bb6a24fe5d7caa7/markupsafe-3.0.3.tar.gz"
    sha256 "722695808f4b6457b320fdc131280796bdceb04ab50fe1795cd540799ebe1698"
  end

  resource "ply" do
    url "https://files.pythonhosted.org/packages/e5/69/882ee5c9d017149285cab114ebeab373308ef0f874fcdac9beb90e0ac4da/ply-3.11.tar.gz"
    sha256 "00c7c1aaa88358b9c765b6d3000c6eec0ba42abca5351b095321aef446081da3"
  end

  resource "roman" do
    url "https://files.pythonhosted.org/packages/30/86/8bdb59db4b7ea9a2bd93f8d25298981e09a4c9f4744cf4cbafa7ef6fee7b/roman-5.1.tar.gz"
    sha256 "3a86572e9bc9183e771769601189e5fa32f1620ffeceebb9eca836affb409986"
  end

  resource "sphinx" do
    url "https://files.pythonhosted.org/packages/38/ad/4360e50ed56cb483667b8e6dadf2d3fda62359593faabbe749a27c4eaca6/sphinx-8.2.3.tar.gz"
    sha256 "398ad29dee7f63a75888314e9424d40f52ce5a6a87ae88e7071e80af296ec348"
  end

  resource "unidecode" do
    url "https://files.pythonhosted.org/packages/94/7d/a8a765761bbc0c836e397a2e48d498305a865b70a8600fd7a942e85dcf63/Unidecode-1.4.0.tar.gz"
    sha256 "ce35985008338b676573023acc382d62c264f307c8f7963733405add37ea2b23"
  end

  resource "uqbar" do
    url "https://files.pythonhosted.org/packages/a2/8d/38f413a3a01581e7e1866fd9bf529333dbebc1389114959c2327e6618959/uqbar-0.9.6.tar.gz"
    sha256 "05ac9c9c8d344a0673a6f1cfb9e5c003357fc960c911e6958964526642687da6"
  end

  def python3
    which("python3.13")
  end

  def install
    venv = virtualenv_install_with_resources

    (prefix/Language::Python.site_packages(python3)/"homebrew-abjad.pth").write <<~EOS
      import site; site.addsitedir('#{venv.site_packages}')
    EOS
  end

  test do
    system python3, "-c", "import abjad"
  end
end
