require 'tempfile'

module IOS
  module Vim

    class XcodeBuilder
      def initialize(shell_command_runner = ShellCommandRunner.new)
        @shell_command_runner = shell_command_runner
      end

      def build
        VIM.command('echo "Building... "')
        run_build
        if build_failed?
          start_quickfix_mode
        else
          VIM.command('echon "OK"')
        end
      end

      def run_build
        (_, @output) = @shell_command_runner.run 'xcodebuild 2>&1'
      end
      private :run_build

      def build_failed?
        @output =~/\n\*\* BUILD FAILED \*\*/
      end
      private :build_failed?

      def start_quickfix_mode
        tmpfile = Tempfile.new('xcodebuild-errors')
        tmpfile.write @output
        tmpfile.close
        VIM.command "cfile #{tmpfile.path}"
      end
      private :start_quickfix_mode
    end

  end
end
