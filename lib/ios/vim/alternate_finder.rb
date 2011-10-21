module IOS
  module Vim
    class AlternateFinder

      def initialize filename
        @filename = filename
      end

      def alternate
        @filename.gsub(/\.(mm|cpp|m)$/, ".h")
      end

    end
  end
end
