require 'ios/vim'

module VIM; class Buffer; end; end

describe IOS::Vim::Commands do

  subject do
    o = Object.new
    o.extend IOS::Vim::Commands
    o
  end

  def command(command)
    @command = command
    self
  end

  def when_editing(filename)
    @filename = filename
    VIM::Buffer.stub_chain(:current, :name).and_return @filename
    self
  end

  def with_finder(kind, stub_params)
    kind.should_receive(:new).with(@filename).and_return(stub stub_params)
    @found_file = stub_params.values.first
    self
  end

  def should_edit_found_file
    VIM.should_receive(:command).with("foozle #{@found_file}")
    subject.send("edit_command_#{@command}", 'foozle')
  end

  describe ':A' do
    it "emits the edit command for the alternate" do
      command(:A).when_editing('FooFile.m').with_finder(IOS::Vim::AlternateFinder, :alternate => 'FooFile.h').should_edit_found_file
    end
  end

  describe ':Rimpl' do
    it "emits the edit command for the impl found by the related file with_finder" do
      command(:Rimpl).when_editing('FooSpec.m').with_finder(IOS::Vim::RelatedFinder, :impl => 'Foo.m').should_edit_found_file
    end
  end

  describe ':Rspec' do
    it "edits the spec found by the related file with_finder" do
      command(:Rspec).when_editing('FooClass.m').with_finder(IOS::Vim::RelatedFinder, :spec => 'FooClassSpec.m').should_edit_found_file
    end
  end

  describe ':R' do
    it "edits the next related file (according to related finder)" do
      command(:R).when_editing('Foo.m').with_finder(IOS::Vim::RelatedFinder, :next => 'FooSpec.m').should_edit_found_file
    end
  end

  describe ':Xadd' do
    context 'when adding the current file' do
      it 'uses the given path'
      it 'uses the given targets'
    end
  end

end
