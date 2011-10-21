module IOS
  module Vim
    class Filename

      def initialize name
        @name = name
      end

      def extension
        @name.gsub(/^.*\./, '')
      end

    end
  end
end
