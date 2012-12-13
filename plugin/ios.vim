" ios.vim - Develop iOS applications with Vim
" Author:	Jason Felice <jason.m.felice@gmail.com>

if exists('g:loaded_ios') || &cp || v:version < 700
  finish
endif
let g:loaded_ios = 1

if !has('ruby')
  finish
endif

let s:LibPath = expand('<sfile>:h:h') . '/lib'
execute "ruby $:.push('" . s:LibPath . "')"
ruby require 'ios/vim'
ruby IOS::Vim::initialize

if has('autocmd')
  augroup ios_vim
    autocmd!
    autocmd FileType objc,objcpp set foldmethod=expr foldexpr=getline(v:lnum)=~'^#pragma\ mark\ [^-]'?'>1':'='
  augroup END
endif
