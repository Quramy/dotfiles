"### Pre Config{{{
if has('win32')
	let ostype = "win"
else
	let ostype = "nix"
endif
"}}} end Pre Config

"### Basic Settings{{{
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
set fileformats=unix,dos,mac
set nocompatible
set background=light
set noerrorbells
set ignorecase
set smartcase
set hlsearch
set showmatch
set nowritebackup
set noincsearch
set nowrapscan
set expandtab
set tabstop=2
set shiftwidth=2
set backspace=indent,eol,start
set ruler
set showcmd
set number
set ambiwidth=double
set foldmethod=marker
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set clipboard=unnamed,autoselect

"#### Only windows.
if ostype=="win"
	set nobackup
	cd ~
	colorscheme evening
endif

"#### Only *nix
if ostype=="nix"
  set rtp+=$GOROOT/misc/vim
  exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim/")
  lang en_US
endif

"#### Only with x-term, iterm
if &term ==# 'xterm-256color'
  set title
  set t_ts=]1;
  set t_fs=
  let &titleold=''
endif

set completeopt=menu
"}}} end BasicSettings

"### NeoBundle Configuration {{{
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#begin(expand('~/.vim/bundle/'))
endif

filetype plugin indent on
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-jp/vimdoc-ja'

"#### Core plugins
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'

NeoBundle 'tpope/vim-fugitive'

"#### Tools across lang
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/vesting'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundleLazy 'Shougo/neocomplcache',{
			\ 'autoload' :{
			\	'insert':1,
			\ }}
NeoBundleLazy 'Shougo/neosnippet', {
			\ 'autoload' : {
			\   'insert' : 1,
			\ }}
"NeoBundle 'git://github.com/scrooloose/syntastic.git'

"#### HTML
NeoBundle 'vim-scripts/Emmet.vim'
NeoBundle 'HTML5-Syntax-File'

"#### JavaScript/JSON
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'vim-json-bundle'
NeoBundle 'jason0x43/vim-js-indent'
NeoBundle 'Quramy/vison'

"#### TypeScript
NeoBundle 'leafgarland/typescript-vim' "NeoBundle 'Quramy/typescript-vim'
NeoBundle 'Quramy/tsuquyomi'
"NeoBundle 'https://github.com/clausreinke/typescript-tools.git'

"#### CoffeeScript
NeoBundle 'kchmck/vim-coffee-script'

"#### Golang
NeoBundle 'fatih/vim-go'
NeoBundle 'dgryski/vim-godef'
NeoBundle 'vim-jp/vim-go-extra'
NeoBundle 'google/vim-ft-go'

"#### CSS, SCSS
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'cakebaker/scss-syntax.vim'

"#### Vim script
NeoBundle 'vim-jp/vital.vim'

"#### Ruby
NeoBundle 'Shougo/neocomplcache-rsense', {
			\ 'depends': 'Shougo/neocomplcache',
			\ 'autoload': { 'filetypes': 'ruby' }}

" NeoBundleLazy 'taichouchou2/rsense-0.3', {
" 			\ 'build' : {
" 			\    'mac': 'ruby etc/config.rb > ~/.rsense',
" 			\    'unix': 'ruby etc/config.rb > ~/.rsense',
" 			\ } }

"#### developing

call neobundle#end()

syntax on

" }}} NeoBundle Configuration end.

"### Custome Functions {{{

"#### Change iterm title
function! g:Change_title(basename)
  let cmd = shellescape('echo -ne "\\e]1;aaaa\\a"')
  echo cmd
  call system(cmd)
  "silent execute '!echo -ne "\e]1;aaaa\a"'
endfunction

"#### Change Directory
function! s:change_current(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif
  if a:bang == ''
    pwd
  endif
endfunction

"#### unite, VimFiler
let s:vsptabopen = {'description': 'open file in a new tab and vpsplit', 'is_selectable':1}
function! s:vsptabopen.func(candidates)
  winc l
	for candidate in a:candidates
		if candidate.action__path != ''
			let l:path = candidate.action__path
			tabedit +call\ s:vspcommand() `=l:path`
		endif
	endfor
endfunction

function! s:vspcommand()
	vsplit +call\ s:aftervspcommand()
endfunction

function! s:aftervspcommand()
	vertical resize 35
	b vimfiler:side 
  winc l
endfunction
call unite#custom#action('openable', 'vsptabopen', s:vsptabopen)

"#### TSD install snipet
function! s:tsd_install(...)
  let search_words = map(range(1, a:{0}), 'a:{v:val}')
  echo search_words
  let res = system('tsd install '.join(search_words).' -rs')
  echo res
endfunction

"#### QuickRun
let g:quickrun_config = {}
function! s:quickrun_switch(...)
  if a:{0} && has_key(g:quickrun_config, a:{1})
    let type_name = a:{1}
    echo 'Quickrn switch type: '.type_name
    let b:quickrun_config = g:quickrun_config[type_name]
  endif
endfunction
function! s:quickrun_switch_complete(ArgLead, CmdLine, CursorPos)
  let key_list = keys(g:quickrun_config)
  let matched = []
  for key_str in key_list
    if stridx(key_str, a:ArgLead) == 0
      call add(matched, key_str)
    endif
  endfor 
  return matched
endfunction
let g:quickrun_config['babel'] = {
      \ 'cmdopt': '--stage 1',
      \ 'exec': "babel %o %s | node"
      \ }
let g:quickrun_config['coffee'] = {
      \ 'exec': "coffee %o %s"
      \ }
let g:quickrun_config['go'] = {
      \ 'exec': "go run %s"
      \ }

"#### Golang navigation
let s:go_navigattion_stack = {}
function! s:go_create_nav_info()
  return {'filename': expand('%:p'), 'line': line('.'), 'col': col('.')}
endfunction
function! s:go_go_def()
  let pre_position = s:go_create_nav_info()
  call go#def#Jump()
  let position = s:go_create_nav_info()
  if pre_position != position
    let win_num = winbufnr('%:p')
    if !has_key(s:go_navigattion_stack, win_num)
      let s:go_navigattion_stack[win_num] = []
    endif
    call add(s:go_navigattion_stack[win_num], pre_position)
  endif
endfunction
function! s:go_go_back()
  let win_num = winbufnr('%:p')
  if !has_key(s:go_navigattion_stack, win_num) || !len(s:go_navigattion_stack[win_num])
    echom 'No item in navigation stack'
    return
  endif
  let position = remove(s:go_navigattion_stack[win_num], -1)
  execute 'edit +call\ cursor('.position.line.','.position.col.') '.position.filename
endfunction
"}}} end Custome Functions

"### Original Commands {{{
command! -nargs=? -complete=dir -bang ChangeCurrent  call s:change_current('<args>', '<bang>') 
command! -nargs=+ TsdInstall :call s:tsd_install(<q-args>)
command! -nargs=? -complete=customlist,s:quickrun_switch_complete QuickRunSwitch : call s:quickrun_switch(<f-args>)
command! -nargs=* GoGoDef : call s:go_go_def(<f-args>)
command! GoGoBack : call s:go_go_back()
"}}} end Original Commands

"### Auto Command {{{
"#### File types
augroup vimrc_detect_filetype
	autocmd!
  autocmd BufNewFile,BufRead *.md     set filetype=markdown
	autocmd BufNewFile,BufRead *.json   set filetype=json
	autocmd BufNewFile,BufRead *.ts     set filetype=typescript
	autocmd BufNewFile,BufRead *.es5    set filetype=javascript
	autocmd BufNewFile,BufRead *.es6    set filetype=javascript
	autocmd BufNewFile,BufRead *.coffee set filetype=coffee
	autocmd BufNewFile,BufRead *.go     set filetype=go
	autocmd BufNewFile,BufRead *.ru     set filetype=ruby
	autocmd BufNewFile,BufRead *.gradle set filetype=groovy
augroup END

augroup file_encoding
	autocmd BufNewFile *        setlocal fenc=utf-8
	autocmd BufNewFile *.bat    setlocal fenc=shift-jis
	if ostype=="win"
		autocmd BufNewFile *.txt  setlocal fenc=shift-jis
	endif
augroup END

augroup json_schema
  autocmd BufNewFile,BufRead package.json Vison
  autocmd BufNewFile,BufRead tsconfig.json Vison
  autocmd BufNewFile,BufRead bower.json Vison
  autocmd BufNewFile,BufRead .bowerrc vison bowerrc.json
augroup END

augroup javascript
  au FileType javascript call JavaScriptFold()
augroup END

augroup typescript
  autocmd FileType typescript setlocal completeopt=menu
  autocmd FileType typescript setlocal tabstop=4
  autocmd FileType typescript setlocal shiftwidth=4
  autocmd FileType typescript setlocal foldmethod=syntax
  "autocmd FileType typescript setlocal ballooneval
augroup END

augroup golang
  autocmd FileType go :highlight goErr cterm=bold ctermfg=214
  autocmd FileType go :match goErr /\<err\>/
augroup END

augroup keyward_hyphen
  autocmd FileType xml,html,css,scss setlocal iskeyword+=-
augroup END

"#### Screen Hacks 
"function SetScreenTabName(name)
"	let arg = 'k' . a:name . '\\'
"	silent! exe '!echo -n "' . arg . "\""
"endfunction
"autocmd VimLeave * call SetScreenTabName('(zsh)')
"autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | call SetScreenTabName("(vim %)") | endif 
"}}} end Auto Command

"### Key Mappings {{{
"#### Prefix
let mapleader = ","
noremap \ ,
nnoremap [unite] <Nop>
nmap <Space>u [unite]

"#### Tab Navigation
noremap gh : <C-u>tabprevious<CR>
noremap gl : <C-u>tabnext<CR>
noremap gq : <C-u>tabclose<CR>

"#### Unite
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>

"#### VimFiler
nnoremap <silent> <Leader>fi : <C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit -buffer-name=side<CR>
augroup vimfiler_key_mapping
  autocmd filetype vimfiler nnoremap <silent> <Leader>e : <C-u>call vimfiler#mappings#do_action('vsptabopen')<CR>
augroup END

"#### Change Current Directory to Buffer's dir.
nnoremap <silent> <Space>cd :<C-u>ChangeCurrent<CR>

"#### TypeScript
augroup typescript_key_mapping
  autocmd FileType typescript nmap <buffer> <Leader>e <Plug>(TsuquyomiRenameSymbol)
augroup END

"#### GoLang
augroup golang_key_mapping
  autocmd FileType go nmap <buffer> <silent> <C-]> :<C-u>GoGoDef<CR>
  autocmd FileType go nmap <buffer> <silent> <C-t> :<C-u>GoGoBack<CR>
augroup END

"}}} end Key Mappings 
