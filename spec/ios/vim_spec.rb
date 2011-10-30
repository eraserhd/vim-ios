require 'ios/vim'

describe IOS::Vim do

  describe '::interface' do
    it 'should return an interface to vim' do
      IOS::Vim::interface.should be_kind_of(IOS::Vim::Interface)
    end
  end

  describe '::alternate' do
    it 'should emit an :edit command' do
      iface = mock
      iface.stub(:current_buffer_name).and_return('foo.m')
      iface.should_receive(:command) do |cmd|
        cmd.should match(/^edit /)
      end
      IOS::Vim.stub(:interface).and_return(iface)
      IOS::Vim::alternate
    end
  end

end
