require 'ios/vim/commands'
require 'ios/vim/alternate_finder'

module VIM; class Buffer; end; end

describe IOS::Vim::Commands do

  subject do
    o = Object.new
    o.extend IOS::Vim::Commands
    o
  end

  context 'when current buffer name is "ThisShouldExist.h"' do

    let(:expected_alternate) {'ThisShouldExist.mm'}

    before do
      VIM::Buffer.stub_chain(:current, :name).and_return('ThisShouldExist.h')
      subject.stub(:alternate_file_for).and_return(expected_alternate)
    end

    describe '::edit_command_A' do
      it "emits the edit command for the alternate" do
        VIM.should_receive(:command).with("foozle #{expected_alternate}")
        subject.edit_command_A 'foozle'
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
