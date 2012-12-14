require 'ios/vim'

describe 'IOS::Vim.escape_filename' do

  it 'passes through a filename without special characters' do
    IOS::Vim.escape_filename('hello/Foo.m').should eq('hello/Foo.m')
  end

end
