class Abjad < Formula
  include Language::Python::Virtualenv

  desc "Python API for building LilyPond files"
  homepage "https://abjad.github.io"
  url "https://files.pythonhosted.org/packages/02/cf/a5dab7d0e8fcc576ec00711782c56457984de7a6942a55dd2aadef28e71e/abjad-3.6.tar.gz"
  sha256 "a8f2da5c7bb569f55532d74f41c4d9dc64b104fbf1253bafb5144f11d13d6e6a"
  license "GPL-3.0-only"

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/abjad-3.6"
    sha256 cellar: :any_skip_relocation, big_sur: "3170af4f2987c3e48911aa5183c16d6a1dcf3c33545bd916112aa1218b388229"
  end

  depends_on "lilypond"
  depends_on "python@3.10"
  depends_on "six"

  resource "Babel" do
    url "https://files.pythonhosted.org/packages/17/e6/ec9aa6ac3d00c383a5731cc97ed7c619d3996232c977bb8326bcbb6c687e/Babel-2.9.1.tar.gz"
    sha256 "bc0c176f9f6a994582230df350aa6e05ba2ebe4b3ac317eab29d9be5d2768da0"
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
    url "https://files.pythonhosted.org/packages/91/a5/429efc6246119e1e3fbf562c00187d04e83e54619249eb732bb423efa6c6/Jinja2-3.0.3.tar.gz"
    sha256 "611bb273cd68f3b993fabdc4064fc858c5b47a973cb5aa7999ec1ba405c87cd7"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/62/0f/52c009332fdadd484e898dc8f2acca0663c1031b3517070fd34ad9c1b64e/MarkupSafe-2.1.0.tar.gz"
    sha256 "80beaf63ddfbc64a0452b841d8036ca0611e049650e20afcb882f5d3c266d65f"
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
    url "https://files.pythonhosted.org/packages/94/9c/cb656d06950268155f46d4f6ce25d7ffc51a0da47eadf1b164bbf23b718b/Pygments-2.11.2.tar.gz"
    sha256 "4e426f72023d88d03b2fa258de560726ce890ff3b630f88c21cbb8b2503b8c6a"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/e3/8e/1cde9d002f48a940b9d9d38820aaf444b229450c0854bdf15305ce4a3d1a/pytz-2021.3.tar.gz"
    sha256 "acad2d8b20a1af07d4e4c9d2e9285c5ed9104354062f275f3fcd88dcef4f1326"
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
    url "https://files.pythonhosted.org/packages/c9/08/c2932e66460cfbc8973928d276dc82ccde2d24b365055eeda9f0afc1951e/Sphinx-4.4.0.tar.gz"
    sha256 "6caad9786055cb1fa22b4a365c1775816b876f91966481765d7d50e9f0dd35cc"
  end

  resource "Unidecode" do
    url "https://files.pythonhosted.org/packages/66/9e/e335087e5d7487f032aeb08e21d5c3068fd1f0862f3936748ca2e2949bcc/Unidecode-1.3.3.tar.gz"
    sha256 "8521f2853fd250891dc27d156a9d30e61c4e76319da963c4a1c27083a909ac30"
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
