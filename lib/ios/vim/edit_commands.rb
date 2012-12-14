
module IOS
  module Vim

    module EditCommands

      def edit_command_A(method)
        find_and_edit method, AlternateFinder, :alternate
      end

      def edit_command_Rspec(method)
        find_and_edit method, RelatedFinder, :spec
      end
      
      def edit_command_Rimpl(method)
        find_and_edit method, RelatedFinder, :impl
      end

      def edit_command_R(method)
        find_and_edit method, RelatedFinder, :next
      end

      def find_and_edit(method, finder, what)
        filename = finder.new(VIM::Buffer.current.name).send what
        VIM.command "#{method} #{IOS::Vim.escape_filename filename}"
      end
      private :find_and_edit

    end

  end
end
