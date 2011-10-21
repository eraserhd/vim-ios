require 'ios/vim/alternate_finder'

describe IOS::Vim::AlternateFinder do
  include IOS::Vim

  it "should find a .h for various source file types" do
    ['m', 'mm', 'cpp'].each do |ext|
      IOS::Vim::AlternateFinder.new("foo/bar.#{ext}").alternate.should == 'foo/bar.h'
    end
  end

end
