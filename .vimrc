"### Pre Config{{{
if has('win32')
	let ostype = "win"
else
	let ostype = "nix"
endif
"}}} end Pre Config

"### Basic Settings{{{
set encoding=utf-8
set exrc
set secure
set noswapfile
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
set fileformats=unix,dos,mac
set nocompatible
set background=dark
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
set laststatus=2
set autoread

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

"#### Theme
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'cocopon/iceberg.vim'
NeoBundle 'gerw/vim-HiLinkTrace'

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

let g:ale_emit_conflict_warnings = 0 " TODO
NeoBundle 'scrooloose/syntastic'
NeoBundle 'w0rp/ale' , {
      \ 'autoload': {
      \   'filetypes': ['javascript', 'css'],
      \  }}
NeoBundle 'luochen1990/rainbow'
NeoBundle 'puremourning/vimspector'

NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'joker1007/vim-markdown-quote-syntax'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'prabirshrestha/async.vim'
NeoBundle 'prabirshrestha/asyncomplete.vim'
NeoBundle 'prabirshrestha/vim-lsp'
NeoBundle 'tpope/vim-abolish'

"#### Git, Github
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'sodapopcan/vim-twiggy'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'junegunn/vim-emoji'
NeoBundle 'rhysd/github-complete.vim'
NeoBundle 'tpope/vim-rhubarb'

"#### mermaid diagram
NeoBundle 'chazmcgarvey/vim-mermaid'

"#### C/C++
" NeoBundle 'justmao945/vim-clang'

"#### HTML
NeoBundle 'mattn/emmet-vim'
NeoBundle 'HTML5-Syntax-File'
NeoBundle 'digitaltoad/vim-pug'

"#### JavaScript/JSON
NeoBundle 'isRuslan/vim-es6'
NeoBundle 'vim-json-bundle'
NeoBundle 'jason0x43/vim-js-indent'
NeoBundle 'galooshi/vim-import-js'
NeoBundle 'Quramy/vison'
NeoBundle 'Quramy/vim-json-schema-nav'
NeoBundle 'Quramy/vim-js-pretty-template'
NeoBundle 'Quramy/syntastic-node-daemon'
NeoBundle 'Quramy/vim-prettier'
"NeoBundle 'facebook/vim-flow'

"#### TypeScript
"#### NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'HerringtonDarkholme/yats.vim'
" NeoBundle 'maxmellon/vim-jsx-pretty'
NeoBundle 'Quramy/tsuquyomi'
"  NeoBundle 'Quramy/vim-dtsm'

" "#### Golang
" NeoBundle 'fatih/vim-go'
" NeoBundle 'dgryski/vim-godef'
" NeoBundle 'vim-jp/vim-go-extra'
" NeoBundle 'google/vim-ft-go'

"#### CSS, SCSS
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'cakebaker/scss-syntax.vim'

"#### Groovy
NeoBundle 'modille/groovy.vim'

"#### Vim script
NeoBundle 'vim-jp/vital.vim'
NeoBundle 'machakann/vim-vimhelplint'

"#### Ruby
NeoBundle 'Shougo/neocomplcache-rsense', {
			\ 'depends': 'Shougo/neocomplcache',
			\ 'autoload': { 'filetypes': 'ruby' }}
NeoBundle 'slim-template/vim-slim'
NeoBundle 'tpope/vim-rails'

" NeoBundleLazy 'taichouchou2/rsense-0.3', {
" 			\ 'build' : {
" 			\    'mac': 'ruby etc/config.rb > ~/.rsense',
" 			\    'unix': 'ruby etc/config.rb > ~/.rsense',
" 			\ } }

"#### fonts
"NeoBundle 'ryanoasis/vim-devicons'

"#### CSV
NeoBundle 'mechatroner/rainbow_csv'

"#### Twitter
NeoBundle 'TwitVim'

"#### GraphQL
NeoBundle 'jparise/vim-graphql'

"#### TOML
NeoBundle 'cespare/vim-toml'

"#### Thrift
NeoBundle 'solarnz/thrift.vim'

"#### Bazel
NeoBundle 'google/vim-maktaba'
NeoBundle 'bazelbuild/vim-ft-bzl'
NeoBundle 'bazelbuild/vim-bazel'

"#### Prisma2
NeoBundle 'pantharshit00/vim-prisma'

"#### for Nyaovim
" NeoBundle 'rhysd/nyaovim-running-gopher'
" NeoBundle 'johngrib/vim-game-code-break'

"#### re:View
NeoBundle 'moro/vim-review'

"#### terraform
NeoBundle 'hashivim/vim-terraform'

"#### developing

call neobundle#end()

syntax enable
colorscheme iceberg 

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
let g:quickrun_config['typescript'] = {
      \ 'exec': "npx ts-node %s"
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
  return ['tsuquyomi']
endfunction

function! s:syntastic_config.typescriptreact() abort dict
  return ['tsuquyomi']
endfunction

function! s:syntastic_config.javascript() abort dict
  let ret = []
  " if s:prj_has('.eslintrc')[0] || s:prj_has('.eslintrc.js')[0] || s:prj_has('.eslintrc.yml')[0]
  "   let [has, eslint_path] = s:prj_has('node_modules/.bin/eslint')
  "   if has
  "     let b:syntastic_javascript_eslint_exec = eslint_path
  "   endif
  "   call add(ret, 'eslint')
  " endif
  " if s:prj_has('.flowconfig')[0]
  "   let [has, flow_path] = s:prj_has('node_modules/.bin/flow')
  "   if has
  "     let g:flow#enable = 1
  "     " let b:syntastic_javascript_flow_exec = flow_path
  "   else
  "     let g:flow#enable = 0
  "   endif
  "   " call add(ret, 'flow')
  " endif
  return ret
endfunction

function! s:syntastic_config.css() abort dict
  if s:prj_has('.stylelintrc')[0]
    return ['stylelintd']
  else
    return []
  endif
endfunction

function! s:syntastic_buffer_configure()
  if has_key(s:syntastic_config, &filetype)
    let b:syntastic_checkers = s:syntastic_config[&filetype]()
  endif
endfunction

"#### ALE
let s:ale_config = {}

function! s:ale_config.typescript() abort dict
  return [[], []]
endfunction

function! s:ale_config.typescriptreact() abort dict
  return [[], []]
endfunction

function! s:ale_config.javascript() abort dict
  let linters = []
  let fixers = []
  if s:prj_has('.eslintrc')[0] || s:prj_has('.eslintrc.js')[0] || s:prj_has('.eslintrc.yml')[0]
    let [has, eslint_path] = s:prj_has('node_modules/.bin/eslint')
    if has
      let b:syntastic_javascript_eslint_exec = eslint_path
    endif
    call add(linters, 'eslint')
    call add(fixers, 'eslint')
  endif
  return [linters, fixers]
endfunction

function! s:ale_config.css() abort dict
  let linters = []
  let fixers = []
  if filereadable('.stylelintrc') || filereadable('.stylelintrc.json') || filereadable('.stylelintrc.js') || filereadable('.stylelintrc.yaml') || filereadable('.stylelintrc.yml')
    call add(linters, 'stylelint')
    call add(fixers, 'stylelint')
  endif
  return [linters, fixers]
endfunction

function! s:ale_buffer_configure()
  let b:ale_linters = { }
  let b:ale_fixers = { }
  if has_key(s:ale_config, &filetype)
    let [linters, fixers] = s:ale_config[&filetype]()
    let b:ale_linters[&filetype] = linters
    let b:ale_fixers[&filetype] = fixers
  endif
endfunction

"#### Highlight
"
function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! s:highlight_copy_with_file(fname)
  let font_size = 20
  let font = 'monako'
  let out_format = 'rtf'
  let style = 'rootwater'
  let options = [
        \'--out-format', out_format,
        \'--font', font,
        \'--font-size', font_size,
        \'--style', style
        \]
  let rtf = system('highlight ' . join(options, ' ').' '.a:fname)
  call writefile([rtf], expand('~/highlight.rtf'))
endfunction

function! s:highlight_copy_current_buffer()
  call s:highlight_copy_with_file(expand('%:p'))
endfunction

function! s:highlight_copy_visual_selection()
  let fname = tempname().expand('%:t')
  let selection = s:get_visual_selection()
  call writefile(split(selection, '\n'), fname)
  call s:highlight_copy_with_file(fname)
endfunction

"#### live server util
let s:live_server_job_dict = {}
function! s:live_server_start(key) abort
  let cwd = fnamemodify(a:key, ":p:h")
  let command = "npx --yes live-server"
  if !has_key(s:live_server_job_dict, a:key)
    let job = job_start(command, {
          \"cwd": cwd,
          \"in_io": "null",
          \"out_io": "null",
          \"err_io": "null"
          \})
    let s:live_server_job_dict[a:key] = job
  else
    let job = s:live_server_job_dict[a:key]
  endif
  return job
endfunction
function! s:live_server_stop(key) abort
  if has_key(s:live_server_job_dict, a:key)
    let job = s:live_server_job_dict[a:key]
    call job_stop(job, "kill")
  endif
endfunction
function! s:live_server_stop_all() abort
  for job in values(s:live_server_job_dict)
    call job_stop(job, "kill")
  endfor
  let s:live_server_job_dict = {}
endfunction

"#### Mermaid
function! s:mermaid_exec() abort
  let input_path = expand('%:p')
  if !exists('b:mmd_temp_filepath')
    let b:mmd_temp_filepath = tempname().expand('%:t').'.svg'
  endif

  let options = [
        \'-i', input_path,
        \'-o', b:mmd_temp_filepath
        \]
  let result = systemlist('npx --yes mmdc '.join(options))

  if v:shell_error > 0
    if bufexists(b:mmdc_error_buf_name)
      let winid = bufwinid(b:mmdc_error_buf_name)
      if winid isnot# -1
        call win_gotoid(winid)
      else
        execute 'sbuffer' b:mmdc_error_buf_name
      endif
    else
      execute 'new' b:mmdc_error_buf_name
      set buftype=nofile
      nnoremap <silent> <buffer> q :<C-u>bwipeout!<CR>
    endif

    %delete _
    call setline(1, result[2:])

  else
    let svg_path = fnamemodify(b:mmd_temp_filepath, ':t')
    let html_name = fnamemodify(b:mmd_temp_filepath, ':p:h') . '/index.html'
    let html = [
          \"<html>",
          \"  <body>",
          \"    <img widh='100%' src='".svg_path."' />",
          \"  </body>",
          \"</html>"
          \]
    let b:mmdc_error_buf_name = 'mmdc_errors_'.bufname()
    call writefile(html, html_name)
    return [v:shell_error, {
          \"temp_filepath": b:mmd_temp_filepath,
          \"error_buf_name": b:mmdc_error_buf_name
          \}]
  endif
endfunction

function! s:mermaid_write() abort
  let [status, info] = s:mermaid_exec()
  if status  < 1
    if bufexists(info.error_buf_name)
      execute 'bwipeout!' info.error_buf_name
    endif
  endif
endfunction

function! s:mermaid_open() abort
  let [status, info] = s:mermaid_exec()
  if status  < 1
    call s:live_server_start(info.temp_filepath)
    if bufexists(info.error_buf_name)
      execute 'bwipeout!' info.error_buf_name
    endif
  endif
endfunction

function! s:configure_tsuquyomi_formatopt() abort
endfunction

function! s:rubocop_layout() abort
  let input_path = expand('%:p')
  call system('rubocop -x '.input_path)
  edit!
endfunction

"}}} end Custom Functions

"### Original Commands {{{
command! -nargs=1 PrjHas :echo s:prj_has(<q-args>)[1]
command! -nargs=? -complete=dir -bang ChangeCurrent  call s:change_current('<args>', '<bang>') 
command! -nargs=? -complete=customlist,s:quickrun_switch_complete QuickRunSwitch : call s:quickrun_switch(<f-args>)
command! -nargs=* GoGoDef : call s:go_go_def(<f-args>)
command! GoGoBack : call s:go_go_back()
command! SyntasticBufferConfigure : call s:syntastic_buffer_configure()
command! AleBufferConfigure : call s:ale_buffer_configure()
command! HighlightCopyBuf : call s:highlight_copy_current_buffer()
command! HighlightVis : call s:highlight_copy_visual_selection()
command! TermMini : terminal ++rows=14
command! TermPopup : call popup_create(term_start(['zsh'], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: 100, minheight: 24 })
command! LiveServerStopAll : call s:live_server_stop_all()
command! MermaidWrite : call s:mermaid_write()
command! MermaidOpen : call s:mermaid_open()
command! RubocopLayout : call s:rubocop_layout()
"}}} end Original Commands

"### Auto Command {{{
"#### File types

autocmd VimEnter * if empty(expand('<amatch>'))|call FugitiveDetect(getcwd())|endif

augroup vimrc_detect_filetype
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdx}   set filetype=markdown
  autocmd BufNewFile,BufRead *.json       set filetype=json
  autocmd BufNewFile,BufRead *.json5      set filetype=javascript
  autocmd BufNewFile,BufRead .babelrc     set filetype=json
  autocmd BufNewFile,BufRead *.ts         set filetype=typescript
  autocmd BufNewFile,BufRead *.mts        set filetype=typescript
  autocmd BufNewFile,BufRead *.cts        set filetype=typescript
  autocmd BufNewFile,BufRead *.tsx        set filetype=typescriptreact
  autocmd BufNewFile,BufRead *.mjs        set filetype=javascript
  autocmd BufNewFile,BufRead *.jsx        set filetype=javascript
  autocmd BufNewFile,BufRead *.es5        set filetype=javascript
  autocmd BufNewFile,BufRead *.es6        set filetype=javascript
  autocmd BufNewFile,BufRead *.coffee     set filetype=coffee
  autocmd BufNewFile,BufRead *.go         set filetype=go
  autocmd BufNewFile,BufRead *.ru         set filetype=ruby
  autocmd BufNewFile,BufRead *.gradle     set filetype=groovy
  autocmd BufNewFile,BufRead *.graphql    set filetype=graphql
  autocmd BufNewFile,BufRead *.graphcool  set filetype=graphql
  autocmd BufNewFile,BufRead *.thrift     set filetype=thrift
  autocmd BufNewFile,BufRead *.dart       set filetype=dart
  autocmd BufNewFile,BufRead *.vue        set filetype=vue
  autocmd BufNewFile,BufRead *.toml       set filetype=toml
  autocmd BufRead,BufNewFile *.bzl,BUILD,*.BUILD,BUILD.*,WORKSPACE,*.sky setfiletype bzl
  autocmd BufNewFile,BufRead *.re         set filetype=review
  autocmd BufNewFile,BufRead *.pug        set filetype=pug
  autocmd BufNewFile,BufRead *.prisma     set filetype=prisma
  autocmd BufNewFile,BufRead *.slim       set filetype=slim
  autocmd BufNewFile,BufRead *.mmd        set filetype=mermaid
augroup END

augroup file_encoding
  autocmd BufNewFile *        setlocal fenc=utf-8
  autocmd BufNewFile *.bat    setlocal fenc=shift-jis
  if ostype=="win"
    autocmd BufNewFile *.txt  setlocal fenc=shift-jis
  endif
augroup END

augroup clang
  autocmd FileType cpp setlocal completeopt-=preview
  autocmd FileType cpp setlocal omnifunc=lsp#complete
augroup END

augroup fugitive
  autocmd FileType gitcommit setlocal omnifunc=github_complete#complete
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
  autocmd FileType javascript AleBufferConfigure
  " au FileType javascript call JavaScriptFold()
  " au FileType javascript JsPreTmpl html
  au FileType javascript setlocal omnifunc=lsp#complete
augroup END

augroup coffee
  au FileType coffee JsPreTmpl html
augroup END

augroup typescript
  autocmd FileType typescript,typescriptreact AleBufferConfigure
  autocmd FileType typescript,typescriptreact SyntasticBufferConfigure
  autocmd FileType typescript,typescriptreact setlocal completeopt=menu
  autocmd FileType typescript,typescriptreact setlocal tabstop=2
  autocmd FileType typescript,typescriptreact setlocal shiftwidth=2
  autocmd FileType typescript,typescriptreact setlocal foldmethod=syntax
  " autocmd FileType typescript JsPreTmpl
  " autocmd FileType typescript syn clear foldBraces
  " autocmd InsertLeave,TextChanged,BufWritePost *.ts,*.tsx call tsuquyomi#asyncGeterr(1000)
  "autocmd FileType typescript setlocal ballooneval
augroup END

augroup golang
  autocmd FileType go :highlight goErr cterm=bold ctermfg=214
  autocmd FileType go :match goErr /\<err\>/
augroup END

augroup rust
  autocmd FileType rust setlocal omnifunc=lsp#complete
augroup END

augroup ocaml
  autocmd FileType ocaml setlocal omnifunc=lsp#complete
augroup END

augroup css
  autocmd FileType css SyntasticBufferConfigure
  autocmd FileType css AleBufferConfigure
augroup END

augroup keyward_hyphen
  autocmd FileType xml,html,css,scss setlocal iskeyword+=-
augroup END

augroup prisma
  autocmd FileType prisma setlocal omnifunc=lsp#complete
  autocmd FileType prisma setlocal autoindent
  autocmd FileType prisma setlocal smartindent
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

"#### github_complete
if exists('$GITHUB_ACCESS_TOKEN')
  let g:github_complete_github_api_token=$GITHUB_ACCESS_TOKEN
endif

"#### twiggy
let g:twiggy_num_columns = 70

"#### rhubarb
"##### GHE domain
let g:github_enterprise_urls = [$GHE_DOMEIN]

"#### Syntastic checker
let g:syntastic_cpp_include_dirs = []
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

let g:flow#enable = 0
let g:tsuquyomi_disable_quickfix = 1
"let g:syntastic_typescript_checkers = ['tsuquyomi']

"#### Prettier
let g:prettier#exec_cmd_path = "npx prettier"

"#### ALE
let g:ale_linters = { }
let g:ale_fixers = { }
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

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

"#### vim-lsp
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
if executable('clangd-mp-devel')
  call lsp#register_server({
      \ 'name': 'clangd-mp-devel',
      \ 'cmd': {server_info->['clangd-mp-devel']},
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
      \ })
endif
if executable('clangd')
  call lsp#register_server({
      \ 'name': 'clangd',
      \ 'cmd': {server_info->['clangd']},
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
      \ })
endif
" if executable('flow-language-server')
"   au User lsp_setup call lsp#register_server({
"         \ 'name': 'flow-language-server',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'flow-language-server --stdio --try-flow-bin']},
"         \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.flowconfig'))},
"         \ 'whitelist': ['javascript'],
"         \ })
" endif
if executable('rls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'whitelist': ['rust'],
        \ })
endif
if executable('ocamllsp')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'ocaml',
        \ 'cmd': {server_info->['ocamllsp']},
        \ 'whitelist': ['ocaml'],
        \ })
endif
if executable('prisma-language-server')
  call lsp#register_server({
      \ 'name': 'prisma',
      \ 'cmd': {server_info->['prisma-language-server']},
      \ 'whitelist': ['prisma'],
      \ })
endif
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

"#### vimSpector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
let g:vimspector_install_gadgets = [ 
      \ 'vscode-node-debug2',
      \ 'debugger-for-chrome',
      \ 'CodeLLDB'
      \ ]

"#### JsPreTmpl
" call jspretmpl#register_tag('gql', 'graphql')

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

"#### Window util
nnoremap <Leader>fw 15<C-w>+
nnoremap <Leader>ffw 15<C-w>-
nnoremap <Leader>fh 30<C-w>>
nnoremap <Leader>ffh 30<C-w><

"#### Unite
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
nnoremap <silent> [unite]p :<C-u>Unite<Space>-start-insert<Space>file_rec/git:.<CR>
nnoremap <silent> [unite]t :<C-u>Unite<Space>-start-insert<Space>tsproject<CR>

"#### Terminal
nnoremap <silent> <Leader>fa : <C-u>TermMini<CR><C-W>x<C-W>j
nnoremap <silent> <Leader>fk : <C-u>TermPopup<CR><C-W>x<C-W>j
nnoremap <silent> <Leader>fl : <C-u>vsp <bar> term ++curwin<CR>
tnoremap <C-Z> <C-W>N

"#### fugitive
nnoremap <silent> <Leader>fg : <C-u>Git<CR>

"#### twiggy
nnoremap <silent> <Leader>fe : <C-u>Twiggy<CR>

"#### vimspector
nnoremap <silent> <Leader>fx : call vimspector#Launch() <CR>
nnoremap <silent> <Leader>fb : call vimspector#Reset() <CR>

"#### VimFiler
nnoremap <silent> <Leader>fi : <C-u>VimFilerBufferDir -split -simple -winwidth=42 -no-quit -buffer-name=side<CR>
augroup vimfiler_key_mapping
  autocmd filetype vimfiler nnoremap <silent> <Leader>e : <C-u>call vimfiler#mappings#do_action(b:vimfiler, 'vsptabopen')<CR>
augroup END

"#### highlighting
nnoremap <silent> <Leader>hh :<C-u>HighlightCopyBuf<CR>
vnoremap <silent> <Leader>hh :<C-u>HighlightVis<CR>

"#### Change Current Directory to Buffer's dir.
nnoremap <silent> <Space>cd :<C-u>ChangeCurrent<CR>

"#### clang
augroup clang_key_mapping
  autocmd FileType cpp nmap <buffer> <C-]> :LspDefinition <CR>
augroup END

"#### TypeScript
augroup typescript_key_mapping
  autocmd FileType typescript,typescriptreact nmap <buffer> <Leader>e  <Plug>(TsuquyomiRenameSymbol)
  autocmd FileType typescript,typescriptreact nmap <buffer> <Leader>E  <Plug>(TsuquyomiRenameSymbolC)
  autocmd FileType typescript,typescriptreact nmap <buffer> <Leader>ii <Plug>(TsuquyomiImport)
  autocmd FileType typescript,typescriptreact nmap <buffer> <Leader>qf <Plug>(TsuquyomiQuickFix)
  autocmd FileType typescript,typescriptreact nmap <buffer> <Leader>t :<C-u>echo tsuquyomi#hint()<CR>
augroup END

"#### JavaScript
augroup flow_key_mapping
  autocmd FileType javascript nmap <buffer> <C-]> :LspDefinition <CR>
  autocmd FileType javascript nmap <buffer> <Leader>t :<C-u>FlowType<CR>
  autocmd FileType javascript nmap <buffer> <Leader>qf :ALEFix <CR>
augroup END

"#### Ruby(Rails)
augroup rails_key_mapping
  autocmd FileType ruby nmap <buffer> <C-]> gf <CR> 
  autocmd FileType ruby nmap <buffer> <C-w><C-]> :sp<CR> gf <CR> 
  "<Leader>p is mapped by vim-pettier default
  autocmd FileType ruby nmap <buffer> <Leader>p :RubocopLayout <CR>
augroup END

"#### Rust
augroup rust_key_mapping
  autocmd FileType rust nmap <silent> <Leader>p : !rustfmt % <CR>
  autocmd FileType rust nmap <buffer> <C-]> :LspDefinition <CR>
  autocmd FileType rust nmap <buffer> <Leader>t :LspHover <CR>
augroup END

"#### GoLang
augroup golang_key_mapping
  autocmd FileType go nmap <buffer> <silent> <C-]> :<C-u>GoGoDef<CR>
  autocmd FileType go nmap <buffer> <silent> <C-t> :<C-u>GoGoBack<CR>
augroup END

augroup mermaid_mapping
  autocmd FileType mermaid nmap <buffer> <Leader>R :MermaidOpen <CR>
  autocmd FileType mermaid nmap <buffer> <Leader>r :MermaidWrite <CR>
augroup END

"}}} end Key Mappings 
