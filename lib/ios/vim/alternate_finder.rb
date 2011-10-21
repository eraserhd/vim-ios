module IOS
  module Vim
    class AlternateFinder

      HEADER_EXTENSIONS = ['h', 'hpp', 'hh', 'H', 'hxx']

      def initialize filename
        @filename = filename
      end

      def header?
        HEADER_EXTENSIONS.include? extension
      end

      def alternate
        if header?
          source_file
        else
          header_file
        end
      end

      def source_file
        "#{stem}.m"
      end
      private :source_file

      def header_file
        "#{stem}.h"
      end
      private :header_file

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
