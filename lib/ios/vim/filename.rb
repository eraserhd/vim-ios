module IOS
  module Vim
    class Filename

      def initialize name
        @name = name
      end

      def extension
        @name.gsub(/^.*\./, '')
      end

      def stem
        @name.gsub(/\.[a-z]*$/, '')
      end

    end
  end
end
