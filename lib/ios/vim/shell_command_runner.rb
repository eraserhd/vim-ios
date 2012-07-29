
module IOS
  module Vim

    class ShellCommandRunner
      def run command
        output = Kernel.send(:`, command)
        code = $?
        [ code, output ]
      end
    end

  end
end
