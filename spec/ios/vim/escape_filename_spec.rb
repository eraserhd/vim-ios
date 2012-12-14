require 'ios/vim'

describe 'IOS::Vim.escape_filename' do

  it 'passes through a filename without special characters' do
    IOS::Vim.escape_filename('hello/Foo.m').should eq('hello/Foo.m')
  end

  it 'escapes spaces' do
    IOS::Vim.escape_filename('hello world.m').should eq('hello\\ world.m')
  end

end
