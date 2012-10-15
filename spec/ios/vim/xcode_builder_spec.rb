require 'ios/vim'

module VIM; end

describe IOS::Vim::XcodeBuilder do
  before(:each) do
    VIM.stub(:command)
  end

  it {should respond_to(:build)}

  it 'tells us it is building' do
    VIM.should_receive(:command).with('echo "Building... "')
    subject.build
  end

  it 'tells us when it is done building' do
    VIM.should_receive(:command).with('echon "OK"')
    subject.build
  end

end
