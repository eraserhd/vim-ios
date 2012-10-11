module IOS
  module Vim
    class CommandInstaller

      EDIT_VARIANTS = {
        '' => 'edit',
        'E' => 'edit',
        'V' => 'vsplit',
        'S' => 'split',
        'T' => 'tabedit'
      }

      def initialize handler
        @handler = handler
      end

      def install
        install_script.each {|command| VIM.command command}
      end

      def install_script
        non_edit_commands_script + edit_commands_script
      end

      def non_edit_commands_script
        non_edit_commands.map{|command| script_for_non_edit_command command}
      end
      private :non_edit_commands_script

      def non_edit_commands
        @handler.methods.grep(/^command_/).map {|name| name.to_s.gsub(/^command_/, "").intern}
      end
      private :non_edit_commands

      def script_for_non_edit_command(command)
        "command! -nargs=* #{command} :ruby IOS::Vim::command_#{command}(<f-args>)<CR>"
      end
      private :script_for_non_edit_command

      def edit_commands_script
        edit_commands.map {|command| script_for_edit_command command}.flatten
      end
      private :edit_commands_script

      def script_for_edit_command(command)
        EDIT_VARIANTS.map do |infix, edit_method|
          variant = edit_command_variant command, infix
          "autocmd FileType objc,objcpp command! -buffer #{variant} :ruby IOS::Vim::edit_command_#{command}('#{edit_method}')<CR>"
        end
      end
      private :script_for_edit_command

      def edit_commands
        @handler.methods.grep(/^edit_command_/).map {|name| name.to_s.gsub(/^edit_command_/, "").intern}
      end
      private :edit_commands

      def edit_command_variant(command, infix)
        "#{command.to_s[0..0]}#{infix}#{command.to_s[1..-1]}"
      end
      private :edit_command_variant

    end
  end
end
