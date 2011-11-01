
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

Navigation
----------

Navigation from header to implementation files and back is done through the `:A`
command and its variants.  `:A` replaces the current file with its alternate,
while `:AS` opens the alternate in a split, `:AV` opens the alternate in a
vertical split, and `:AT` opens the alternate in a new tab.

Shameless Self-Promotion
------------------------

I am writing this to help Vimmers in the Apple world, since it is quite
convenient for a platform provider like Apple to stick everyone into one little
box (oh, just use Xcode, it is what we provide) and perhaps forget that we've
been developing some pretty good tools and idioms for building software since
around 1973.

If you like this philosophy, I would like to help you.  I produce weekly
screencasts and charge the small sum of $9 US per month for them.  I also make
free screencasts and the usual text-style blog posts (also free) from time
to time.  You can find these at [The Objective Vimmer](http://objvimmer.com/).

