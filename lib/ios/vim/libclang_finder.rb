
module IOS
  module Vim

    class LibclangFinder
      def initialize(command_runner = ShellCommandRunner.new)
        @command_runner = command_runner
      end

      def find
        File.join(lib_directory, 'libclang.dylib')
      end

      def path_to_clang
        code, output = @command_runner.run "xcrun -find clang"
        raise IOError.new unless code == 0
        output.chop
      end
      private :path_to_clang

      def clang_directory
        File.dirname(path_to_clang)
      end
      private :clang_directory

      def lib_directory
        File.join(File.dirname(clang_directory),'lib')
      end
      private :lib_directory
    end

  end
end
