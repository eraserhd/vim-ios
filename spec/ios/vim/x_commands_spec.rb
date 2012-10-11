require 'ios/vim'

module VIM; class Buffer; end; end

describe IOS::Vim::XCommands do

  before do
    VIM::Buffer.stub_chain(:current, :name).and_return 'dir/quux.cpp'
  end

  subject do
    commands = Object.new
    commands.instance_eval {class <<self; include IOS::Vim::XCommands; end}
    commands
  end

  context 'when an Xcode interface is available' do
    let(:iface) do
      iface = mock
      IOS::Vim::XcodeprojInterface.stub(:instance).and_return iface
      iface
    end

    describe ':Xadd' do
      it 'adds the current buffer to the project' do
        iface.should_receive(:add_file).with('dir/quux.cpp', 'Foo/Bar', ['TargetA','TargetB'])
        subject.command_Xadd 'Foo/Bar', 'TargetA,TargetB'
      end
    end

    describe ':Xbuild' do
      it 'invokes the Xcode builder' do
        builder = double
        IOS::Vim::XcodeBuilder.should_receive(:new).and_return builder
        builder.should_receive :build
        subject.command_Xbuild
      end
    end
  end

  context 'when retrieving an Xcode interface fails' do
    before do
      IOS::Vim::XcodeprojInterface.stub(:instance).and_raise(LoadError.new('Flarp!'))
    end

    describe ':Xadd' do
      it 'prints the error message' do
        subject.should_receive(:print).with('Flarp!')
        subject.command_Xadd 'Foo/Bar', 'TargetA,TargetB'
      end
    end
  end

end
