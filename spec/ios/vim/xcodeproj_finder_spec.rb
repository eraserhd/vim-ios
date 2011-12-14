require 'ios/vim'

RSpec::Matchers.define :find_project_with_path do |expected|
  match do |actual|
    actual.find.path.should == expected
  end
end

describe IOS::Vim::XcodeProjectFinder do

  def lister_with dirs
    lister = double :current_directory => '/Foo/bar/baz', :list => []
    dirs.each do |dir, contents|
      lister.stub(:list).with(dir).and_return(contents)
    end
    lister
  end

  context "when it can't find a project folder" do
    subject do
      IOS::Vim::XcodeProjectFinder.new lister_with({})
    end

    it "returns nil" do
      subject.find.should be_nil
    end
  end

  context "when there's a .xcodeproj in the current directory" do

    subject do
      IOS::Vim::XcodeProjectFinder.new lister_with('/Foo/bar/baz' => ['Foo.xcodeproj'])
    end

    it "returns an XcodeProject with the correct path" do
      subject.should find_project_with_path("/Foo/bar/baz/Foo.xcodeproj")
    end

  end

  context "when there's a .xcodeproj in a parent directory" do
    
    subject do
      IOS::Vim::XcodeProjectFinder.new lister_with('/Foo/bar' => ['Foo.xcodeproj'])
    end

    it "returns an XcodeProject with the correct path" do
      subject.should find_project_with_path("/Foo/bar/Foo.xcodeproj")
    end

  end
  
end
