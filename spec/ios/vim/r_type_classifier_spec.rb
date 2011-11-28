require 'ios/vim'

describe IOS::Vim::RTypeClassifier do

  describe '#type' do

    it "classifies '*Spec.*' files as :spec" do
      IOS::Vim::RTypeClassifier.new('FooClassSpec.cXfObbA__r').type.should == :spec
    end

    it "classifies '*Test.*' files as :spec" do
      IOS::Vim::RTypeClassifier.new('FooClassTest.llNOTq').type.should == :spec
    end

    it "classifies other files as :impl" do
      IOS::Vim::RTypeClassifier.new('FooClass.m').type.should == :impl
    end

  end

  describe '#stem' do

    it 'returns "FooClass" for "FooClass" with some weird extension' do
      IOS::Vim::RTypeClassifier.new('FooClass.sOMe_wEIrDx').stem.should == 'FooClass'
    end

    it 'returns "FooClass" for "FooClassSpec" with some weird extension' do
      IOS::Vim::RTypeClassifier.new('FooClassSpec.SSOOMMEE_whatever').stem.should == 'FooClass'
    end

    it 'returns "FooClass" for "FooClassTest" with some weird extension' do
      IOS::Vim::RTypeClassifier.new('FooClassTest.xSxOxMxE_whatever').stem.should == 'FooClass'
    end
    
  end

end
