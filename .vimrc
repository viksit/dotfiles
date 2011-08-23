call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set bg=dark
set ai
set sw=2
set tabstop=2
set ic
set expandtab
set incsearch
set showcmd
set history=1000
set ruler
set hlsearch
set nocompatible

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  filetype plugin indent on
endif

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
au BufNewFile,BufRead *.vm setfiletype javascript


" lhs comments
"map ,# :s/^/#/<CR>:nohlsearch<CR>
"map ,/ :s/^/\/\//<CR>:nohlsearch<CR>
"map ,> :s/^/> /<CR>:nohlsearch<CR>
"map ," :s/^/\"/<CR>:nohlsearch<CR>
"map ,% :s/^/%/<CR>:nohlsearch<CR>
"map ,! :s/^/!/<CR>:nohlsearch<CR>
"map ,; :s/^/;/<CR>:nohlsearch<CR>
"map ,- :s/^/--/<CR>:nohlsearch<CR>
"map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>
"
"" wrapping comments
"map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR>:nohlsearch<CR>
"map ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR>:nohlsearch<CR>
"map ,< :s/^\(.*\)$/<!-- \1 -->/<CR>:nohlsearch<CR>
"map ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>:nohlsearch<CR>
"

noremap <leader>o <Esc>:CommandT<CR>
noremap <leader>O <Esc>:CommandTFlush<CR>
noremap <leader>m <Esc>:CommandTBuffer<CR>

let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>



