module IOS
  module Vim

    class XcodeBuilder
      def initialize(shell_command_runner = ShellCommandRunner.new)
        @shell_command_runner = shell_command_runner
      end

      def build
        VIM.command('echo "Building... "')
        @shell_command_runner.run 'xcodebuild'
        VIM.command('echon "OK"')
      end
    end

  end
end
