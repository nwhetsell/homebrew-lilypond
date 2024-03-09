class Abjad < Formula
  include Language::Python::Virtualenv

  desc "Python API for building LilyPond files"
  homepage "https://abjad.github.io"
  url "https://files.pythonhosted.org/packages/96/cf/eb4be5cfe36a9195a925ec77b2d21ca225809445c6ede954716dca16bab6/abjad-3.19.tar.gz"
  sha256 "23db7739150a14594c7d726c0335e10b39750786bdfd9366bd25f6fd1e384cfb"
  license "GPL-3.0-only"
  revision 1

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/abjad-3.19"
    rebuild 1
    sha256 cellar: :any_skip_relocation, ventura:      "bfa14b1a82127b85b5359571f0ae788c2f6b9a6d906f7664e77512c9079d27b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dc4d2c4e76b2c12e174dd94b95e3ecb217a2f6b205e004db5110e8bd28e8c991"
  end

  depends_on "lilypond"
  depends_on "pygments"
  depends_on "python@3.11"

  resource "babel" do
    url "https://files.pythonhosted.org/packages/e2/80/cfbe44a9085d112e983282ee7ca4c00429bc4d1ce86ee5f4e60259ddff7f/Babel-2.14.0.tar.gz"
    sha256 "6919867db036398ba21eb5c7a0f6b28ab8cbc3ae7a73a44ebe34ae74a4e7d363"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/1f/53/a5da4f2c5739cf66290fac1431ee52aff6851c7c8ffd8264f13affd7bcdd/docutils-0.20.1.tar.gz"
    sha256 "f08a4e276c3a1583a86dce3e34aba3fe04d02bba2dd51ed16106244e8a923e3b"
  end

  resource "imagesize" do
    url "https://files.pythonhosted.org/packages/a7/84/62473fb57d61e31fef6e36d64a179c8781605429fd927b5dd608c997be31/imagesize-1.4.1.tar.gz"
    sha256 "69150444affb9cb0d5cc5a92b3676f0b2fb7cd9ae39e947a5e11a36b4497cd4a"
  end

  resource "jinja2" do
    url "https://files.pythonhosted.org/packages/b2/5e/3a21abf3cd467d7876045335e681d276ac32492febe6d98ad89562d1a7e1/Jinja2-3.1.3.tar.gz"
    sha256 "ac8bd6544d4bb2c9792bf3a159e80bba8fda7f07e81bc3aed565432d5925ba90"
  end

  resource "markupsafe" do
    url "https://files.pythonhosted.org/packages/87/5b/aae44c6655f3801e81aa3eef09dbbf012431987ba564d7231722f68df02d/MarkupSafe-2.1.5.tar.gz"
    sha256 "d283d37a890ba4c1ae73ffadf8046435c76e7bc2247bbb63c00bd1a709c6544b"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/fb/2b/9b9c33ffed44ee921d0967086d653047286054117d584f1b1a7c22ceaf7b/packaging-23.2.tar.gz"
    sha256 "048fb0e9405036518eaaf48a55953c750c11e1a1b68e0dd1a9d62ed0c092cfc5"
  end

  resource "ply" do
    url "https://files.pythonhosted.org/packages/e5/69/882ee5c9d017149285cab114ebeab373308ef0f874fcdac9beb90e0ac4da/ply-3.11.tar.gz"
    sha256 "00c7c1aaa88358b9c765b6d3000c6eec0ba42abca5351b095321aef446081da3"
  end

  resource "roman" do
    url "https://files.pythonhosted.org/packages/32/0c/10c242792e9c857d5d8df19780abec0f241c8a3d9631cccbce16d0f1c769/roman-4.1.tar.gz"
    sha256 "4da8a200529a730822a27f1704b3ac70bc907141d3bc558115fb8e36af13b412"
  end

  resource "sphinx" do
    url "https://files.pythonhosted.org/packages/73/8e/6e51da4b26665b4b92b1944ea18b2d9c825e753e19180cc5bdc818d0ed3b/sphinx-7.2.6.tar.gz"
    sha256 "9a5160e1ea90688d5963ba09a2dcd8bdd526620edbb65c328728f1b2228d5ab5"
  end

  resource "unidecode" do
    url "https://files.pythonhosted.org/packages/f7/89/19151076a006b9ac0dd37b1354e031f5297891ee507eb624755e58e10d3e/Unidecode-1.3.8.tar.gz"
    sha256 "cfdb349d46ed3873ece4586b96aa75258726e2fa8ec21d6f00a591d98806c2f4"
  end

  resource "uqbar" do
    url "https://files.pythonhosted.org/packages/ee/9d/cf25a9f711f11a34ce98a5330d79b69eba1f41c1c2919c1af6389ef755f1/uqbar-0.7.3.tar.gz"
    sha256 "f4a4262c2b0888771d880bb819e12efb06b7946c0464e3bea075ae845368b11d"
  end

  def python3
    which("python3.11")
  end

  def install
    virtualenv_install_with_resources

    python_version = Language::Python.major_minor_version(python3)
    (prefix/Language::Python.site_packages(python3)/"homebrew-abjad.pth").write <<~EOS
      import site; site.addsitedir('#{libexec}/lib/python#{python_version}/site-packages')
    EOS
  end

  test do
    system python3, "-c", "import abjad"
  end
end
