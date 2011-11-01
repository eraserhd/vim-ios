require 'ios/vim/alternate_finder'
require 'ios/vim/commands'
require 'ios/vim/file_classifier'
require 'ios/vim/filename'

module IOS
  module Vim

    def self.initialize
      command_list.each {|command| map_buffer_command command}
    end

    class <<self

      def command_list
        [:A, :AV]
      end
      private :command_list

      def map_buffer_command(command)
        VIM.command "autocmd FileType objc,objcpp command! -buffer #{command} :ruby IOS::Vim::command_#{command}<CR>"
      end
      private :map_buffer_command

    end

    extend Commands

  end 
end
