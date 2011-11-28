require 'ios/vim/commands'
require 'ios/vim/alternate_finder'

module VIM; class Buffer; end; end

describe IOS::Vim::Commands do

  subject do
    o = Object.new
    o.extend IOS::Vim::Commands
    o
  end

  context 'when current buffer name is "ThisShouldNotExist.h"' do

    let(:original_file) {'ThisShouldNotExist.h'}
    let(:expected_alternate) {'ThisShouldNotExist.mm'}

    before do
      VIM::Buffer.stub_chain(:current, :name).and_return original_file
    end

    describe ':A' do
      it "emits the edit command for the alternate" do
        VIM.should_receive(:command).with("foozle #{expected_alternate}")
        IOS::Vim::AlternateFinder.should_receive(:new).with(original_file).and_return(stub :alternate => expected_alternate)
        subject.edit_command_A 'foozle'
      end
    end

    describe ':Rimpl' do
      it "emits the edit command for the same file" do
        VIM.should_receive(:command).with("barzle #{original_file}")
        subject.edit_command_Rimpl 'barzle'
      end
    end

  end

  describe ':Rspec' do
    it "edits the spec found by the related file finder" do
      VIM::Buffer.stub_chain(:current, :name).and_return('FooClass.m')
      IOS::Vim::RelatedFinder.should_receive(:new).with('FooClass.m').and_return(stub :spec => 'FooClassSpec.m')
      VIM.should_receive(:command).with("foozle FooClassSpec.m")
      subject.edit_command_Rspec 'foozle'
    end
  end

end
