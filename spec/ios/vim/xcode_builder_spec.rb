require 'ios/vim'

module VIM; end

describe IOS::Vim::XcodeBuilder do
  let(:shell_command_runner) {double :run => ""}
  subject {IOS::Vim::XcodeBuilder.new shell_command_runner}

  before(:each) do
    VIM.stub(:command)
  end

  it {should respond_to(:build)}

  it 'tells us it is building' do
    VIM.should_receive(:command).with('echo "Building... "')
    subject.build
  end

  it 'runs xcodebuild' do
    shell_command_runner.should_receive(:run).with('xcodebuild')
    subject.build
  end

  it 'tells us when it is done building' do
    VIM.should_receive(:command).with('echon "OK"')
    subject.build
  end

end
