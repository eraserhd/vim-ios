module IOS
  module Vim
    class AlternateFinder

      HEADER_EXTENSIONS = ['h', 'hpp', 'hh', 'H', 'hxx']

      def initialize filename
        @filename = Filename.new filename
      end

      def header?
        HEADER_EXTENSIONS.include? @filename.extension
      end

      def alternate
        if header?
          source_file
        else
          header_file
        end
      end

      def source_file
        "#{@filename.stem}.m"
      end
      private :source_file

      def header_file
        "#{@filename.stem}.h"
      end
      private :header_file

    end
  end
end
