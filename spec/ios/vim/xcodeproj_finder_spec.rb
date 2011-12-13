require 'ios/vim'

describe IOS::Vim::XcodeprojFinder do

  context "when it can't find a project folder" do

    let!(:filesystem) {stub}
    subject {IOS::Vim::XcodeprojFinder.new filesystem}

    it "returns nil" do
      subject.find.should be_nil
    end

  end
  

end
