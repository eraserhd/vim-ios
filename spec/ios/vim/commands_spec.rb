require 'ios/vim/commands'
require 'ios/vim/alternate_finder'

module VIM; class Buffer; end; end

describe IOS::Vim::Commands do

  subject do
    o = Object.new
    o.extend IOS::Vim::Commands
    o
  end

  describe '::command_A for some_file.h' do
    it "emits an ':edit some_file.mm' command" do
      VIM::Buffer.stub_chain(:current, :name).and_return('this_shouldnt_exist.h')
      subject.stub(:alternate_file_for).and_return('this_shouldnt_exist.mm')
      VIM.should_receive(:command).with('edit this_shouldnt_exist.mm')
      subject.command_A
    end
  end

  describe '::command_AV for some_file.h' do
    it "emits an ':vsplit some_file.mm' command" do
      VIM::Buffer.stub_chain(:current, :name).and_return('this_shouldnt_exist.h')
      subject.stub(:alternate_file_for).and_return('this_shouldnt_exist.mm')
      VIM.should_receive(:command).with('vsplit this_shouldnt_exist.mm')
      subject.command_AV
    end
  end

  describe '::alternate_file_for foo.h' do
    it 'should return what AlternateFinder returns' do
      IOS::Vim::AlternateFinder.should_receive(:new).with('foo.h').and_return(stub :alternate => 'foo.m')
      subject.send(:alternate_file_for,'foo.h').should == 'foo.m'
    end
  end

end
