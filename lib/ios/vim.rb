require 'ios/vim/alternate_finder'
require 'ios/vim/commands'
require 'ios/vim/file_classifier'
require 'ios/vim/filename'

module IOS
  module Vim

    def self.initialize
      commands.each {|command| map_buffer_command command}
      edit_commands.each {|command| install_edit_command command}
    end

    class <<self

      def commands
        methods.grep(/^command_/).map {|name| name.to_s.gsub(/^command_/, "").intern}
      end
      private :commands

      def edit_commands
        methods.grep(/^edit_command_/).map {|name| name.to_s.gsub(/^edit_command_/, "").intern}
      end
      private :edit_commands

      def map_buffer_command(command)
        VIM.command "autocmd FileType objc,objcpp command! -buffer #{command} :ruby IOS::Vim::command_#{command}<CR>"
      end
      private :map_buffer_command

      def install_edit_command(command)
        VIM.command "autocmd FileType objc,objcpp command! -buffer #{command} :ruby IOS::Vim::edit_command_#{command}('edit')<CR>"
        VIM.command "autocmd FileType objc,objcpp command! -buffer #{edit_command_variant command, 'E'} :ruby IOS::Vim::edit_command_#{command}('edit')<CR>"
        VIM.command "autocmd FileType objc,objcpp command! -buffer #{edit_command_variant command, 'V'} :ruby IOS::Vim::edit_command_#{command}('vsplit')<CR>"
        VIM.command "autocmd FileType objc,objcpp command! -buffer #{edit_command_variant command, 'S'} :ruby IOS::Vim::edit_command_#{command}('split')<CR>"
        VIM.command "autocmd FileType objc,objcpp command! -buffer #{edit_command_variant command, 'T'} :ruby IOS::Vim::edit_command_#{command}('tabedit')<CR>"
      end
      private :install_edit_command

      def edit_command_variant(command, letter)
        "#{command[0..0]}#{letter}#{command[1..-1]}"
      end
      private :edit_command_variant

    end

    extend Commands

  end 
end
