class Abjad < Formula
  include Language::Python::Virtualenv

  desc "Python API for building LilyPond files"
  homepage "https://abjad.github.io"
  url "https://files.pythonhosted.org/packages/7c/cf/0f655ee245ed4abad50817c5b10ad91cf0f65866b1055c28f3dff88b4687/abjad-3.5.tar.gz"
  sha256 "43c27caae8044d7e2d305e6d7a6a74cb76ede097efe542a73449a8bf1f92eaad"
  license "GPL-3.0-only"

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/abjad-3.4_3"
    sha256 cellar: :any_skip_relocation, big_sur: "895aba75b5dbabe90e26ce48f928c75460253b7c40d64e0d6c8d600b1ab1fe70"
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
    url "https://files.pythonhosted.org/packages/bf/10/ff66fea6d1788c458663a84d88787bae15d45daa16f6b3ef33322a51fc7e/MarkupSafe-2.0.1.tar.gz"
    sha256 "594c67807fb16238b30c44bdf74f36c02cdf22d1c8cda91ef8a0ed8dabf5620a"
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
    url "https://files.pythonhosted.org/packages/41/a6/93288318cfae2fa0ca978dfe6bb94b22b7e9a9e98b6149a4af00b1e76ee8/Unidecode-1.3.2.tar.gz"
    sha256 "669898c1528912bcf07f9819dc60df18d057f7528271e31f8ec28cc88ef27504"
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
