require 'ios/vim'

module VIM; end

describe IOS::Vim::XcodeBuilder do
  it {should respond_to(:build)}

  it 'tells us it is building' do
    builder = IOS::Vim::XcodeBuilder.new
    VIM.stub(:command)
    VIM.should_receive(:command).with('echo "Building... "')
    builder.build
  end

  it 'tells us when it is done building' do
    builder = IOS::Vim::XcodeBuilder.new
    VIM.stub(:command)
    VIM.should_receive(:command).with('echon "OK"')
    builder.build
  end

end
