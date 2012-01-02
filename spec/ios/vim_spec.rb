require 'ios/vim'

module VIM; class Buffer; end; end

describe IOS::Vim do

  before do
    VIM.stub(:command)
  end

  describe '::initialize' do
    it 'should install commands' do
      installer = mock
      installer.should_receive(:install_commands)
      IOS::Vim::CommandInstaller.should_receive(:new).with(IOS::Vim).and_return(installer)
      IOS::Vim::initialize
    end
  end

end
