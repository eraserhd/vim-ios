require 'tempfile'

module IOS
  module Vim

    class XcodeBuilder
      def initialize(shell_command_runner = ShellCommandRunner.new)
        @shell_command_runner = shell_command_runner
      end

      def build
        VIM.command('echo "Building... "')
        (_, output) = @shell_command_runner.run 'xcodebuild'
        if output =~/\n\*\* BUILD FAILED \*\*/
          t = Tempfile.new('xcodebuild-errors')
          t.write output
        else
          VIM.command('echon "OK"')
        end
      end
    end

  end
end
