require 'ios/vim'

describe IOS::Vim::XcodeprojInterface do

  context 'when retrieving an interface instance' do
    context 'when loading zerg_xcode fails' do
      before do
        IOS::Vim::XcodeprojInterface.stub(:gem).and_raise(LoadError)
      end

      it 'raises a LoadError with a descriptive message' do
        expect {IOS::Vim::XcodeprojInterface.instance}.to raise_error(
          LoadError,
          'This feature requires the zerg_xcode gem.'
        )
      end
    end

    context 'when loading zerg_xcode succeeds' do
      before do
        IOS::Vim::XcodeprojInterface.stub(:gem).and_return(true)
      end
      subject {IOS::Vim::XcodeprojInterface.instance}
      it {should be_kind_of(IOS::Vim::XcodeprojInterface)}
    end
  end

end
