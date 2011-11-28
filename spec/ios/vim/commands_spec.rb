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
    @file_to_edit = stub_params.values.first
  end

  def should_edit_found_file
    VIM.should_receive(:command).with("foozle #{@file_to_edit}")
  end

  describe ':A' do
    it "emits the edit command for the alternate" do
      when_editing 'FooFile.m'
      finder IOS::Vim::AlternateFinder, :alternate => 'FooFile.h'
      should_edit_found_file
      subject.edit_command_A 'foozle'
    end
  end

  describe ':Rimpl' do
    it "emits the edit command for the impl found by the related file finder" do
      when_editing 'FooSpec.m'
      finder IOS::Vim::RelatedFinder, :impl => 'Foo.m'
      should_edit_found_file
      subject.edit_command_Rimpl 'foozle'
    end
  end

  describe ':Rspec' do
    it "edits the spec found by the related file finder" do
      when_editing 'FooClass.m'
      finder IOS::Vim::RelatedFinder, :spec => 'FooClassSpec.m'
      should_edit_found_file
      subject.edit_command_Rspec 'foozle'
    end
  end

end
