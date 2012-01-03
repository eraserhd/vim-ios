require 'ios/vim'

describe 'IOS::Vim.xcodeproj_interface' do

  context 'when retreiving an instance' do
    context 'when loading zerg_xcode fails' do
      before do
        IOS::Vim.stub(:gem).and_raise(LoadError)
      end

      it 'raises a LoadError with a descriptive message' do
        expect {IOS::Vim.xcodeproj_interface}.to raise_error(
          LoadError,
          'This feature requires the zerg_xcode gem.'
        )
      end
    end

    context 'when loading zerg_xcode succeeds' do
      before do
        IOS::Vim.stub(:gem).and_return(true)
      end
      subject {IOS::Vim.xcodeproj_interface}
      it {should be_kind_of(IOS::Vim::XcodeprojInterface)}
    end
  end

end

