module IOS
  module Vim

    class XcodeProjectFinder

      def initialize directory_lister
        @directory_lister = directory_lister
      end

      def find
        start_at_current_directory
        until at_topmost_directory?
          project = project_in_this_directory
          return project if project

          move_to_parent_directory
        end
        nil
      end

      def start_at_current_directory
        @directory = @directory_lister.current_directory
      end
      private :start_at_current_directory

      def move_to_parent_directory
        @directory = File.dirname(@directory)
      end
      private :move_to_parent_directory

      def project_in_this_directory
        projects = projects_in_this_directory
        unless projects.empty?
          return XcodeProject.new File.join(@directory,projects.first)
        end
        nil
      end
      private :project_in_this_directory

      def entries_in_this_directory
        @directory_lister.list @directory
      end
      private :entries_in_this_directory

      def projects_in_this_directory
        entries_in_this_directory.select{|path| path =~ /\.xcodeproj$/i}
      end
      private :projects_in_this_directory

      def at_topmost_directory?
        File.dirname(@directory) == @directory
      end
      private :at_topmost_directory?

    end

  end
end
