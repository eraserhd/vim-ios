require 'ios/vim'

describe IOS::Vim::RTypeClassifier do

  it "should classify '*Spec.*' files as :spec" do
    IOS::Vim::RTypeClassifier.new('FooClassSpec.cXfObbA__r').type.should == :spec
  end

  it "should classify '*Test.*' files as :spec" do
    IOS::Vim::RTypeClassifier.new('FooClassTest.llNOTq').type.should == :spec
  end

  it "should classify other files as :code" do
    IOS::Vim::RTypeClassifier.new('FooClass.m').type.should == :code
  end

end
