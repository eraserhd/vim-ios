
module IOS
  module Vim

    class Interface
      def current_buffer_name
        VIM::Buffer.current.name  
      end

      def command cmd
        VIM.command cmd
      end
    end

  end
end
