
module IOS
  module Vim

    class LibclangFinder
      def initialize(command_runner = ShellCommandRunner.new)
        @command_runner = command_runner
      end

      def find
        code, output = @command_runner.run "xcrun -find clang"
        raise IOError.new unless code == 0
        File.join(File.dirname(File.dirname(output)),'lib','libclang.dylib')
      end
    end

  end
end
