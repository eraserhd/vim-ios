module IOS
  module Vim

    class XcodeProjectFinder

      def initialize filesystem
        @filesystem = filesystem
      end

      def find
        files = @filesystem.list('.').select{|path| path =~ /\.xcodeproj$/i}
        return nil if files.empty?
        XcodeProject.new files.first
      end

    end

  end
end
