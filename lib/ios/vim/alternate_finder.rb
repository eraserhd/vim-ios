module IOS
  module Vim
    class AlternateFinder
      def alternate_for filename
        filename.gsub(/\.m/, ".h")
      end
    end
  end
end
