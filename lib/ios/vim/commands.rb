
module IOS
  module Vim

    module Commands

      def edit_command_A(method)
        VIM.command "#{method} #{AlternateFinder.new(VIM::Buffer.current.name).alternate}"
      end

      def edit_command_Rspec(method)
        VIM.command "#{method} #{RelatedFinder.new(VIM::Buffer.current.name).spec}"
      end
      
      def edit_command_Rimpl(method)
        VIM.command "#{method} #{RelatedFinder.new(VIM::Buffer.current.name).impl}"
      end

    end

  end
end
