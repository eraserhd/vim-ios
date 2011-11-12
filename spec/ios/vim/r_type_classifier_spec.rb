require 'ios/vim'

describe IOS::Vim::RTypeClassifier do

  it "should classify '*Spec.m' files as :spec" do
    IOS::Vim::RTypeClassifier.new('FooClassSpec.m').type.should == :spec
  end

  it "should classify '*Test.m' files as :spec" do
    IOS::Vim::RTypeClassifier.new('FooClassTest.m').type.should == :spec
  end

  it "should classify '*Test.h' files as :spec" do
    IOS::Vim::RTypeClassifier.new('FooClassTest.h').type.should == :spec
  end

  it "should classify other '*.m' files as :code" do
    IOS::Vim::RTypeClassifier.new('FooClass.m').type.should == :code
  end

end
