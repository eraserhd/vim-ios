
module IOS
  module Vim

    module Commands

      def command_A
        open_alternate 'edit'
      end

      def command_AV
        open_alternate 'vsplit'
      end

      def command_AS
        open_alternate 'split'
      end

      def command_AT
        open_alternate 'tabedit'
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
