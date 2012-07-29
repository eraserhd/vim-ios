require 'ios/vim'

describe IOS::Vim::LibclangFinder do

  let(:command_runner) {double}
  subject {IOS::Vim::LibclangFinder.new command_runner}

  context 'when xcrun has zero exit code' do
    before do
      command_runner.stub(:run).and_return [0, "/foo/bar/bin/clang"]
    end

    it 'returns a path based on the printed result' do
      subject.find.should == "/foo/bar/lib/libclang.dylib"
    end
  end

  context 'when xcrun has a non-zero exit code' do
    before do
      command_runner.stub(:run).and_return [42, "???"]
    end

    it 'raises IOError' do
      lambda {subject.find}.should raise_error
    end
  end

end
