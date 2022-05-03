class Abjad < Formula
  include Language::Python::Virtualenv

  desc "Python API for building LilyPond files"
  homepage "https://abjad.github.io"
  url "https://files.pythonhosted.org/packages/19/df/a83cacb70ae0afaba74496c115622250c93e6e3e3890e9724e61360a4ef5/abjad-3.9.tar.gz"
  sha256 "6ca90c7182cbfbb17099c0a6461fc5204ea7ba4420ca6aeec25b0c25fb1f9e7b"
  license "GPL-3.0-only"

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/abjad-3.7"
    sha256 cellar: :any_skip_relocation, big_sur: "e9c3ae39e6df3154d806d9daa7cc99e9964db092dc65e973047c4ac57bf59326"
  end

  depends_on "./lilypond-unstable"
  depends_on "python@3.10"
  depends_on "six"

  resource "Babel" do
    url "https://files.pythonhosted.org/packages/23/a6/a616817c8e4fb1a69f7e8aae9fc7fce1a147e1a492f45b6fa0b7d6823178/Babel-2.10.1.tar.gz"
    sha256 "98aeaca086133efb3e1e2aad0396987490c8425929ddbcfe0550184fdc54cd13"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/57/b1/b880503681ea1b64df05106fc7e3c4e3801736cf63deffc6fa7fc5404cf5/docutils-0.18.1.tar.gz"
    sha256 "679987caf361a7539d76e584cbeddc311e3aee937877c87346f31debc63e9d06"
  end

  resource "imagesize" do
    url "https://files.pythonhosted.org/packages/f6/27/b147794d43249e8303a06f427e407a090696b65b81045e36f8873d8d8a42/imagesize-1.3.0.tar.gz"
    sha256 "cd1750d452385ca327479d45b64d9c7729ecf0b3969a58148298c77092261f9d"
  end

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/7a/ff/75c28576a1d900e87eb6335b063fab47a8ef3c8b4d88524c4bf78f670cce/Jinja2-3.1.2.tar.gz"
    sha256 "31351a702a408a9e7595a8fc6150fc3f43bb6bf7e319770cbc0db9df9437e852"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/1d/97/2288fe498044284f39ab8950703e88abbac2abbdf65524d576157af70556/MarkupSafe-2.1.1.tar.gz"
    sha256 "7f91197cc9e48f989d12e4e6fbc46495c446636dfc81b9ccf50bb0ec74b91d4b"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/df/9e/d1a7217f69310c1db8fdf8ab396229f55a699ce34a203691794c5d1cad0c/packaging-21.3.tar.gz"
    sha256 "dd47c42927d89ab911e606518907cc2d3a1f38bbd026385970643f9c5b8ecfeb"
  end

  resource "ply" do
    url "https://files.pythonhosted.org/packages/e5/69/882ee5c9d017149285cab114ebeab373308ef0f874fcdac9beb90e0ac4da/ply-3.11.tar.gz"
    sha256 "00c7c1aaa88358b9c765b6d3000c6eec0ba42abca5351b095321aef446081da3"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/59/0f/eb10576eb73b5857bc22610cdfc59e424ced4004fe7132c8f2af2cc168d3/Pygments-2.12.0.tar.gz"
    sha256 "5eb116118f9612ff1ee89ac96437bb6b49e8f04d8a13b514ba26f620208e26eb"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/2f/5f/a0f653311adff905bbcaa6d3dfaf97edcf4d26138393c6ccd37a484851fb/pytz-2022.1.tar.gz"
    sha256 "1e760e2fe6a8163bc0b3d9a19c4f84342afa0a2affebfaa84b01b978a02ecaa7"
  end

  resource "quicktions" do
    url "https://files.pythonhosted.org/packages/29/00/209cef20c7d6f87b93f7f47a894d9445794b564923572cdc5c2f55f66c67/quicktions-1.13.tar.gz"
    sha256 "1f398c375b00523b12832eef36f5ff86ae3d2d99929d34186da9a34685de68bd"
  end

  resource "roman" do
    url "https://files.pythonhosted.org/packages/49/bc/98ff27d555e8315fc572fb84cb72219322a4ea562ab776687c6fd45335c1/roman-3.3.tar.gz"
    sha256 "2c46ac8db827d34e4fa9ccc0577e7f0b0d84f16ffe112351bd4f1ec2eb12d73f"
  end

  resource "Sphinx" do
    url "https://files.pythonhosted.org/packages/d5/b9/b831ea20dde3c3b726e41403eaee92cc448083cef310790c31c6ccfb22e3/Sphinx-4.5.0.tar.gz"
    sha256 "7bf8ca9637a4ee15af412d1a1d9689fec70523a68ca9bb9127c2f3eeb344e2e6"
  end

  resource "Unidecode" do
    url "https://files.pythonhosted.org/packages/41/16/ee78864c2c2ba9bddba3978baa378f83270c8b7810eb7900f84e62a9ffac/Unidecode-1.3.4.tar.gz"
    sha256 "8e4352fb93d5a735c788110d2e7ac8e8031eb06ccbfe8d324ab71735015f9342"
  end

  resource "uqbar" do
    url "https://files.pythonhosted.org/packages/c2/e7/da05fcecfbebf2dca4fd9140fdd7744c6b6cf1aede5148db6e924eac4f29/uqbar-0.5.9.tar.gz"
    sha256 "d06d360268fca81f350c3d04d7084f358abdc5f53a25e5eb2ae116f05f478506"
  end

  def install
    virtualenv_install_with_resources

    python_version = Language::Python.major_minor_version Formula["python@3.10"].bin/"python3"
    (lib/"python#{python_version}/site-packages/homebrew-abjad.pth").write <<~EOS
      import site; site.addsitedir('#{libexec}/lib/python#{python_version}/site-packages')
    EOS
  end

  test do
    system Formula["python@3.10"].bin/"python3", "-c", "import abjad"
  end
end
