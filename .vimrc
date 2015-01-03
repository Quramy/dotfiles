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


"#### Only windows.
if ostype=="win"
	set nobackup
	cd ~
	colorscheme evening
endif

"#### Onlu *nix
if ostype=="nix"
  set rtp+=$GOROOT/misc/vim
  exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim/")
endif

set completeopt=menu
"}}} end BasicSettings



"### NeoBundle Configuration {{{
set nocompatible
"filetype plugin indent off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
	call neobundle#rc(expand('~/.vim/bundle/'))
endif

filetype plugin indent on
NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'ZenCoding.vim'
NeoBundle 'vim-scripts/Emmet.vim'
NeoBundle 'JavaScript-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'HTML5-Syntax-File'
NeoBundle 'vim-json-bundle'

NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'

NeoBundle 'fatih/vim-go'
NeoBundle 'dgryski/vim-godef'
NeoBundle 'vim-jp/vim-go-extra'
NeoBundle 'google/vim-ft-go'

NeoBundle 'Shougo/neosnippet-snippets'

NeoBundleLazy 'Shougo/neocomplcache',{
			\ 'autoload' :{
			\	'insert':1,
			\ }}

NeoBundleLazy 'Shougo/neosnippet', {
			\ 'autoload' : {
			\   'insert' : 1,
			\ }}


NeoBundle 'Shougo/neocomplcache-rsense', {
			\ 'depends': 'Shougo/neocomplcache',
			\ 'autoload': { 'filetypes': 'ruby' }}
NeoBundleLazy 'taichouchou2/rsense-0.3', {
			\ 'build' : {
			\    'mac': 'ruby etc/config.rb > ~/.rsense',
			\    'unix': 'ruby etc/config.rb > ~/.rsense',
			\ } }

NeoBundle 'git://github.com/scrooloose/syntastic.git'

syntax on

" }}} NeoBundle Configuration end.

"### Auto Command {{{
"#### File types
augroup vimrc_detect_filetype
	autocmd!
	autocmd BufNewFile,BufRead *.json set filetype=json
	autocmd BufNewFile,BufRead *.go set filetype=go
	autocmd BufNewFile,BufRead *.gradle set filetype=groovy
	autocmd BufNewFile,BufRead *.ru set filetype=ruby

	autocmd BufNewFile * set fenc=utf-8
	autocmd BufNewFile *.bat set fenc=shift-jis
	if(ostype=="win")
		autocmd BufNewFile *.txt set fenc=shift-jis
	endif
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

"}}} end Custome Functions

"### Key Mappings {{{
"#### Prefix
let mapleader = ","
noremap \ ,

"#### Change Current Directory to Buffer's dir.
nnoremap <silent> <Space>cd :<C-u>CD<CR>

"#### Tab Navigation
noremap gh : <C-u>tabprevious<CR>
noremap gl : <C-u>tabnext<CR>
noremap gq : <C-u>tabclose<CR>

"#### VimFiler
nnoremap <silent> <Leader>fi : <C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit -buffer-name=side<CR>
autocmd filetype vimfiler nnoremap <silent> <Leader>e : <C-u>call vimfiler#mappings#do_action('vsptabopen')<CR>

"#### GoLang
augroup golang_key_mapping
  autocmd FileType go nmap <Leader>r <Plug>(go-run)
augroup END

"}}} end Key Mappings 
