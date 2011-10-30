require 'ios/vim'

module VIM
  class Buffer; end
end

describe IOS::Vim do

  describe '::alternate' do
    it 'should emit an :edit command' do
      VIM::Buffer.stub_chain(:current, :name).and_return('foo.m')
      IOS::Vim.stub(:alternate_finder_for).and_return('foo.h')
      VIM.should_receive(:command).with('edit foo.h')
      IOS::Vim::alternate
    end
  end

end
