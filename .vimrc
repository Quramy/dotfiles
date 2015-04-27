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
set background=light
set noerrorbells
set ignorecase
set smartcase
set hlsearch
set showmatch
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
  let g:tsuquyomi_use_dev_node_module=2
  let g:tsuquyomi_tsserver_path = "\\Users\\nriuser\\git\\TypeScript\\built\\local\\tsserver.js"
endif

"#### Onlu *nix
if ostype=="nix"
  set rtp+=$GOROOT/misc/vim
  exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim/")
  lang en_US
endif

set completeopt=menu
"}}} end BasicSettings

"### NeoBundle Configuration {{{
set nocompatible

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
NeoBundle 'JavaScript-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'vim-json-bundle'
NeoBundle 'jason0x43/vim-js-indent'
NeoBundle 'Quramy/vison'

"#### TypeScript
NeoBundle 'leafgarland/typescript-vim' "NeoBundle 'Quramy/typescript-vim'
NeoBundle 'Quramy/tsuquyomi'
"NeoBundle 'https://github.com/clausreinke/typescript-tools.git'

"#### Golang
NeoBundle 'fatih/vim-go'
NeoBundle 'dgryski/vim-godef'
NeoBundle 'vim-jp/vim-go-extra'
NeoBundle 'google/vim-ft-go'
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

"### Auto Command {{{
"#### File types
augroup vimrc_detect_filetype
	autocmd!
  autocmd BufNewFile,BufRead *.md set filetype=markdown
	autocmd BufNewFile,BufRead *.json set filetype=json
	autocmd BufNewFile,BufRead *.go set filetype=go
	autocmd BufNewFile,BufRead *.ts set filetype=typescript
	autocmd BufNewFile,BufRead *.gradle set filetype=groovy
	autocmd BufNewFile,BufRead *.ru set filetype=ruby
	autocmd BufNewFile,BufRead *.es6 set filetype=javascript

	autocmd BufNewFile * set fenc=utf-8
	autocmd BufNewFile *.bat set fenc=shift-jis
	if(ostype=="win")
		autocmd BufNewFile *.txt set fenc=shift-jis
	endif

  autocmd BufNewFile,BufRead package.json Vison
augroup END
"#### Screen Hacks 
"function SetScreenTabName(name)
"	let arg = 'k' . a:name . '\\'
"	silent! exe '!echo -n "' . arg . "\""
"endfunction
"autocmd VimLeave * call SetScreenTabName('(zsh)')
"autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | call SetScreenTabName("(vim %)") | endif 
"}}} end Auto Command

"### Custome Functions {{{

"#### Change Directory
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>') 
function! s:ChangeCurrentDir(directory, bang)
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
endfunction

call unite#custom#action('openable', 'vsptabopen', s:vsptabopen)


"### TSD install snipet
function! s:tsd_install(...)
  let search_words = map(range(1, a:{0}), 'a:{v:val}')
  echo search_words
  let res = system('tsd install '.join(search_words).' -rs')
  echo res
endfunction

command! -nargs=+ TsdInstall :call s:tsd_install(<q-args>)

"}}} end Custome Functions

"### QuickRun {{{
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
command! -nargs=? -complete=customlist,s:quickrun_switch_complete QuickRunSwitch : call s:quickrun_switch(<f-args>)
"#### babel
let g:quickrun_config['babel'] = {
      \ 'cmdopt': '--stage 1',
      \ 'exec': "babel %o %s | node"
      \ }


"### QuickRun }}}

"### Key Mappings {{{
"#### Prefix
let mapleader = ","
noremap \ ,
nnoremap [unite] <Nop>
nmap <Space>u [unite]

"#### Change Current Directory to Buffer's dir.
nnoremap <silent> <Space>cd :<C-u>CD<CR>

"#### Tab Navigation
noremap gh : <C-u>tabprevious<CR>
noremap gl : <C-u>tabnext<CR>
noremap gq : <C-u>tabclose<CR>

"#### Unite
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>

"#### VimFiler
nnoremap <silent> <Leader>fi : <C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit -buffer-name=side<CR>
autocmd filetype vimfiler nnoremap <silent> <Leader>e : <C-u>call vimfiler#mappings#do_action('vsptabopen')<CR>

"#### GoLang
augroup golang_key_mapping
  autocmd FileType go nmap <Leader>r <Plug>(go-run)
augroup END

augroup vim_script_ut
  autocmd FileType vim nmap <Leader>ut : UTRun % <CR>
augroup END

"#### TypeScript
augroup typescript_key_mapping
  autocmd FileType typescript setlocal completeopt=menu
  autocmd FileType typescript nmap <buffer> <Leader>e <Plug>(TsuquyomiRenameSymbol)
  autocmd FileType typescript setlocal tabstop=4
  autocmd FileType typescript setlocal shiftwidth=4
  autocmd FileType setlocal ballooneval
augroup END

"}}} end Key Mappings 
