class Ly < Formula
  include Language::Python::Virtualenv

  desc "Parse, manipulate or create documents in LilyPond format"
  homepage "https://github.com/frescobaldi/python-ly"
  url "https://files.pythonhosted.org/packages/9b/ed/e277509bb9f9376efe391f2f5a27da9840366d12a62bef30f44e5a24e0d9/python-ly-0.9.7.tar.gz"
  sha256 "d4d2b68eb0ef8073200154247cc9bd91ed7fb2671ac966ef3d2853281c15d7a8"
  license "GPL-2.0-or-later"
  revision 1

  bottle do
    root_url "https://github.com/nwhetsell/homebrew-lilypond/releases/download/ly-0.9.7_1"
    sha256 cellar: :any_skip_relocation, catalina: "99429df75d9e0589673322548c930d6a614b0c1885c5400677937e4b9d2e6440"
  end

  depends_on "python@3.9"

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"test.ly").write "\\relative { c' d e f g a b c }"
    output = shell_output "#{bin}/ly 'transpose c d' #{testpath}/test.ly"
    assert_equal "\\relative { d' e fis g a b cis d }", output
  end
end
