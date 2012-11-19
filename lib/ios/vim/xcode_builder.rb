require 'tempfile'

module IOS
  module Vim

    class XcodeBuilder
      def initialize(shell_command_runner = ShellCommandRunner.new)
        @shell_command_runner = shell_command_runner
      end

      def build(params=nil)
        VIM.command('echo "Building... "')
        run_build(params)
        if build_failed?
          start_quickfix_mode
        else
          VIM.command('echon "OK"')
        end
      end

      def run_build(params)
        params = params+' ' if params
        build_cmd = "xcodebuild #{params}2>&1"
        (_, @output) = @shell_command_runner.run build_cmd
      end
      private :run_build

      def install(path, platform)
        VIM.command('echo "Installing... "')
        run_install_device(path)
        if install_failed?
          VIM.command('echon "Failed"')
        else
          VIM.command('echon "OK"')
        end
      end

      def run_install_device(path)
        run_cmd = "fruitstrap install --bundle #{path}"
        (_, @output) = @shell_command_runner.run(run_cmd)
      end
      private :run_install_device

      def build_failed?
        @output =~/\n\*\* BUILD FAILED \*\*/
      end
      private :build_failed?

      def install_failed?
        @output =~/\nAMDeviceInstallApplication failed: -402620393/
      end
      private :install_failed?

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
