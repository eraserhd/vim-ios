
About
-----

`ios.vim` is a plugin for Vim for iOS development.  It is inspired mostly by
[rails.vim].

Installation
------------

`ios.vim` requires a Vim with ruby scripting support built in.  You can get
one using either the [Homebrew] or [MacPorts] package managers.  For MacPorts,
use:

    ports install vim +ruby

For Homebrew:

    brew install macvim +ruby

Once you have a good Vim installed, we move merrily along to installing ios.vim
itself.  If you have no preference, I recommend using [pathogen.vim].  Once
pathogen is installed and configured, you can clone this repository into
~/.vim/bundle like so:

    mkdir -p ~/.vim/bundle
    cd ~/.vim/bundle
    git clone https://github.com/eraserhd/vim-ios.git

After which, everything should Just Work(tm).

[pathogen.vim]: https://github.com/tpope/vim-pathogen/ 
[rails.vim]: https://github.com/tpope/vim-rails/
[Homebrew]: http://mxcl.github.com/homebrew/
[MacPorts]: http://www.macports.org/ 
