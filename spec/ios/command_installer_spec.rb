require 'ios/vim'

describe IOS::Vim::CommandInstaller do

  let(:handler) {Object.new}
  subject {IOS::Vim::CommandInstaller.new handler}

  describe '::install' do
    it 'should install detected edit commands' do
      subject.stub(:edit_commands).and_return([:FoObAr, :Baz])
      subject.should_receive(:edit_command_script).with(:FoObAr)
      subject.should_receive(:edit_command_script).with(:Baz)
      subject.send(:script)
    end

    it 'should install detected non-edit commands' do
      subject.stub(:non_edit_commands).and_return([:SlImE, :BaZBaR])
      subject.should_receive(:non_edit_command_script).with(:SlImE)
      subject.should_receive(:non_edit_command_script).with(:BaZBaR)
      subject.send(:script)
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
    let(:script) {subject.send(:edit_command_script, :Foobar)}

    it 'should map the command for each edit "type"' do
      script.should include("autocmd FileType objc,objcpp command! -buffer Foobar :ruby IOS::Vim::edit_command_Foobar('edit')<CR>")
      script.should include("autocmd FileType objc,objcpp command! -buffer FEoobar :ruby IOS::Vim::edit_command_Foobar('edit')<CR>")
      script.should include("autocmd FileType objc,objcpp command! -buffer FVoobar :ruby IOS::Vim::edit_command_Foobar('vsplit')<CR>")
      script.should include("autocmd FileType objc,objcpp command! -buffer FSoobar :ruby IOS::Vim::edit_command_Foobar('split')<CR>")
      script.should include("autocmd FileType objc,objcpp command! -buffer FToobar :ruby IOS::Vim::edit_command_Foobar('tabedit')<CR>")
    end
  end

  describe '::install_non_edit_command' do
    it 'should map the command' do
      subject.send(:non_edit_command_script, :FooBAR).should == "autocmd FileType objc,objcpp command! -buffer FooBAR :ruby IOS::Vim::command_FooBAR(<q-args>)<CR>"
    end
  end

end
