require 'ios/vim'

describe IOS::Vim::AlternateFinder do

  before do 
    File.stub(:exists?).and_return true
  end
  describe 'switching from a source file' do
    subject do
      IOS::Vim::AlternateFinder.new('foo/bar.m')
    end

    context "when a .h exists" do
      it "should find a .h for various source file types" do
        subject.alternate.should == 'foo/bar.h'
      end
    end

    context "when a .h doesn't exist" do
      it 'should find a .hh' do
        File.stub(:exists?).with('foo/bar.h').and_return(false)
        subject.alternate.should == 'foo/bar.hh'
      end
    end
  end

  describe 'switching from a header file' do
    subject do
      IOS::Vim::AlternateFinder.new('foo/bar.h')
    end

    context 'when the primary counterpart exists' do
      it "should be the primary counterpart" do
        subject.alternate.should == 'foo/bar.m'
      end
    end

    context "when the primary counterpart doesn't exist" do
      it 'should be the secondary counterpart' do
        File.stub(:exists?).with('foo/bar.m').and_return false
        subject.alternate.should == 'foo/bar.mm'
      end
    end
    context "when the secondary counterpart doesn't exist" do
      it 'finds the tertiary counterpart' do
        File.stub(:exists?).with('foo/bar.m').and_return false
        File.stub(:exists?).with('foo/bar.mm').and_return false
        subject.alternate.should == 'foo/bar.cpp'
      end
    end
    context "when no counterparts exist" do
      it "should be the primary counterpart" do
        File.stub(:exists?).and_return false
        subject.alternate.should == 'foo/bar.m'
      end
    end
  end

end
