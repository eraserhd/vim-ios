module IOS
  module Vim

    class XcodeProjectFinder

      def initialize directory_lister
        @directory_lister = directory_lister
      end

      def find
        start_at_current_directory
        until at_topmost_directory?
          return project_in_this_directory if project_in_this_directory?
          move_up_one_directory
        end
        nil
      end

      def start_at_current_directory
        @directory = @directory_lister.current_directory
      end
      private :start_at_current_directory

      def at_topmost_directory?
        File.dirname(@directory) == @directory
      end
      private :at_topmost_directory?

      def project_in_this_directory?
        !projects_in_this_directory.empty?
      end
      private :project_in_this_directory?

      def project_in_this_directory
        XcodeProject.new File.join(@directory,projects_in_this_directory.first)
      end
      private :project_in_this_directory

      def move_up_one_directory
        @directory = File.dirname(@directory)
      end
      private :move_up_one_directory

      def entries_in_this_directory
        @directory_lister.list @directory
      end
      private :entries_in_this_directory

      def projects_in_this_directory
        entries_in_this_directory.select{|path| path =~ /\.xcodeproj$/i}
      end
      private :projects_in_this_directory

    end

  end
end
