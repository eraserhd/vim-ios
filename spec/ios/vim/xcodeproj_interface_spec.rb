require 'ios/vim'

describe 'IOS::Vim.xcodeproj_interface' do

  context 'when retreiving an instance' do
    subject {IOS::Vim.xcodeproj_interface}

    context 'when loading zerg_xcode fails' do
      before do
        IOS::Vim.stub(:gem).and_raise(LoadError)
      end

      it {should be_kind_of(IOS::Vim::NoXcodeprojInterface)}
    end

    context 'when loading zerg_xcode succeeds' do
      before do
        IOS::Vim.stub(:gem).and_return(true)
      end

      it {should be_kind_of(IOS::Vim::RealXcodeprojInterface)}
    end

  end

end

describe IOS::Vim::NoXcodeprojInterface do

  context 'when any method is called' do
    it 'raises LoadError with a message' do
      expect {subject.bazzlequux}.to raise_error(
        LoadError,
        'This feature requires the zerg_xcode gem.'
      )
    end
  end

end
