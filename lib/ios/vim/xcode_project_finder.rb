module IOS
  module Vim

    class XcodeProjectFinder

      def initialize directory_lister
        @directory_lister = directory_lister
      end

      def find
        @directory = @directory_lister.current_directory
        while true
          files = @directory_lister.list(@directory).select{|path| path =~ /\.xcodeproj$/i}
          unless files.empty?
            return XcodeProject.new File.join(@directory,files.first)
          end

          break if File.dirname(@directory) == @directory
          @directory = File.dirname(@directory)
        end

        nil
      end

    end

  end
end
