$:.push('lib')
require 'ios/vim'

class BufferDouble
  attr_accessor :name
end

module VIM;
  class Buffer
    class <<self
      attr_accessor :current
    end
  end
end

VIM::Buffer.current = BufferDouble.new

module VimHelpers

  def set_current_buffer_name(name)
    VIM::Buffer.current.name = name
  end

  def run_vim_command(command)
    command = command.gsub(/^:/, "")
    command_name, *args = command.split(/\s+/)
    IOS::Vim.send "command_#{command_name}", *args
  end

end

World(VimHelpers)
