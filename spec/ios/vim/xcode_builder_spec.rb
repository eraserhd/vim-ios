require 'ios/vim'

module VIM; end

describe IOS::Vim::XcodeBuilder do
  let(:runner) {double :run => [0, ""]}
  subject {IOS::Vim::XcodeBuilder.new runner}
  before {VIM.stub(:command)}

  it {should respond_to(:build)}

  it 'tells us it is building' do
    VIM.should_receive(:command).with('echo "Building... "')
    subject.build
  end

  it 'runs xcodebuild' do
    runner.should_receive(:run).with('xcodebuild 2>&1')
    subject.build
  end

  it 'passes extra parameters to xcodebuild' do
    runner.should_receive(:run).with('xcodebuild -foo -bar -baz "hello" 2>&1')
    subject.build('-foo -bar -baz "hello"')
  end

  context 'when xcodebuild indicates success' do
    before {runner.stub(:run).and_return [0, ""]}

    it 'tells us "OK"' do
      VIM.should_receive(:command).with('echon "OK"')
      subject.build
    end
  end

  context 'when xcodebuild output includes "\\n** BUILD FAILED **"' do
    let(:xcodebuild_output) {"flobb \n** BUILD FAILED ** \n "}
    let(:tmpfile) {double :write => nil, :close => nil, :path => "/abc"}
    before do
      Tempfile.stub(:new).and_return tmpfile
      runner.stub(:run).and_return [0, xcodebuild_output]
    end

    it 'does not tell us "OK"' do
      VIM.should_not_receive(:command).with('echon "OK"')
      subject.build
    end

    it 'writes the output to a temporary file' do
      tmpfile.should_receive(:write).with(xcodebuild_output)
      subject.build
    end

    it 'closes the temporary file' do
      tmpfile.should_receive(:close)
      subject.build
    end

    it 'starts quickfix mode with the temporary file' do
      VIM.should_receive(:command).with('cfile /abc')
      subject.build
    end
  end

  it {should respond_to(:install)}

  it 'tells us it is installing' do
    VIM.should_receive(:command).with('echo "Installing... "')
    subject.install(nil, nil)
  end

  context 'when fruitstrap indicates success' do
    before {runner.stub(:run).and_return [0, ""]}

    it 'tells us "OK"' do
      VIM.should_receive(:command).with('echon "OK"')
      subject.install(nil, nil)
    end
  end

  context 'when fruitstrap output includes "AMDeviceInstallApplication failed"' do
    let(:fruitstrap_output) {"\nAMDeviceInstallApplication failed: -402620393"}

    before do
      runner.stub(:run).and_return [0, fruitstrap_output]
    end

    it 'does not tell us "OK"' do
      VIM.should_not_receive(:command).with('echon "OK"')
      subject.install(nil, nil)
    end
  end

end
