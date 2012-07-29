require 'ios/vim'

module VIM; class Buffer; end; end

describe IOS::Vim do

  before do
    VIM.stub(:command)
  end

  describe '::initialize' do
    let(:installer) {mock :install => nil}
    let(:clang_completerizer) {mock :configure_environment => nil}

    before do
      IOS::Vim::CommandInstaller.stub(:new).with(IOS::Vim).and_return(installer)
      IOS::Vim::ClangCompleterizer.stub(:new).with().and_return(clang_completerizer)
    end

    it 'installs commands' do
      installer.should_receive(:install)
      IOS::Vim::initialize
    end

    it 'configures the environment for clang_complete' do
      clang_completerizer.should_receive(:configure_environment)
      IOS::Vim::initialize
    end
  end

end
