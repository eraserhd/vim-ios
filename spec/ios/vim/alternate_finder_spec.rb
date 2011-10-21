require 'ios/vim/alternate_finder'

describe IOS::Vim::AlternateFinder do

  it "should find a .h for various source file types" do
    ['m', 'mm', 'cpp'].each do |ext|
      IOS::Vim::AlternateFinder.new("foo/bar.#{ext}").alternate.should == 'foo/bar.h'
    end
  end

  it "should find a .m as an alternate for a .h if it exists" do
    IOS::Vim::AlternateFinder.new('foo/bar.h').alternate.should == 'foo/bar.m'
  end

end
