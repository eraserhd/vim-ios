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
        "#{command[0..0]}#{infix}#{command[1..-1]}"
      end
      private :edit_command_variant

    end

    extend Commands

  end 
end
