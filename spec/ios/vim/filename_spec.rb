require 'ios/vim/filename'

describe IOS::Vim::Filename do

  it "should be able to extract the extension" do
    IOS::Vim::Filename.new('foo/bar.h').extension.should == 'h'
  end

end
