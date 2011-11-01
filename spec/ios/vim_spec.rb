require 'ios/vim'

module VIM; class Buffer; end; end

describe IOS::Vim do

  before do
    VIM.stub(:command)
  end

  describe '::initialize' do
    it 'should install detected commands' do
      IOS::Vim.stub(:commands).and_return([:FoObAr])
      VIM.should_receive(:command).with('autocmd FileType objc,objcpp command! -buffer FoObAr :ruby IOS::Vim::command_FoObAr<CR>')
      IOS::Vim::initialize
    end
  end

  describe '::commands' do
    it 'should return :QwErTyUiOp if command_QwErTyUiOp is defined' do
      IOS::Vim.instance_eval {class<<self; def command_QwErTyUiOp; end; end}
      IOS::Vim.send(:commands).should include(:QwErTyUiOp)
    end
  end

end
