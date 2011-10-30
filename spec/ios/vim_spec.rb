require 'ios/vim'

describe IOS::Vim do

  describe '::interface' do
    it 'should return an interface to vim' do
      IOS::Vim::interface.should be_kind_of(IOS::Vim::Interface)
    end
  end

end
