require 'ios/vim'

describe 'IOS::Vim.escape_filename' do

  # IOS::Vim.escape_filename() has the same requirements as Vim's fnameescape()
  it 'passes through a filename without special characters' do
    IOS::Vim.escape_filename('hello/Foo.m').should eq('hello/Foo.m')
  end

  it 'escapes spaces' do
    IOS::Vim.escape_filename('hello world.m').should eq('hello\\ world.m')
  end

  it 'escapes other special characters' do
    special_characters = " \t\n*?[{`$\\%#'\"|!<"
    escaped_special_characters = '\\' + special_characters.split(//).join('\\')
    IOS::Vim.escape_filename(special_characters).should eq(escaped_special_characters)
  end

  it 'escapes a leading "+"' do
    IOS::Vim.escape_filename('+Hello').should eq('\\+Hello')
  end
  
  it 'escapes a leading ">"' do
    IOS::Vim.escape_filename('>Hello').should eq('\\>Hello')
  end

  it 'escapes a lone "-"' do
    IOS::Vim.escape_filename('-').should eq('\\-')
  end

end
