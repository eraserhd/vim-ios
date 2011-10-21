require 'ios/vim/alternate_finder'

describe IOS::Vim::AlternateFinder do

  subject { IOS::Vim::AlternateFinder.new }

  it "should find a .h from a .m file" do
    subject.alternate_for('foo/bar.m').should == 'foo/bar.h'
  end

end
