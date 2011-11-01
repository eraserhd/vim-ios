require 'ios/vim/commands'
require 'ios/vim/alternate_finder'

module VIM; class Buffer; end; end

describe IOS::Vim::Commands do

  subject do
    o = Object.new
    o.extend IOS::Vim::Commands
    o
  end

  context 'when current buffer name is "this_shouldnt_exist.h"' do

    let(:expected_alternate) {'this_shouldnt_exist.mm'}

    before do
      VIM::Buffer.stub_chain(:current, :name).and_return('this_shouldnt_exist.h')
      subject.stub(:alternate_file_for).and_return(expected_alternate)
    end

    describe '::command_A' do
      it "emits an :edit command for the alternate" do
        VIM.should_receive(:command).with("edit #{expected_alternate}")
        subject.command_A
      end
    end

    describe '::command_AV' do
      it "emits a :vsplit command for the alternate" do
        VIM.should_receive(:command).with("vsplit #{expected_alternate}")
        subject.command_AV
      end
    end

    describe '::command_AS' do
      it "emits a :split command for the alternate" do
        VIM.should_receive(:command).with("split #{expected_alternate}")
        subject.command_AS
      end
    end

    describe '::command_AT' do
      it "emits a :tabedit command for the alternate" do
        VIM.should_receive(:command).with("tabedit #{expected_alternate}")
        subject.command_AT
      end
    end

  end

  describe '::alternate_file_for foo.h' do
    it 'should return what AlternateFinder returns' do
      IOS::Vim::AlternateFinder.should_receive(:new).with('foo.h').and_return(stub :alternate => 'foo.m')
      subject.send(:alternate_file_for,'foo.h').should == 'foo.m'
    end
  end

end
