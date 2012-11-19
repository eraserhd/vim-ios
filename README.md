
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

    brew install macvim --override-system-vim

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

Building Your Project
---------------------

The `:Xbuild` command will build the Xcode project in Vim's working directory.
If the build is successful, you will see 'OK' in the status line.  Otherwise,
the command will put you into quickfix mode so you can fix compilation errors.

Similar to [clang_complete](https://github.com/Rip-Rip/clang_complete), a
configuration file named `.build` must be in your project's root directory to
be properly built. A build file simply contains switches that are sent to
`xcodebuild` when building a project. For example, a `.build` file may look
like this:

```
-sdk iphoneos6.0
-configuration Debug
```

Installing Your Application
------------------------

The `:Xinstall` command will install a built application. Please note that
`fruitstrap` is a dependency that must be in your PATH for installing to work.
A specific fork of `fruitstrap` is required. Others may work, but only the one
located [here](https://github.com/dylancopeland/fruitstrap) has been tested.
Currently, installing to the simulator is __not__ supported however adding
support is in the pipeline.

Navigation
----------

<table>
<tr>
  <th>replace file</th>
  <th>in new split</th>
  <th>in new vertical split</th>
  <th>in new tab</th>
  <th>Description</th>
</tr>
<tr>
  <td>:A, :AE</td>
  <td>:AS</td>
  <td>:AV</td>
  <td>:AT</td>
  <td>
    Open alternate file. This will open the corresponding
    header or implementation file for the current buffer.
  </td>
</tr>
<tr>
  <td>:Rspec, :REspec</td>
  <td>:RSspec</td>
  <td>:RVspec</td>
  <td>:RTspec</td>
  <td>Open corresponding test suite or spec.</td>
</tr>
<tr>
  <td>:Rimpl, :REimpl</td>
  <td>:RSimpl</td>
  <td>:RVimpl</td>
  <td>:RTimpl</td>
  <td>Open corresponding implementation file.</td>
</tr>
<tr>
  <td>:R, :RE</td>
  <td>:RS</td>
  <td>:RV</td>
  <td>:RT</td>
  <td>Open corresponding file of next type.</td>
</tr>
</table>

Feature Requests (and More)
---------------------------

I use [Trello](http://trello.com) to track development progress.  You can
vote on new features or watch progress on my [Vim for Objective-C] Trello
board.

Trello does not seem to allow setting a column to be world-writable at
the moment.  If you'd like to request a feature, ping me on Twitter
([@eraserhd](http://twitter.com/#!/eraserhd)) or by e-mail.

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

[Vim for Objective-C]: https://trello.com/board/vim-for-objective-c/4f007a8bce6a25c1792e669a
