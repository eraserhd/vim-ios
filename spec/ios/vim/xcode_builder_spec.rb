require 'ios/vim'

module VIM; end

describe IOS::Vim::XcodeBuilder do
  it {should respond_to(:build)}

  it 'tells us it is building' do
    VIM.stub(:command)
    VIM.should_receive(:command).with('echo "Building... "')
    subject.build
  end

  it 'tells us when it is done building' do
    VIM.stub(:command)
    VIM.should_receive(:command).with('echon "OK"')
    subject.build
  end

end
