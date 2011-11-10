require 'ios/vim'

module VIM; class Buffer; end; end

describe IOS::Vim do

  before do
    VIM.stub(:command)
  end

  describe '::initialize' do
    it 'should install detected edit commands' do
      IOS::Vim.stub(:edit_commands).and_return([:FoObAr, :Baz])
      IOS::Vim.should_receive(:install_edit_command).with(:FoObAr)
      IOS::Vim.should_receive(:install_edit_command).with(:Baz)
      IOS::Vim::initialize
    end
  end

  describe '::edit_commands' do
    it 'should return :QwErTyUiOp if edit_command_QwErTyUiOp is defined' do
      IOS::Vim.instance_eval {class<<self; def edit_command_QwErTyUiOp; end; end}
      IOS::Vim.send(:edit_commands).should include(:QwErTyUiOp)
    end
  end

  describe '::install_edit_command' do
    it 'should map the command for each edit "type"' do
      VIM.stub(:command)
      VIM.should_receive(:command).with("autocmd FileType objc,objcpp command! -buffer Foobar :ruby IOS::Vim::edit_command_Foobar('edit')<CR>")
      VIM.should_receive(:command).with("autocmd FileType objc,objcpp command! -buffer FEoobar :ruby IOS::Vim::edit_command_Foobar('edit')<CR>")
      VIM.should_receive(:command).with("autocmd FileType objc,objcpp command! -buffer FVoobar :ruby IOS::Vim::edit_command_Foobar('vsplit')<CR>")
      VIM.should_receive(:command).with("autocmd FileType objc,objcpp command! -buffer FSoobar :ruby IOS::Vim::edit_command_Foobar('split')<CR>")
      VIM.should_receive(:command).with("autocmd FileType objc,objcpp command! -buffer FToobar :ruby IOS::Vim::edit_command_Foobar('tabedit')<CR>")
      IOS::Vim.send :install_edit_command, :Foobar
    end
  end

end
