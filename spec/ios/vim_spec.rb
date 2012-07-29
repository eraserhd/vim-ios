require 'ios/vim'

module VIM; class Buffer; end; end

describe IOS::Vim do

  before do
    VIM.stub(:command)
  end

  describe '::initialize' do
    let(:installer) {mock}

    before do
      IOS::Vim::CommandInstaller.stub(:new).with(IOS::Vim).and_return(installer)
    end

    it 'installs commands' do
      installer.should_receive(:install)
      IOS::Vim::initialize
    end
  end

end
