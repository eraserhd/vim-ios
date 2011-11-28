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
      subject.stub(:alternate_file_for).and_return expected_alternate
    end

    describe '::edit_command_A' do
      it "emits the edit command for the alternate" do
        VIM.should_receive(:command).with("foozle #{expected_alternate}")
        subject.edit_command_A 'foozle'
      end
    end

    describe '::edit_command_Rimpl' do
      it "emits the edit command for the same file" do
        VIM.should_receive(:command).with("barzle #{original_file}")
        subject.edit_command_Rimpl 'barzle'
      end
    end

  end

  context 'when current buffer name is "SomeSpec.mm"' do

    before do
      VIM::Buffer.stub_chain(:current, :name).and_return('SomeSpec.mm')
    end

    describe '::edit_command_Rspec' do
      it "emits the edit command for the same file" do
        VIM.should_receive(:command).with("foozle SomeSpec.mm")
        subject.edit_command_Rspec 'foozle'
      end
    end

  end

  describe '::alternate_file_for foo.h' do
    it 'should return what AlternateFinder returns' do
      IOS::Vim::AlternateFinder.should_receive(:new).with('foo.h').and_return(stub :alternate => 'foo.m')
      subject.send(:alternate_file_for,'foo.h').should == 'foo.m'
    end
  end

  describe '::spec_for' do
    it 'should use RelatedFinder to find the related spec' do
      IOS::Vim::RelatedFinder.should_receive(:new).with('FooClass.m').and_return(stub :spec => 'FooClassSpec.m')
      subject.send(:spec_for, 'FooClass.m').should == 'FooClassSpec.m'
    end
  end

end
