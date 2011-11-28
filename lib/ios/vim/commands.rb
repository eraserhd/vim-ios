
module IOS
  module Vim

    module Commands

      def edit_command_A(method)
        open_alternate method
      end

      def edit_command_Rspec(method)
        VIM.command "#{method} #{spec_for VIM::Buffer.current.name}"
      end
      
      def edit_command_Rimpl(method)
        VIM.command "#{method} #{RelatedFinder.new(VIM::Buffer.current.name).impl}"
      end

      def spec_for(filename)
        RelatedFinder.new(filename).spec
      end
      private :spec_for

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
