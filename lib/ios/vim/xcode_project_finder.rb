module IOS
  module Vim

    class XcodeProjectFinder

      def initialize directory_lister
        @directory_lister = directory_lister
      end

      def find
        @directory = @directory_lister.current_directory
        while true
          files = projects_in_current_directory
          unless files.empty?
            return XcodeProject.new File.join(@directory,files.first)
          end

          break if at_topmost_directory?
          @directory = File.dirname(@directory)
        end

        nil
      end

      def entries_in_current_directory
        @directory_lister.list @directory
      end
      private :entries_in_current_directory

      def projects_in_current_directory
        entries_in_current_directory.select{|path| path =~ /\.xcodeproj$/i}
      end
      private :projects_in_current_directory

      def at_topmost_directory?
        File.dirname(@directory) == @directory
      end
      private :at_topmost_directory?

    end

  end
end
