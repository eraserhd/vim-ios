require 'ios/vim'

module VIM
  class Buffer; end
end

describe IOS::Vim do

  describe '::alternate for some_file.h' do
    it "emits an ':edit some_file.mm' command" do
      VIM::Buffer.stub_chain(:current, :name).and_return('this_shouldnt_exist.h')
      IOS::Vim.stub(:alternate_file_for).and_return('this_shouldnt_exist.mm')
      VIM.should_receive(:command).with('edit this_shouldnt_exist.mm')
      IOS::Vim::alternate
    end
  end

  describe '::alternate_file_for foo.h' do
    before do
      IOS::Vim::AlternateFinder.should_receive(:new).with('foo.h').and_return(stub :alternate => 'foo.m')
    end

    subject { IOS::Vim.alternate_file_for('foo.h') }
    
    it { should == 'foo.m' }
  end

end
