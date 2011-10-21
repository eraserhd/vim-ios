require 'ios/vim/file_classifier'

describe IOS::Vim::FileClassifier do

  describe '#type' do
    it "should be able to determine .h files are header files" do
      IOS::Vim::FileClassifier.new('foo/bar.h').type.should == :header
    end

    it "should be able to determine .m files are source files" do
      IOS::Vim::FileClassifier.new('foo/bar.m').type.should == :source
    end

    it "should reply that .NoSuChFiLeTyPe files are unknown" do
      IOS::Vim::FileClassifier.new('foo/bar.NoSuChFiLeTyPe').type.should == :unknown
    end
  end

  describe '#stem' do
    it "should give access to the file stem" do
      IOS::Vim::FileClassifier.new('foo/bar.m').stem.should == 'foo/bar'
    end
  end

end
