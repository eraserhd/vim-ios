require 'ios/vim'

module VIM
  class Buffer; end
end

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

  describe '::command_A for some_file.h' do
    it "emits an ':edit some_file.mm' command" do
      VIM::Buffer.stub_chain(:current, :name).and_return('this_shouldnt_exist.h')
      IOS::Vim.stub(:alternate_file_for).and_return('this_shouldnt_exist.mm')
      VIM.should_receive(:command).with('edit this_shouldnt_exist.mm')
      IOS::Vim::command_A
    end
  end

  describe '::command_AV for some_file.h' do
    it "emits an ':vsplit some_file.mm' command" do
      VIM::Buffer.stub_chain(:current, :name).and_return('this_shouldnt_exist.h')
      IOS::Vim.stub(:alternate_file_for).and_return('this_shouldnt_exist.mm')
      VIM.should_receive(:command).with('vsplit this_shouldnt_exist.mm')
      IOS::Vim::command_AV
    end
  end

  describe '::alternate_file_for foo.h' do
    before do
      IOS::Vim::AlternateFinder.should_receive(:new).with('foo.h').and_return(stub :alternate => 'foo.m')
    end

    subject { IOS::Vim.alternate_file_for('foo.h') }
    
    it { should == 'foo.m' }
  end

end
