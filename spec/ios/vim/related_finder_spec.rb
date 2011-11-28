require 'ios/vim'

describe IOS::Vim::RelatedFinder do

  before do
    File.stub(:exists?).and_return false
  end

  context 'when finding a corresponding spec' do

    context 'when given BarSpec.m' do
      it 'returns BarSpec.m' do
        IOS::Vim::RelatedFinder.new('BarSpec.m').spec.should == 'BarSpec.m'
      end
    end

    context 'when given Foo.m' do

      it 'returns FooSpec.m' do
        IOS::Vim::RelatedFinder.new('Foo.m').spec.should == 'FooSpec.m'
      end

      context 'when FooTest.m exists' do
        before do
          File.stub(:exists?).with('FooTest.m').and_return true
        end

        it 'should return FooTest.m' do
          IOS::Vim::RelatedFinder.new('Foo.m').spec.should == 'FooTest.m'
       end
      end

      context 'when FooSpec.mm exists' do
        before do
          File.stub(:exists?).with('FooSpec.mm').and_return true
        end

        it 'should return FooSpec.mm' do
          IOS::Vim::RelatedFinder.new('Foo.m').spec.should == 'FooSpec.mm'
        end
      end

    end

  end

  context 'when finding a corresponding impl' do

    context 'when given Bar.m' do
      it 'returns Bar.m' do
        IOS::Vim::RelatedFinder.new('Bar.m').impl.should == 'Bar.m'
      end
    end

    context 'when given BarSpec.m' do
      it 'returns Bar.m' do
        IOS::Vim::RelatedFinder.new('BarSpec.m').impl.should == 'Bar.m'
      end
    end

    context 'when Bar.mm exists' do
      before do
        File.stub(:exists?).with('Bar.mm').and_return true
      end

      it 'returns Bar.mm' do
        IOS::Vim::RelatedFinder.new('BarSpec.m').impl.should == 'Bar.mm'
      end
    end

  end

  context 'when finding the next related file' do

    context 'when given Bar.m' do
      it 'returns BarSpec.m' do
        IOS::Vim::RelatedFinder.new('Bar.m').next.should == 'BarSpec.m'
      end
    end

    context 'when given BarSpec.m' do
      it 'returns Bar.m' do
        IOS::Vim::RelatedFinder.new('BarSpec.m').next.should == 'Bar.m'
      end
    end

  end

end
