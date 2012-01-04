module IOS
  module Vim
    module XCommands

      def command_Xadd path, targets
        XcodeprojInterface.instance.add_file(
          VIM::Buffer.current.name,
          path,
          targets.split(/,/)
        )
      rescue Exception => e
        print e.to_s
      end

    end
  end
end
