
module IOS
  module Vim

    module Commands

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
        VIM.command "#{method} #{finder.new(VIM::Buffer.current.name).send what}"
      end
      private :find_and_edit

    end

  end
end
