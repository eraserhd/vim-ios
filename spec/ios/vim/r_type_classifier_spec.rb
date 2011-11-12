require 'ios/vim'

describe IOS::Vim::RTypeClassifier do

  describe '#type' do

    it "classifies '*Spec.*' files as :spec" do
      IOS::Vim::RTypeClassifier.new('FooClassSpec.cXfObbA__r').type.should == :spec
    end

    it "classifies '*Test.*' files as :spec" do
      IOS::Vim::RTypeClassifier.new('FooClassTest.llNOTq').type.should == :spec
    end

    it "classifies other files as :code" do
      IOS::Vim::RTypeClassifier.new('FooClass.m').type.should == :code
    end

  end

end
