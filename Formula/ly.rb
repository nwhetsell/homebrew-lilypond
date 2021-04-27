class Ly < Formula
  include Language::Python::Virtualenv

  desc "Parse, manipulate or create documents in LilyPond format"
  homepage "https://github.com/frescobaldi/python-ly"
  url "https://files.pythonhosted.org/packages/9b/ed/e277509bb9f9376efe391f2f5a27da9840366d12a62bef30f44e5a24e0d9/python-ly-0.9.7.tar.gz"
  sha256 "d4d2b68eb0ef8073200154247cc9bd91ed7fb2671ac966ef3d2853281c15d7a8"
  license "GPL-2.0-or-later"

  depends_on "python@3.9"

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"99bottles.ly").write <<~EOS
      \header{
        title = "Ninety-Nine Bottles of Beer"
        composer =  "Traditional"
      }
    EOS

    output = shell_output("#{bin}/ly highlight #{testpath}/99bottles.ly")
    assert_match(/<span class="[^"]*">\s*"Ninety-Nine Bottles of Beer"/, output)
  end
end
