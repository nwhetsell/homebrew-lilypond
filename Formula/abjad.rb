class Abjad < Formula
  include Language::Python::Virtualenv

  desc "Python API for building LilyPond files"
  homepage "https://abjad.github.io"
  url "https://files.pythonhosted.org/packages/4c/7c/8076aee6f4f22e0c38887fa8b2e82280135c4e42b93fef0ed26b22c47008/abjad-3.21.tar.gz"
  sha256 "c9cae864836921b87847b3d40f669853145ad8c37b3feaa0c9792ae4240f6d11"
  license "GPL-3.0-only"

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/abjad-3.21"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a892d9e65e161fe7e6c59759098e0473ce0b3422dbf433c933ea190909ccca8c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "18b8cff66d7ca2a83e4cc0a9a06426ac2a8949bd3ff89deca3fd5d3e2f3fe7ba"
    sha256 cellar: :any_skip_relocation, ventura:       "f28c1a2882dd9fd50671847c7869d9e05c2ea6aab6e3eb013374f0bc6d89d343"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "29be2597c8201abb651cfcfaaf9302b5052cae1901159ac92173521814bd6cd9"
  end

  depends_on "lilypond"
  depends_on "pygments"
  depends_on "python@3.13"

  resource "babel" do
    url "https://files.pythonhosted.org/packages/2a/74/f1bc80f23eeba13393b7222b11d95ca3af2c1e28edca18af487137eefed9/babel-2.16.0.tar.gz"
    sha256 "d1f3554ca26605fe173f3de0c65f750f5a42f924499bf134de6423582298e316"
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
    url "https://files.pythonhosted.org/packages/af/92/b3130cbbf5591acf9ade8708c365f3238046ac7cb8ccba6e81abccb0ccff/jinja2-3.1.5.tar.gz"
    sha256 "8fefff8dc3034e27bb80d67c671eb8a9bc424c0ef4c0826edbff304cceff43bb"
  end

  resource "markupsafe" do
    url "https://files.pythonhosted.org/packages/b2/97/5d42485e71dfc078108a86d6de8fa46db44a1a9295e89c5d6d4a06e23a62/markupsafe-3.0.2.tar.gz"
    sha256 "ee55d3edf80167e48ea11a923c7386f4669df67d7994554387f84e7d8b0a2bf0"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/d0/63/68dbb6eb2de9cb10ee4c9c14a0148804425e13c4fb20d61cce69f53106da/packaging-24.2.tar.gz"
    sha256 "c228a6dc5e932d346bc5739379109d49e8853dd8223571c7c5b55260edc0b97f"
  end

  resource "ply" do
    url "https://files.pythonhosted.org/packages/e5/69/882ee5c9d017149285cab114ebeab373308ef0f874fcdac9beb90e0ac4da/ply-3.11.tar.gz"
    sha256 "00c7c1aaa88358b9c765b6d3000c6eec0ba42abca5351b095321aef446081da3"
  end

  resource "roman" do
    url "https://files.pythonhosted.org/packages/2d/be/4fa4fbe13def6194e76270bd213d8924346e0a30be8e006d898359db1a00/roman-4.2.tar.gz"
    sha256 "05f335a1b2b0824f827ed42fff84b35909aab9013799145ed4508bdd4fa3b385"
  end

  resource "sphinx" do
    url "https://files.pythonhosted.org/packages/6f/6d/be0b61178fe2cdcb67e2a92fc9ebb488e3c51c4f74a36a7824c0adf23425/sphinx-8.1.3.tar.gz"
    sha256 "43c1911eecb0d3e161ad78611bc905d1ad0e523e4ddc202a58a821773dc4c927"
  end

  resource "unidecode" do
    url "https://files.pythonhosted.org/packages/f7/89/19151076a006b9ac0dd37b1354e031f5297891ee507eb624755e58e10d3e/Unidecode-1.3.8.tar.gz"
    sha256 "cfdb349d46ed3873ece4586b96aa75258726e2fa8ec21d6f00a591d98806c2f4"
  end

  resource "uqbar" do
    url "https://files.pythonhosted.org/packages/37/17/d930fa7a3ad8951974561c1b8fd21a7508ae8be162727459bcee12f33c87/uqbar-0.7.4.tar.gz"
    sha256 "ab8a7e922e7003f8181969eddadcc28846a49387c197d3fde8e373d99c650828"
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
