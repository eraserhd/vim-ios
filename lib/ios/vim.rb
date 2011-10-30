require 'ios/vim/alternate_finder'
require 'ios/vim/file_classifier'
require 'ios/vim/filename'
require 'ios/vim/interface'

module IOS
  module Vim

    def self.initialize
      VIM.command 'autocmd FileType objc,objcpp command! -buffer A :ruby IOS::Vim::alternate<CR>'
    end

    def self.interface
      IOS::Vim::Interface.new
    end

    def self.alternate
      filename = interface.current_buffer_name
      new_file = AlternateFinder.new(FileClassifier.new(filename)).alternate
      interface.command "edit #{new_file}"
    end

  end 
end
