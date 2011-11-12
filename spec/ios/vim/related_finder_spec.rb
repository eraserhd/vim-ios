require 'ios/vim'

describe IOS::Vim::RelatedFinder do

  describe '#spec' do

    it 'returns the current file if it is a spec' do
      IOS::Vim::RelatedFinder.new('foo/BarSpec.m').spec.should == 'foo/BarSpec.m'
    end

  end

end
