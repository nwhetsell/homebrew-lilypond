class Abjad < Formula
  include Language::Python::Virtualenv

  desc "Python API for building LilyPond files"
  homepage "https://abjad.github.io"
  url "https://files.pythonhosted.org/packages/67/7f/9bfa1bb008820b96105f70e8e9dc0d68e019d14998456711a18f2e3a32df/abjad-3.4.tar.gz"
  sha256 "c97a21cb420c2332d86b38dc0825b1df34e358033ea0c7384cadd73726a9167a"
  license "GPL-3.0-only"
  revision 1

  depends_on "./lilypond"
  depends_on "python@3.9"
  depends_on "six"

  resource "Babel" do
    url "https://files.pythonhosted.org/packages/17/e6/ec9aa6ac3d00c383a5731cc97ed7c619d3996232c977bb8326bcbb6c687e/Babel-2.9.1.tar.gz"
    sha256 "bc0c176f9f6a994582230df350aa6e05ba2ebe4b3ac317eab29d9be5d2768da0"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/4c/17/559b4d020f4b46e0287a2eddf2d8ebf76318fd3bd495f1625414b052fdc9/docutils-0.17.1.tar.gz"
    sha256 "686577d2e4c32380bb50cbb22f575ed742d58168cee37e99117a854bcd88f125"
  end

  resource "imagesize" do
    url "https://files.pythonhosted.org/packages/e4/9f/0452b459c8ba97e07c3cd2bd243783936a992006cf4cd1353c314a927028/imagesize-1.2.0.tar.gz"
    sha256 "b1f6b5a4eab1f73479a50fb79fcf729514a900c341d8503d62a62dbc4127a2b1"
  end

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/39/11/8076571afd97303dfeb6e466f27187ca4970918d4b36d5326725514d3ed3/Jinja2-3.0.1.tar.gz"
    sha256 "703f484b47a6af502e743c9122595cc812b0271f661722403114f71a79d0f5a4"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/bf/10/ff66fea6d1788c458663a84d88787bae15d45daa16f6b3ef33322a51fc7e/MarkupSafe-2.0.1.tar.gz"
    sha256 "594c67807fb16238b30c44bdf74f36c02cdf22d1c8cda91ef8a0ed8dabf5620a"
  end

  resource "ply" do
    url "https://files.pythonhosted.org/packages/e5/69/882ee5c9d017149285cab114ebeab373308ef0f874fcdac9beb90e0ac4da/ply-3.11.tar.gz"
    sha256 "00c7c1aaa88358b9c765b6d3000c6eec0ba42abca5351b095321aef446081da3"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/ba/6e/7a7c13c21d8a4a7f82ccbfe257a045890d4dbf18c023f985f565f97393e3/Pygments-2.9.0.tar.gz"
    sha256 "a18f47b506a429f6f4b9df81bb02beab9ca21d0a5fee38ed15aef65f0545519f"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/b0/61/eddc6eb2c682ea6fd97a7e1018a6294be80dba08fa28e7a3570148b4612d/pytz-2021.1.tar.gz"
    sha256 "83a4a90894bf38e243cf052c8b58f381bfe9a7a483f6a9cab140bc7f702ac4da"
  end

  resource "quicktions" do
    url "https://files.pythonhosted.org/packages/10/fa/5008e5a2eb8c891db681e4f0d50dff9895c32b4ed022b3ceb10160c788f2/quicktions-1.11.tar.gz"
    sha256 "f66f0f6e8cc4eb3702fc7b4fb943db17c72f875bcb5c91f50af188d28d0aa2df"
  end

  resource "roman" do
    url "https://files.pythonhosted.org/packages/49/bc/98ff27d555e8315fc572fb84cb72219322a4ea562ab776687c6fd45335c1/roman-3.3.tar.gz"
    sha256 "2c46ac8db827d34e4fa9ccc0577e7f0b0d84f16ffe112351bd4f1ec2eb12d73f"
  end

  resource "Sphinx" do
    url "https://files.pythonhosted.org/packages/8d/4d/8a80613d0ceefca5a84e2e30b29da7719d429b4adcdb793d86079fad3790/Sphinx-4.0.2.tar.gz"
    sha256 "b5c2ae4120bf00c799ba9b3699bc895816d272d120080fbc967292f29b52b48c"
  end

  resource "Unidecode" do
    url "https://files.pythonhosted.org/packages/cd/31/245d8a384939aa0ee152c76fc62890f79f35fc41cd12839f5df268d9081d/Unidecode-1.2.0.tar.gz"
    sha256 "8d73a97d387a956922344f6b74243c2c6771594659778744b2dbdaad8f6b727d"
  end

  resource "uqbar" do
    url "https://files.pythonhosted.org/packages/1f/14/79995c7dcda1301822ec3c331fbb850150836e2e8c40e7207e44b7a99a44/uqbar-0.5.2.tar.gz"
    sha256 "844edfe3ba9e6f43ef39fd4f13893a5817423374f510928524c7a618404c1dea"
  end

  def install
    virtualenv_install_with_resources

    python_version = Language::Python.major_minor_version Formula["python@3.9"].bin/"python3"
    (lib/"python#{python_version}/site-packages/homebrew-abjad.pth").write <<~EOS
      import site; site.addsitedir('#{libexec}/lib/python#{python_version}/site-packages')
    EOS
  end

  test do
    system Formula["python@3.9"].bin/"python3", "-c", "import abjad"
  end
end
