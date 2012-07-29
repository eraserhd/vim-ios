require 'ios/vim/a_type_classifier'
require 'ios/vim/alternate_finder'
require 'ios/vim/clang_completerizer'
require 'ios/vim/command_installer'
require 'ios/vim/edit_commands'
require 'ios/vim/filename'
require 'ios/vim/libclang_finder'
require 'ios/vim/r_type_classifier'
require 'ios/vim/related_finder'
require 'ios/vim/shell_command_runner'
require 'ios/vim/x_commands'
require 'ios/vim/xcodeproj_interface'

module IOS
  module Vim

    extend EditCommands
    extend XCommands

    def self.initialize
      CommandInstaller.new(self).install
      ClangCompleterizer.new.configure_environment
    end

  end 
end
