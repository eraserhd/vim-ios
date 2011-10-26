require 'ios/vim/alternate_finder'
require 'ios/vim/file_classifier'
require 'ios/vim/filename'

module IOS
  module Vim

    def self.initialize
      VIM.command 'autocmd FileType objc command! -buffer A :ruby IOS::Vim::alternate<CR>'
    end

    def self.alternate
      filename = VIM::Buffer.current.name
      new_file = AlternateFinder.new(FileClassifier.new(filename)).alternate
      VIM.command "edit #{new_file}"
    end
  end 
end
