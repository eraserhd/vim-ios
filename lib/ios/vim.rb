require 'ios/vim/alternate_finder'
require 'ios/vim/file_classifier'
require 'ios/vim/filename'

module IOS
  module Vim

    def self.initialize
      VIM.command 'autocmd FileType objc,objcpp command! -buffer A :ruby IOS::Vim::command_A<CR>'
      VIM.command 'autocmd FileType objc,objcpp command! -buffer AV :ruby IOS::Vim::command_AV<CR>'
    end

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

    extend Commands

  end 
end
