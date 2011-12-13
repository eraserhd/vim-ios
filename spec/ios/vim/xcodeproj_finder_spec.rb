require 'ios/vim'

describe IOS::Vim::XcodeprojFinder do

  context "when it can't find a project folder" do

    let!(:filesystem) {double :list => []}
    subject {IOS::Vim::XcodeprojFinder.new filesystem}

    it "returns nil" do
      subject.find.should be_nil
    end

  end

  context "when there's a .xcodeproj in the current directory" do

    let!(:filesystem) do
      filesystem = double
      filesystem.stub(:list).with('.').and_return(['Foo.xcodeproj'])
      filesystem
    end
    subject {IOS::Vim::XcodeprojFinder.new filesystem}

    it "returns an XcodeProject with the correct path" do
      subject.find.should be_kind_of(IOS::Vim::XcodeProject)
      subject.find.path.should == "Foo.xcodeproj"
    end

  end
  

end
