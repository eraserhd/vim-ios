require 'ios/vim/alternate_finder'
require 'ios/vim/file_classifier'

describe IOS::Vim::AlternateFinder do

  let!(:source_file_classifier) { IOS::Vim::FileClassifier.new('foo/bar.m') }
  it "should find a .h for various source file types" do
    IOS::Vim::AlternateFinder.new(source_file_classifier).alternate.should == 'foo/bar.h'
  end

  let!(:header_file_classifier) { IOS::Vim::FileClassifier.new('foo/bar.h') }
  it "should find a .m as an alternate for a .h if it exists" do
    IOS::Vim::AlternateFinder.new(header_file_classifier).alternate.should == 'foo/bar.m'
  end

end
