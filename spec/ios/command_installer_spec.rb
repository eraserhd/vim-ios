require 'ios/vim'

describe IOS::Vim::CommandInstaller do

  let(:handler) {Object.new}
  subject {IOS::Vim::CommandInstaller.new handler}

  describe '::install_commands' do
    it 'should install detected edit commands' do
      subject.stub(:edit_commands).and_return([:FoObAr, :Baz])
      subject.should_receive(:install_edit_command).with(:FoObAr)
      subject.should_receive(:install_edit_command).with(:Baz)
      subject.install_commands
    end

    it 'should install detected non-edit commands' do
      subject.stub(:non_edit_commands).and_return([:SlImE, :BaZBaR])
      subject.should_receive(:install_non_edit_command).with(:SlImE)
      subject.should_receive(:install_non_edit_command).with(:BaZBaR)
      subject.install_commands
    end
  end

  describe '::edit_commands' do
    it 'should return :QwErTyUiOp if edit_command_QwErTyUiOp is defined' do
      handler.stub :edit_command_QwErTyUiOp
      subject.send(:edit_commands).should include(:QwErTyUiOp)
    end
  end

  describe '::non_edit_commands' do
    it 'should return :FoBaR if command_FoBaR is defined' do
      handler.stub :command_FoBaR
      subject.send(:non_edit_commands).should include(:FoBaR)
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
      subject.send :install_edit_command, :Foobar
    end
  end

  describe '::install_non_edit_command' do
    it 'should map the command' do
      VIM.stub(:command)
      VIM.should_receive(:command).with("autocmd FileType objc,objcpp command! -buffer FooBAR :ruby IOS::Vim::command_FooBAR(<q-args>)<CR>")
      subject.send :install_non_edit_command, :FooBAR
    end
  end

end
