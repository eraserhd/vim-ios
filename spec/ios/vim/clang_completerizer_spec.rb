require 'ios/vim'

describe IOS::Vim::ClangCompleterizer do

  let(:libclang_finder) {mock}
  subject {IOS::Vim::ClangCompleterizer.new libclang_finder}

  context 'when libclang is not found' do
    before do
      libclang_finder.stub(:find).and_raise IOError.new
    end

    it 'does not set g:clang_library_path' do
      VIM.should_not_receive(:command)
      subject.configure_environment
    end
  end

  context 'when libclang is found' do
    before do
      libclang_finder.stub(:find).and_return '/foo/bar/libclang.dylib'
    end

    it 'sets g:clang_library_path' do
      VIM.should_receive(:command).with('let g:clang_library_path = "/foo/bar"')
      subject.configure_environment
    end
  end

end
