require 'ios/vim'

describe IOS::Vim::ATypeClassifier do

  describe '#type' do
    it "should be able to determine .h files are header files" do
      IOS::Vim::ATypeClassifier.new('foo/bar.h').type.should == :header
    end

    it "should be able to determine .m files are source files" do
      IOS::Vim::ATypeClassifier.new('foo/bar.m').type.should == :source
    end

    it "should reply that .NoSuChFiLeTyPe files are unknown" do
      IOS::Vim::ATypeClassifier.new('foo/bar.NoSuChFiLeTyPe').type.should == :unknown
    end
  end

  describe '#stem' do
    it "should give access to the file stem" do
      IOS::Vim::ATypeClassifier.new('foo/bar.m').stem.should == 'foo/bar'
    end
  end

  describe '#header?' do
    it "should return true for headers" do
      IOS::Vim::ATypeClassifier.new('foo/bar.h').header?.should be_true
    end
    it "should return false for sources" do
      IOS::Vim::ATypeClassifier.new('foo/bar.m').header?.should be_false
    end
  end

  describe '#source?' do
    it "should return true for sources" do
      IOS::Vim::ATypeClassifier.new('foo/bar.m').source?.should be_true
    end
    it "should return false for headers" do
      IOS::Vim::ATypeClassifier.new('foo/bar.h').source?.should be_false
    end
  end

end
