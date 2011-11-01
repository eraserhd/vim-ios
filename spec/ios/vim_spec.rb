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

end
