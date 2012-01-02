require 'ios/vim/a_type_classifier'
require 'ios/vim/alternate_finder'
require 'ios/vim/edit_commands'
require 'ios/vim/filename'
require 'ios/vim/r_type_classifier'
require 'ios/vim/related_finder'
require 'ios/vim/x_commands'

module IOS
  module Vim

    def self.initialize
      edit_commands.each {|command| install_edit_command command}
    end

    class <<self

      def edit_commands
        methods.grep(/^edit_command_/).map {|name| name.to_s.gsub(/^edit_command_/, "").intern}
      end
      private :edit_commands

      EDIT_VARIANTS = {
        '' => 'edit',
        'E' => 'edit',
        'V' => 'vsplit',
        'S' => 'split',
        'T' => 'tabedit'
      }

      def install_edit_command(command)
        EDIT_VARIANTS.each do |infix, edit_method|
          variant = edit_command_variant command, infix
          VIM.command "autocmd FileType objc,objcpp command! -buffer #{variant} :ruby IOS::Vim::edit_command_#{command}('#{edit_method}')<CR>"
        end
      end
      private :install_edit_command

      def edit_command_variant(command, infix)
        "#{command.to_s[0..0]}#{infix}#{command.to_s[1..-1]}"
      end
      private :edit_command_variant

    end

    extend EditCommands
    extend XCommands

  end 
end
