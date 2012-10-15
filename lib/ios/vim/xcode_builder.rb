module IOS
  module Vim

    class XcodeBuilder
      def build
        VIM.command('echo "Building... "')
        VIM.command('echon "OK"')
      end
    end

  end
end
