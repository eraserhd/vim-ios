require 'ios/vim/commands'
require 'ios/vim/alternate_finder'

module VIM; class Buffer; end; end

describe IOS::Vim::Commands do

  subject do
    o = Object.new
    o.extend IOS::Vim::Commands
    o
  end

  def editing(filename)
    VIM::Buffer.stub_chain(:current, :name).and_return filename
  end

  describe ':A' do
    it "emits the edit command for the alternate" do
      editing 'FooFile.m'
      IOS::Vim::AlternateFinder.should_receive(:new).with('FooFile.m').and_return(stub :alternate => 'FooFile.h')
      VIM.should_receive(:command).with("foozle FooFile.h")
      subject.edit_command_A 'foozle'
    end
  end

  describe ':Rimpl' do
    it "emits the edit command for the impl found by the related file finder" do
      editing 'FooSpec.m'
      IOS::Vim::RelatedFinder.should_receive(:new).with('FooSpec.m').and_return(stub :impl => 'Foo.m')
      VIM.should_receive(:command).with("barzle Foo.m")
      subject.edit_command_Rimpl 'barzle'
    end
  end

  describe ':Rspec' do
    it "edits the spec found by the related file finder" do
      editing 'FooClass.m'
      IOS::Vim::RelatedFinder.should_receive(:new).with('FooClass.m').and_return(stub :spec => 'FooClassSpec.m')
      VIM.should_receive(:command).with("foozle FooClassSpec.m")
      subject.edit_command_Rspec 'foozle'
    end
  end

end
