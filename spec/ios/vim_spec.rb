require 'ios/vim'

module VIM; class Buffer; end; end

describe IOS::Vim do

  before do
    VIM.stub(:command)
  end

  describe '::initialize' do
    it 'should map the :A command' do
      VIM.should_receive(:command).with('autocmd FileType objc,objcpp command! -buffer A :ruby IOS::Vim::command_A<CR>')
      IOS::Vim::initialize
    end

    it 'should map the :AV command' do
      VIM.should_receive(:command).with('autocmd FileType objc,objcpp command! -buffer AV :ruby IOS::Vim::command_AV<CR>')
      IOS::Vim::initialize
    end
  end

  describe '::commands' do
    it 'should return a command for class method named command_*' do
      IOS::Vim.instance_eval do
        class<<self
          def command_QwErTyUiOp; end
        end
      end
      IOS::Vim.send(:commands).should include(:QwErTyUiOp)
    end
  end

end
