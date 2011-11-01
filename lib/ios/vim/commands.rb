
module IOS
  module Vim

    module Commands

      def command_A
        new_file = alternate_file_for VIM::Buffer.current.name  
        VIM.command "edit #{new_file}"
      end

      def command_AV
        new_file = alternate_file_for VIM::Buffer.current.name  
        VIM.command "vsplit #{new_file}"
      end

      def alternate_file_for(filename)
        AlternateFinder.new(filename).alternate
      end

    end

  end
end
