class Abjad < Formula
  include Language::Python::Virtualenv

  desc "Python API for building LilyPond files"
  homepage "https://abjad.github.io"
  url "https://files.pythonhosted.org/packages/96/cf/eb4be5cfe36a9195a925ec77b2d21ca225809445c6ede954716dca16bab6/abjad-3.19.tar.gz"
  sha256 "23db7739150a14594c7d726c0335e10b39750786bdfd9366bd25f6fd1e384cfb"
  license "GPL-3.0-only"

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/abjad-3.19"
    sha256 cellar: :any_skip_relocation, ventura:      "81e047874a9064b0112957510e882ad033a960fa5b1784d3c7bba76649f62198"
    sha256 cellar: :any_skip_relocation, monterey:     "74940ba545950651d271c5a23b2588b0db11df847f12c0f0404f83a090b19aca"
    sha256 cellar: :any_skip_relocation, big_sur:      "d4b5a44b38b13c55025d5ff1b1f0de542ed82ca7fc2bdf8fc10226d3bab570c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9fdcedc8f95ca81054fc317b6537f38312306c9167f7a78bac5d6d692d78c324"
  end

  depends_on "lilypond"
  depends_on "pygments"
  depends_on "python-jinja"
  depends_on "python-packaging"
  depends_on "python-ply"
  depends_on "python@3.11"

  resource "babel" do
    url "https://files.pythonhosted.org/packages/ba/42/54426ba5d7aeebde9f4aaba9884596eb2fe02b413ad77d62ef0b0422e205/Babel-2.12.1.tar.gz"
    sha256 "cc2d99999cd01d44420ae725a21c9e3711b3aadc7976d6147f622d8581963455"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/6b/5c/330ea8d383eb2ce973df34d1239b3b21e91cd8c865d21ff82902d952f91f/docutils-0.19.tar.gz"
    sha256 "33995a6753c30b7f577febfc2c50411fec6aac7f7ffeb7c4cfe5991072dcf9e6"
  end

  resource "imagesize" do
    url "https://files.pythonhosted.org/packages/a7/84/62473fb57d61e31fef6e36d64a179c8781605429fd927b5dd608c997be31/imagesize-1.4.1.tar.gz"
    sha256 "69150444affb9cb0d5cc5a92b3676f0b2fb7cd9ae39e947a5e11a36b4497cd4a"
  end

  resource "roman" do
    url "https://files.pythonhosted.org/packages/32/0c/10c242792e9c857d5d8df19780abec0f241c8a3d9631cccbce16d0f1c769/roman-4.1.tar.gz"
    sha256 "4da8a200529a730822a27f1704b3ac70bc907141d3bc558115fb8e36af13b412"
  end

  resource "sphinx" do
    url "https://files.pythonhosted.org/packages/af/b2/02a43597980903483fe5eb081ee8e0ba2bb62ea43a70499484343795f3bf/Sphinx-5.3.0.tar.gz"
    sha256 "51026de0a9ff9fc13c05d74913ad66047e104f56a129ff73e174eb5c3ee794b5"
  end

  resource "unidecode" do
    url "https://files.pythonhosted.org/packages/0b/25/37c77fc07821cd06592df3f18281f5e716bc891abd6822ddb9ff941f821e/Unidecode-1.3.6.tar.gz"
    sha256 "fed09cf0be8cf415b391642c2a5addfc72194407caee4f98719e40ec2a72b830"
  end

  resource "uqbar" do
    url "https://files.pythonhosted.org/packages/72/f6/0826d9d8b856d7e809ca6f99977721f7fe3e80ca5cc8e47d5cad430e2781/uqbar-0.6.9.tar.gz"
    sha256 "ec0613ac15948ecba99263c62bff426cfece7215a740aaeb89764f2963b57d48"
  end

  def python3
    deps.map(&:to_formula)
        .find { |f| f.name.match?(/^python@\d\.\d+$/) }
        .opt_libexec/"bin/python"
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
