require 'ios/vim'

describe IOS::Vim::XcodeBuilder do
  it {should respond_to(:build)}

  it 'shows status message' do
    builder = IOS::Vim::XcodeBuilder.new
    builder.should_receive(:puts).with('Building... ')
    builder.build
  end

end
