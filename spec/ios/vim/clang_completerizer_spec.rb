require 'ios/vim'

describe IOS::Vim::ClangCompleterizer do

  let(:libclang_finder) {mock}
  subject {IOS::Vim::ClangCompleterizer.new libclang_finder}

  context 'when libclang.dylib is not found' do
    before do
      libclang_finder.stub(:find).and_raise IOError.new
    end

    it 'does not set g:clang_library_path' do
      VIM.should_not_receive(:command)
      subject.configure_environment
    end
  end

end
