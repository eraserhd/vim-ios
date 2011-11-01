require 'ios/vim/alternate_finder'
require 'ios/vim/commands'
require 'ios/vim/file_classifier'
require 'ios/vim/filename'

module IOS
  module Vim

    def self.initialize
      VIM.command 'autocmd FileType objc,objcpp command! -buffer A :ruby IOS::Vim::command_A<CR>'
      VIM.command 'autocmd FileType objc,objcpp command! -buffer AV :ruby IOS::Vim::command_AV<CR>'
    end

    extend Commands

  end 
end
