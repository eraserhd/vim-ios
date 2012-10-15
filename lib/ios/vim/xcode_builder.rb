require 'tempfile'

module IOS
  module Vim

    class XcodeBuilder
      def initialize(shell_command_runner = ShellCommandRunner.new)
        @shell_command_runner = shell_command_runner
      end

      def build
        VIM.command('echo "Building... "')
        (_, @output) = @shell_command_runner.run 'xcodebuild'
        if @output =~/\n\*\* BUILD FAILED \*\*/
          start_quickfix_mode
        else
          VIM.command('echon "OK"')
        end
      end

      def start_quickfix_mode
        t = Tempfile.new('xcodebuild-errors')
        t.write @output
      end
      private :start_quickfix_mode
    end

  end
end
