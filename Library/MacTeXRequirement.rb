# frozen_string_literal: true

class MacTeXRequirement < Requirement
  fatal true

  satisfy { Dir.exist?("/Library/TeX") }

  def message
    <<~EOS
      MacTeX is required. You can install it by running one of:
        brew install --cask mactex-no-gui
        brew install --cask mactex
      or by downloading and running an installer from:
        https://tug.org/mactex/mactex-download.html
    EOS
  end

  def display_s
    "MacTeX"
  end
end
