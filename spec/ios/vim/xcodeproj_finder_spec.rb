require 'ios/vim'

describe IOS::Vim::XcodeProjectFinder do

  context "when it can't find a project folder" do

    let!(:filesystem) do
      double :current_directory => '/Foo/bar', :list => []
    end
    subject {IOS::Vim::XcodeProjectFinder.new filesystem}

    it "returns nil" do
      subject.find.should be_nil
    end

  end

  context "when there's a .xcodeproj in the current directory" do

    let!(:filesystem) do
      filesystem = double(:current_directory => '/Foo/bar/baz')
      filesystem.stub(:list).with('/Foo/bar/baz').and_return(['Foo.xcodeproj'])
      filesystem
    end
    subject {IOS::Vim::XcodeProjectFinder.new filesystem}

    it "returns an XcodeProject with the correct path" do
      subject.find.should be_kind_of(IOS::Vim::XcodeProject)
      subject.find.path.should == "/Foo/bar/baz/Foo.xcodeproj"
    end

  end

  context "when there's a .xcodeproj in a parent directory" do
    
    let!(:filesystem) do
      filesystem = double(:current_directory => '/Foo/bar/baz')
      filesystem.stub(:list).with('/Foo/bar/baz').and_return([])
      filesystem.stub(:list).with('/Foo/bar').and_return(['Foo.xcodeproj'])
      filesystem
    end
    subject {IOS::Vim::XcodeProjectFinder.new filesystem}

    it "returns an XcodeProject with the correct path" do
      subject.find.should be_kind_of(IOS::Vim::XcodeProject)
      subject.find.path.should == "/Foo/bar/Foo.xcodeproj"
    end

  end
  
end
