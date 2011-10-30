require 'ios/vim'

module VIM
  class Buffer; end
end

describe IOS::Vim do

  describe '::alternate' do
    it 'should emit an :edit command' do
      VIM::Buffer.stub_chain(:current, :name).and_return('this_shouldnt_exist.h')
      IOS::Vim.stub(:alternate_file_for).and_return('this_shouldnt_exist.mm')
      VIM.should_receive(:command).with('edit this_shouldnt_exist.mm')
      IOS::Vim::alternate
    end
  end

end
