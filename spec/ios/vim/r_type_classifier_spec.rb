require 'ios/vim'

describe IOS::Vim::RTypeClassifier do

  it "should classify '*Spec.m' files as :spec" do
    IOS::Vim::RTypeClassifier.new('FooClassSpec.m').type.should == :spec
  end

end
