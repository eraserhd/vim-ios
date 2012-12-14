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
require 'ios/vim/xcode_builder'
require 'ios/vim/xcodeproj_interface'
require 'ios/vim/zerg_xcode_version'

module IOS
  module Vim

    extend EditCommands
    extend XCommands

    def self.initialize
      CommandInstaller.new(self).install
      ClangCompleterizer.new.configure_environment
    end

    FILENAME_SPECIAL_CHARACTERS = " \t\n*?[{`$\\%#'\"|!<"

    def self.escape_filename(filename)
      return '\\-' if filename == '-'
      with_escape_before_leading_special(with_backslash_before_internal_specials(filename))
    end

    class <<self
      def with_backslash_before_internal_specials(filename)
        filename.gsub(/([#{Regexp.quote(FILENAME_SPECIAL_CHARACTERS)}])/) {'\\' + $1}
      end
      private :with_backslash_before_internal_specials

      def with_escape_before_leading_special(filename)
        filename.gsub(/^([+>])/) {'\\' + $1}
      end
      private :with_escape_before_leading_special
    end

  end 
end
