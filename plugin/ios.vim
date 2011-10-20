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
execute "ruby require '" . s:LibPath . "/ios/vim'" 
ruby IOS::Vim.initialize
