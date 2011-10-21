require 'ios/vim'

describe IOS::Vim::Filename do

  it "should be able to extract the extension" do
    IOS::Vim::Filename.new('foo/bar.h').extension.should == 'h'
  end

  it "should be able to extract the stem" do
    IOS::Vim::Filename.new('foo/bar.h').stem.should == 'foo/bar'
  end

end
