
module IOS
  module Vim

    module Commands

      def edit_command_A(method)
        open_alternate method
      end

      def edit_command_Rspec(method)
        VIM.command "#{method} #{VIM::Buffer.current.name}"
      end

      def alternate_file_for(filename)
        AlternateFinder.new(filename).alternate
      end
      private :alternate_file_for

      def open_alternate(command)
        new_file = alternate_file_for VIM::Buffer.current.name  
        VIM.command "#{command} #{new_file}"
      end
      private :open_alternate

    end

  end
end
