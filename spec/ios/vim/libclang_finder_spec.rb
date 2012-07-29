require 'ios/vim'

describe IOS::Vim::LibclangFinder do

  let(:command_runner) {double}
  subject {IOS::Vim::LibclangFinder.new command_runner}

  context 'when xcrun has zero exit code' do
    it 'returns a path based on the printed result' do
      command_runner.stub(:run).and_return [0, "/foo/bar/lib/libclang.dylib"]
      subject.find.should == "/foo/bar/lib/libclang.dylib"
    end
  end

end
