require 'ios/vim'

describe IOS::Vim::RelatedFinder do

  before do
    File.stub(:exists?).and_return false
  end

  describe '#spec' do

    it 'returns the current file if it is a spec' do
      IOS::Vim::RelatedFinder.new('foo/BarSpec.m').spec.should == 'foo/BarSpec.m'
    end

    it 'returns FooSpec.m if given Foo.m' do
      IOS::Vim::RelatedFinder.new('Foo.m').spec.should == 'FooSpec.m'
    end

  end

end
