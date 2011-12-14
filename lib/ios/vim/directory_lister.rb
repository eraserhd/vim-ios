module IOS
  module Vim

    class DirectoryLister

      def current_directory
        Dir.getwd
      end

      def list path
        Dir.entries path
      end

    end

  end
end
