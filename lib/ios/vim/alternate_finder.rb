module IOS
  module Vim
    class AlternateFinder

      def initialize filename
        @filename = filename
      end

      def alternate
        if extension == 'h'
          "#{stem}.m"
        else
          "#{stem}.h"
        end
      end

      def stem
          @filename.gsub(/\.[a-z]*$/, "")
      end
      private :stem

      def extension
        @filename.gsub(/^.*\./, '')
      end
      private :extension

    end
  end
end
