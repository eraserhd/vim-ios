require 'ios/vim/commands'
require 'ios/vim/alternate_finder'

module VIM; class Buffer; end; end

describe IOS::Vim::Commands do

  subject do
    o = Object.new
    o.extend IOS::Vim::Commands
    o
  end

  def when_editing(filename)
    @filename = filename
    VIM::Buffer.stub_chain(:current, :name).and_return @filename
  end

  def finder(kind, stub_params)
    kind.should_receive(:new).with(@filename).and_return(stub stub_params)
  end

  describe ':A' do
    it "emits the edit command for the alternate" do
      when_editing 'FooFile.m'
      finder IOS::Vim::AlternateFinder, :alternate => 'FooFile.h'
      VIM.should_receive(:command).with("foozle FooFile.h")
      subject.edit_command_A 'foozle'
    end
  end

  describe ':Rimpl' do
    it "emits the edit command for the impl found by the related file finder" do
      when_editing 'FooSpec.m'
      finder IOS::Vim::RelatedFinder, :impl => 'Foo.m'
      VIM.should_receive(:command).with("barzle Foo.m")
      subject.edit_command_Rimpl 'barzle'
    end
  end

  describe ':Rspec' do
    it "edits the spec found by the related file finder" do
      when_editing 'FooClass.m'
      finder IOS::Vim::RelatedFinder, :spec => 'FooClassSpec.m'
      VIM.should_receive(:command).with("foozle FooClassSpec.m")
      subject.edit_command_Rspec 'foozle'
    end
  end

end
