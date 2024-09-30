let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/AppData/Local/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 lua/plugins/user/notvscode.lua
badd +9 lua/plugins/user/always.lua
badd +1 after/plugin/mason.rc.lua
badd +1 plugin/lspconfig.lua
badd +5 lua/plugins/user/vscode.lua
badd +1 after/plugin/mini-surround.rc.lua
argglobal
%argdel
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit lua/plugins/user/always.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 52 + 53) / 106)
exe 'vert 1resize ' . ((&columns * 63 + 63) / 127)
exe '2resize ' . ((&lines * 50 + 53) / 106)
exe 'vert 2resize ' . ((&columns * 63 + 63) / 127)
exe 'vert 3resize ' . ((&columns * 63 + 63) / 127)
argglobal
balt after/plugin/mason.rc.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 9 - ((8 * winheight(0) + 25) / 51)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 9
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("lua/plugins/user/vscode.lua", ":p")) | buffer lua/plugins/user/vscode.lua | else | edit lua/plugins/user/vscode.lua | endif
if &buftype ==# 'terminal'
  silent file lua/plugins/user/vscode.lua
endif
balt lua/plugins/user/always.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 5 - ((4 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 5
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("lua/plugins/user/notvscode.lua", ":p")) | buffer lua/plugins/user/notvscode.lua | else | edit lua/plugins/user/notvscode.lua | endif
if &buftype ==# 'terminal'
  silent file lua/plugins/user/notvscode.lua
endif
balt lua/plugins/user/always.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 31 - ((30 * winheight(0) + 51) / 102)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 31
normal! 066|
wincmd w
exe '1resize ' . ((&lines * 52 + 53) / 106)
exe 'vert 1resize ' . ((&columns * 63 + 63) / 127)
exe '2resize ' . ((&lines * 50 + 53) / 106)
exe 'vert 2resize ' . ((&columns * 63 + 63) / 127)
exe 'vert 3resize ' . ((&columns * 63 + 63) / 127)
tabnext
edit after/plugin/mini-surround.rc.lua
argglobal
balt lua/plugins/user/vscode.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 41 - ((40 * winheight(0) + 51) / 102)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 41
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
