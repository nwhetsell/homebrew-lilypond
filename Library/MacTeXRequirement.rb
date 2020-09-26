class MacTeXRequirement < Requirement
  fatal true

  satisfy { Dir.exist?("/Library/TeX") }

  def message
    <<~EOS
      MacTeX is required. You can install it by running one of:
        brew cask install mactex-no-gui
        brew cask install mactex
      or by downloading and running an installer from:
        https://tug.org/mactex/mactex-download.html
    EOS
  end

  def display_s
    "MacTeX"
  end
end
