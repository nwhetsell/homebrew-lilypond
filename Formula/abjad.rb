class Abjad < Formula
  include Language::Python::Virtualenv

  desc "Python API for building LilyPond files"
  homepage "https://abjad.github.io"
  url "https://files.pythonhosted.org/packages/12/1f/79d81215427225a0b3b92baf4689a10c9f88d02dd54c49ff4d7c02ace3b8/abjad-3.28.tar.gz"
  sha256 "2782cf392cf7e06bc3470a421bccade0b02ab7e7610eb7c6fd6e39d5b651a609"
  license "GPL-3.0-only"

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/abjad-3.27"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2a90a95a03580c82cf6bf357b3e0fb000632a876d3a7ec4a1e480b1b794a468f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0dbc9ea40ca7bdb87d57c70f3e7e29e406d73dcdcf3d8c48f645d26bed8882ad"
    sha256 cellar: :any_skip_relocation, ventura:       "f114a42b40fbf748356423cf2f1cd23865c91c54b22a160c444fbb096ea9a61a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a0cbe2a62027589f2681528e9c1f6719b7f1c76c322063556c6731740e8b9e9"
  end

  depends_on "lilypond"
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
    url "https://files.pythonhosted.org/packages/b2/97/5d42485e71dfc078108a86d6de8fa46db44a1a9295e89c5d6d4a06e23a62/markupsafe-3.0.2.tar.gz"
    sha256 "ee55d3edf80167e48ea11a923c7386f4669df67d7994554387f84e7d8b0a2bf0"
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
    url "https://files.pythonhosted.org/packages/1b/0c/bb90e61c94de516f84d33bc0d6e0ccb9d155575b6509d212330da384e445/uqbar-0.9.3.tar.gz"
    sha256 "9e2854473a8231aee2ecc0ee4073fbb4aa5eed580957c8154626810d3933817e"
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
