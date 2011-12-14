module IOS
  module Vim

    class XcodeProjectFinder

      def initialize filesystem
        @filesystem = filesystem
      end

      def find
        directory = @filesystem.current_directory
        while true
          files = @filesystem.list(directory).select{|path| path =~ /\.xcodeproj$/i}
          unless files.empty?
            return XcodeProject.new File.join(directory,files.first)
          end

          break if File.dirname(directory) == directory
          directory = File.dirname(directory)
        end

        nil
      end

    end

  end
end
