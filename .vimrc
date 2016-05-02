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
set clipboard=unnamed
set t_Co=256
set guifont=Ricty\ Regular\ for\ Powerline:h14
set spelllang=en,cjk

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
NeoBundle 'vim-jp/vimdoc-ja'

"#### Core plugins
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'

"#### Theme
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'altercation/vim-colors-solarized'

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
NeoBundle 'scrooloose/syntastic'

NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'joker1007/vim-markdown-quote-syntax'
NeoBundle 'editorconfig/editorconfig-vim'

"#### HTML
NeoBundle 'vim-scripts/Emmet.vim'
NeoBundle 'HTML5-Syntax-File'

"#### JavaScript/JSON
NeoBundle 'isRuslan/vim-es6'
NeoBundle 'vim-json-bundle'
NeoBundle 'jason0x43/vim-js-indent'
NeoBundle 'Quramy/vison'
NeoBundle 'Quramy/vim-js-pretty-template'

"#### TypeScript
NeoBundle 'leafgarland/typescript-vim' "NeoBundle 'Quramy/typescript-vim'
NeoBundle 'Quramy/tsuquyomi'
NeoBundle 'Quramy/vim-dtsm'
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

"#### fonts
"NeoBundle 'ryanoasis/vim-devicons'

"#### Twitter
NeoBundle 'TwitVim'

"#### GraphQL
NeoBundle 'jparise/vim-graphql'

"#### for Nyaovim
NeoBundle 'rhysd/nyaovim-running-gopher'

"#### developing

call neobundle#end()

syntax enable
colorscheme solarized

" }}} NeoBundle Configuration end.

"### Custom Functions {{{
let s:v = vital#of('vital')
let s:prelude = s:v.import('Prelude')
let s:fpath = s:v.import('System.Filepath')

"#### Directory Utility
function! s:prj_has(fname) abort
  let prj_root = s:prelude.path2project_directory(expand('%'))
  if prj_root == ''
    return [0, '']
  endif
  let path = s:fpath.join(prj_root, a:fname)
  if filereadable(path)
    return [1, path]
  else
    return [0, '']
  endif
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
	vertical resize 42
	b vimfiler:side 
  winc l
endfunction
call unite#custom#action('openable', 'vsptabopen', s:vsptabopen)

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
let g:quickrun_config['typescriptProject'] = {
      \ 'exec': ["tsc --outDir .", "node %s:p:r.js"]
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

"#### Syntastic Buffer Configure
let s:syntastic_config = {}

function! s:syntastic_config.typescript() abort dict
  if s:prj_has('tslint.json')[0]
    return ['tsuquyomi', 'tslint']
  else
    return ['tsuquyomi']
  endif
endfunction

function! s:syntastic_config.javascript() abort dict
  if s:prj_has('.eslintrc')[0] || s:prj_has('.eslintrc.js')[0] || s:prj_has('.eslintrc.yml')[0]
    let [has, eslint_path] = s:prj_has('node_modules/.bin/eslint')
    if has
      let b:syntastic_javascript_eslint_exec = eslint_path
    endif
    return ['eslint']
  endif
endfunction

function! s:syntastic_buffer_configure()
  if has_key(s:syntastic_config, &filetype)
    let b:syntastic_checkers = s:syntastic_config[&filetype]()
  endif
endfunction

"}}} end Custom Functions

"### Original Commands {{{
command! -nargs=1 PrjHas :echo s:prj_has(<q-args>)[1]
command! -nargs=? -complete=dir -bang ChangeCurrent  call s:change_current('<args>', '<bang>') 
command! -nargs=? -complete=customlist,s:quickrun_switch_complete QuickRunSwitch : call s:quickrun_switch(<f-args>)
command! -nargs=* GoGoDef : call s:go_go_def(<f-args>)
command! GoGoBack : call s:go_go_back()
command! SyntasticBufferConfigure : call s:syntastic_buffer_configure()
"}}} end Original Commands

"### Auto Command {{{
"#### File types

augroup vimrc_detect_filetype
  autocmd!
  autocmd BufNewFile,BufRead *.md     set filetype=markdown
  autocmd BufNewFile,BufRead *.json   set filetype=json
  autocmd BufNewFile,BufRead .babelrc set filetype=json
  autocmd BufNewFile,BufRead *.ts     set filetype=typescript
  autocmd BufNewFile,BufRead *.tsx    set filetype=typescript
  autocmd BufNewFile,BufRead *.es5    set filetype=javascript
  autocmd BufNewFile,BufRead *.es6    set filetype=javascript
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee
  autocmd BufNewFile,BufRead *.go     set filetype=go
  autocmd BufNewFile,BufRead *.ru     set filetype=ruby
  autocmd BufNewFile,BufRead *.gradle set filetype=groovy
  autocmd BufNewFile,BufRead *.graphql set filetype=graphql
augroup END

augroup file_encoding
  autocmd BufNewFile *        setlocal fenc=utf-8
  autocmd BufNewFile *.bat    setlocal fenc=shift-jis
  if ostype=="win"
    autocmd BufNewFile *.txt  setlocal fenc=shift-jis
  endif
augroup END

augroup fugitive
  autocmd FileType gitcommit setlocal spell
augroup END

augroup markdown
  autocmd FileType markdown setlocal spell
augroup END

augroup json_schema
  autocmd BufNewFile,BufRead package.json Vison
  autocmd BufNewFile,BufRead tsconfig.json Vison
  autocmd BufNewFile,BufRead bower.json Vison
  autocmd BufNewFile,BufRead .bowerrc vison bowerrc.json
augroup END

augroup javascript
  autocmd FileType javascript SyntasticBufferConfigure
  "au FileType javascript call JavaScriptFold()
  au FileType javascript JsPreTmpl html
augroup END

augroup coffee
  au FileType coffee JsPreTmpl html
augroup END

augroup typescript
  autocmd FileType typescript SyntasticBufferConfigure
  autocmd FileType typescript setlocal completeopt=menu
  autocmd FileType typescript setlocal tabstop=4
  autocmd FileType typescript setlocal shiftwidth=4
  autocmd FileType typescript setlocal foldmethod=syntax
  autocmd FileType typescript JsPreTmpl html
  autocmd FileType typescript syn clear foldBraces
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

"### Plugin Settings {{{
"#### Airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = '⮀'
let g:airline_right_sep = '⮂'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'
let g:airline#extensions#tabline#left_sep = '⮀'
let g:airline#extensions#tabline#left_alt_sep = '⮀'

"#### Syntastic checker
let g:tsuquyomi_disable_quickfix = 1
"let g:syntastic_typescript_checkers = ['tsuquyomi']

"#### Markdown Syntax
let g:markdown_quate_syntax_filetypes = {
      \ "typescript": {
      \   "start": "typescript",
      \   },
      \ }

"#### TwitVim
let twitvim_browser_cmd = 'open'
let twitvim_enable_python = 1
let twitvim_count = 40

"}}} end Plugin Settings

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
nnoremap <silent> [unite]p :<C-u>Unite<Space>-start-insert<Space>file_rec/git:.<CR>
nnoremap <silent> [unite]t :<C-u>Unite<Space>-start-insert<Space>tsproject<CR>

"#### VimFiler
nnoremap <silent> <Leader>fi : <C-u>VimFilerBufferDir -split -simple -winwidth=42 -no-quit -buffer-name=side<CR>
augroup vimfiler_key_mapping
  autocmd filetype vimfiler nnoremap <silent> <Leader>e : <C-u>call vimfiler#mappings#do_action('vsptabopen')<CR>
augroup END

"#### Change Current Directory to Buffer's dir.
nnoremap <silent> <Space>cd :<C-u>ChangeCurrent<CR>

"#### TypeScript
augroup typescript_key_mapping
  autocmd FileType typescript nmap <buffer> <Leader>e <Plug>(TsuquyomiRenameSymbol)
  autocmd FileType typescript nmap <buffer> <Leader>E <Plug>(TsuquyomiRenameSymbolC)
  autocmd FileType typescript nmap <buffer> <Leader>t :<C-u>echo tsuquyomi#hint()<CR>
augroup END

"#### GoLang
augroup golang_key_mapping
  autocmd FileType go nmap <buffer> <silent> <C-]> :<C-u>GoGoDef<CR>
  autocmd FileType go nmap <buffer> <silent> <C-t> :<C-u>GoGoBack<CR>
augroup END


"}}} end Key Mappings 
