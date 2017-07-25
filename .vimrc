source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction


"*************************************************
"Configurações do vimrc;

"map  - funciona em qualquer modo;
"nmap - apenas no modo Normal;
"imap - apenas no modo de Inserção;
"% => Nome do arquivo atual com extensão;
"%< => Nome do arquivo atual sem extensão;
":p => Arquivo atual com seu caminho completo;

"sobe N linhas;
map <F5> 20k

"desce N linhas;
map <F6> 20j

"saltar para a linha N teclando ENTER;
map <CR> gg

"Mover linhas com Ctrl+Alt+(seta abaixo) ou Ctrl+Alt+(seta acima): [tem que estar em modo normal!]
nmap <C-M-Down> ddp
nmap <C-M-Up> ddkP

"Salvando com uma tecla de função:
"salva com F9
map <F9> :w!<cr>

function! Salvar_como()
    call inputsave()
    let nome_arquivo = input('Nome do arquivo para salvar:')
    call inputrestore()
    execute 'w! '.nome_arquivo
endfunction

"Salvando um novo arquivo;
map <F10> :call Salvar_como()<cr>

"Tabs por espaços:
set expandtab
set shiftwidth=4
set tabstop=4

"Régua, quebra e número de linhas:
set linebreak
set number
set ruler

set nu       "mostra numeração de linhas
set showmode "mostra o modo em que estamos
set showcmd  "mostra no status os comandos inseridos
set ts=4     "tamanho das tabulações
syntax on    "habilita cores
set hls      "destaca com cores os termos procurados
set incsearch "habilita a busca incremental
set ai       "auto identação
"set aw       "salvamento automático - veja :help aw
set ignorecase "faz o vim ignorar maiúsculas e minúsculas nas buscas
set smartcase  "Se começar uma busca em maiúsculo ele habilita o case
"set cursorcolumn "deixa visivel um cursor de coluna;
"set cursorline "deixa visivel um cursor de linha;
set encoding=utf-8
set fileencoding=utf-8

"exibir espaços em branco, tab, trilha de espaços em branco, e fim de linha;
:set listchars=eol:¬,tab:»»,trail:~,extends:>,precedes:<,space:·
:set list

"deixa a barra de status visível;
:set laststatus=2
:set statusline=%<%F\ %n%h%m%r%=%-14.(%l,%c%V%)\ %=\%L\ \%P

"abre o file explorer;
map <S-CR> :Explore<CR>

"abre uma nova aba;
map <S-t> :tabnew<CR>

"dividir a tela verticalmente;
nmap <C-LEFT> :vsp<CR>
nmap <C-RIGHT> :vsp<CR>

"dividir a tela horizontalmente
nmap <C-UP> :sp<CR>
nmap <C-DOWN> :sp<CR>

"pular 10 palavras a frente;
nmap <M-2> 10w
"pular 10 palavras a trás;
nmap <M-1> 10b

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

"Exibe uma numeração relativa a posição do cursor (para pular N linhas acima ou para baixo);
nnoremap <F12> :call NumberToggle()<CR>

function! AtivarInvisiveis()
  if(&list == 1)
    set list!
  else
    set list
  endif
endfunc

"Ctrl+espaço ativa e desativa a visualização de caracteres invisiveis;
map <C-space> :call AtivarInvisiveis()<CR>

"Exibir as alterações feitas no arquivo;
map <S-F1> :set nomore<CR>:redir! > changes.txt<CR>:changes<CR>:redir END<CR>:set more<CR><CR>:vsp changes.txt<CR>G

"recarregar o arquivo .vimrc apos ser editado(para não precisar reeiniciar o vim);
map <S-F5> :so $MYVIMRC<CR>

"trocar a palavra do cursor para a proxima palavra;
:nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>:nohlsearch<CR>

"trocar a palavra do cursor para uma palavra anterior;
:nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>

"abre arquivo .vimrc para edição;
map <S-F2> :Texplore<CR>:e $MYVIMRC<CR>

"desabilita a coloração da busca até a próxima busca;
map <esc><esc> :nohlsearch<CR>

"fechar janela;
map <F11> :q<CR>

"trocar de janela separada na mesma aba(o mesmo que ctrl+w);
map <F7> :wincmd w<CR>

"compila um programa C++;
map <F8> :w!<CR>:!g++ -Wall % -o %<<CR>
map <S-F8> :!%<.exe<CR>

"pular palavras em rodo de inserção(alt+N);
"w->     e->
"  |palavra|
"  <-b     <-ge
imap <A-1> <C-o>b
imap <A-2> <C-o>w
imap <A-4> <C-o>e
imap <A-3> <C-o>ge

"salvar automaticamente o arquivo 1/2 segundo após cada alteração(SOMENTE se o arquivo
"já existe);
set updatetime=500
:autocmd CursorHold,CursorHoldI,BufLeave * silent! :update

"Cores disponíveis:
"*cterm-colors*

"NR-16   NR-8    COLOR NAME 
"0       0       Black
"1       4       DarkBlue
"2       2       DarkGreen
"3       6       DarkCyan
"4       1       DarkRed
"5       5       DarkMagenta
"6       3       Brown, DarkYellow
"7       7       LightGray, LightGrey, Gray, Grey
"8       0*      DarkGray, DarkGrey
"9       4*      Blue, LightBlue
"10      2*      Green, LightGreen
"11      6*      Cyan, LightCyan
"12      1*      Red, LightRed
"13      5*      Magenta, LightMagenta
"14      3*      Yellow, LightYellow
"15      7*      White
"
"Mdificar a cor do menu de seleção(Exemplo quando for selecionar uma palavra
"para autocompletar);
" # ctermfg neste caso modificará a cor do item quando ele for selecionado;
" # ctermbg neste caso modificará a cor do seletor do item selecionado;
highlight PmenuSel ctermfg=12 ctermbg=9

"Modifica a cor de fundo do menu para selecionar;
" # ctermfg neste caso modificará a cor das letras dos itens do menu;
" # ctermbg neste caso modificará a cor de fundo do menu;
highlight Pmenu ctermfg=0 ctermbg=15


" <SPACE>   : inicio das proximas palavras (alphanumeric char)
" <S-SPACE> : volta para o inicio das palavras anteriores (alphanumeric char)
" <BS> : final das proximas palavras (alphanumeric char)
" <S-BS> : volta para o final das palavras anteriores (alphanumeric char)
function! <SID>GotoPattern(pattern, dir) range
    let g:_saved_search_reg = @/     
    let l:flags = "We"     
    if a:dir == "b"         
        let l:flags .= "b"     
    endif     
    for i in range(v:count1)         
        call search(a:pattern, l:flags)     
    endfor     
    let @/ = g:_saved_search_reg 
endfunction 

"nnoremap <silent> <SPACE> :<C-U>call <SID>GotoPattern('\(^\\|\<\)[A-Za-z0-9_]', 'f')<CR>
"nnoremap <silent> <S-SPACE> :<C-U>call <SID>GotoPattern('\(^\\|\<\)[A-Za-z0-9_]', 'b')<CR>
"nnoremap <silent> <BS> :<C-U>call <SID>GotoPattern('[A-Za-z0-9_]\(\>\\|$\)', 'f')<CR>
"nnoremap <silent> <S-BS> :call <SID>GotoPattern('[A-Za-z0-9_]\(\>\\|$\)', 'b')<CR>

"listar os buffers aberto;
nmap <S-TAB> :ls<CR>
"ir para o proximo buffer;
nmap <TAB> :bn<CR>

"refresh do visual do terminal;
nmap v<F5> :redraw!<CR>
"*************************************************

"salvar a posição da tela num determinado ponto;
"call CurPos("save") para salvar;
"call CurPos("restore") para restaurar;
function CurPos(action)
  if a:action == "save"
    let b:saveve = &virtualedit
    let b:savesiso = &sidescrolloff
    set virtualedit=all
    set sidescrolloff=0
    let b:curline = line(".")
    let b:curvcol = virtcol(".")
    let b:curwcol = wincol()
    normal! g0
    let b:algvcol = virtcol(".")
    normal! M
    let b:midline = line(".")
    execute "normal! ".b:curline."G".b:curvcol."|"
    let &virtualedit = b:saveve
    let &sidescrolloff = b:savesiso
  elseif a:action == "restore"
    let b:saveve = &virtualedit
    let b:savesiso = &sidescrolloff
    set virtualedit=all
    set sidescrolloff=0
    execute "normal! ".b:midline."Gzz".b:curline."G0"
    let nw = wincol() - 1
    if b:curvcol != b:curwcol - nw
      execute "normal! ".b:algvcol."|zs"
      let s = wincol() - nw - 1
      if s != 0
        execute "normal! ".s."zl"
      endif
    endif
    execute "normal! ".b:curvcol."|"
    let &virtualedit = b:saveve
    let &sidescrolloff = b:savesiso
    unlet b:saveve b:savesiso b:curline b:curvcol b:curwcol b:algvcol b:midline
  endif
  return ""
endfunction


" ACEJUMP
" Based on emacs' AceJump feature (http://www.emacswiki.org/emacs/AceJump).
" AceJump based on these Vim plugins:
"     EasyMotion (http://www.vim.org/scripts/script.php?script_id=3526)
"     PreciseJump (http://www.vim.org/scripts/script.php?script_id=3437)
" Type AJ mapping, followed by a lower or uppercase letter.
" All words on the screen starting with that letter will have
" their first letters replaced with a sequential character.
" Type this character to jump to that word.

highlight AceJumpGrey ctermfg=darkgrey guifg=lightgrey
highlight AceJumpRed ctermfg=darkred guibg=NONE guifg=black gui=NONE

function! AceJumpPalavras ()

    exe "norm m9"
    let ini = str2nr(line('w0'))+5
    exe "norm ".ini."gg"

    " store some current values for restoring later
    let origPos = getpos('.')
    let origSearch = @/

    " prompt for and capture user's search character
    echo "AceJump to words starting with letter: "
    let letter = nr2char(getchar())
    " return if invalid key, mouse press, etc.
    if len(matchstr(letter, '\k')) != 1
        echo ""
        redraw
        return
    endif
    " redraws here and there to get past 'more' prompts
    redraw
    " row/col positions of words beginning with user's chosen letter
    let pos = []

    " monotone all text in visible part of window (dark grey by default)
    call matchadd('AceJumpGrey', '\%'.line('w0').'l\_.*\%'.line('w$').'l', 50)

    " loop over every line on the screen (just the visible lines)
    for row in range(line('w0'), line('w$'))
        " find all columns on this line where a word begins with our letter
        let col = 0
    let matchCol = match(' '.getline(row), '.\<'.letter, col)
    while matchCol != -1
        " store any matching row/col positions
        call add(pos, [row, matchCol])
        let col = matchCol + 1
        let matchCol = match(' '.getline(row), '.\<'.letter, col)
    endwhile
    endfor

    if len(pos) > 1
        " jump characters used to mark found words (user-editable)
        let chars = 'abcdefghijlkmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.;"[]<>{}|\\'

        if len(pos) > len(chars)
            " TODO add groupings here if more pos matches than jump characters
        endif

        " trim found positions list; cannot be longer than jump markers list
        let pos = pos[:len(chars)]

        " jumps list to pair jump characters with found word positions
        let jumps = {}
        " change each found word's first letter to a jump character
        for [r,c] in pos
            " stop marking words if there are no more jump characters
            if len(chars) == 0
                break
            endif
            " 'pop' the next jump character from the list
            let char = chars[0]
            let chars = chars[1:]
            " move cursor to the next found word
            call setpos('.', [0,r,c+1,0])
            " create jump character key to hold associated found word position
            let jumps[char] = [0,r,c+1,0]
            " replace first character in word with current jump character
            exe 'norm r'.char
            " change syntax on the jump character to make it highly visible
            call matchadd('AceJumpRed', '\%'.r.'l\%'.(c+1).'c', 50)
        endfor
        call setpos('.', origPos)

        exe "norm ".ini."gg"
        exe "norm zt"
        exe "norm `9"

        " this redraw is critical to syntax highlighting
        redraw

        " prompt user again for the jump character to jump to
        echo 'AceJump to words starting with "'.letter.'" '
        let jumpChar = nr2char(getchar())

        " get rid of our syntax search highlighting
        call clearmatches()
        " clear out the status line
        echo ""
        redraw
        " restore previous search register value
        let @/ = origSearch

        " undo all the jump character letter replacement
        norm u

        " if the user input a proper jump character, jump to it
        if has_key(jumps, jumpChar)
            exe "norm ".ini."gg"
            exe "norm zt"
            exe "norm `9"
            call setpos('.', jumps[jumpChar])
        else
            " if it didn't work out, restore original cursor position
            exe "norm ".ini."gg"
            exe "norm zt"
            exe "norm `9"
        endif
    elseif len(pos) == 1
        " if we only found one match, just jump to it without prompting
        " set position to the one match
        let [r,c] = pos[0]
        call setpos('.', [0,r,c+1,0])
    elseif len(pos) == 0
        " no matches; set position back to start
        call setpos('.', origPos)
    endif

    :delmarks 9

    " turn off all search highlighting
    call clearmatches()
    " clean up the status line and return
    echo ""
    redraw

    return
endfunction


highlight AceJumpGreyLinhas ctermfg=darkgrey guifg=lightgrey
highlight AceJumpRedLinhas ctermfg=darkred guibg=NONE guifg=black gui=NONE

function! AceJumpLinhas ()

    "cria uma marca do ponto atual do cursor;
    exe "norm m9"
    let ini = str2nr(line('w0'))+5
    exe "norm ".ini."gg"
    let origPos = getpos('.')

    " monotone all text in visible part of window (dark grey by default)
    call matchadd('AceJumpGreyLinhas', '\%'.line('w0').'l\_.*\%'.line('w$').'l', 50)

    let chars = 'abcdefghijlkmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.;"[]<>{}|\\'

    " jumps list to pair jump characters with found word positions
    let jumps = {}
    " loop over every line on the screen (just the visible lines)
    for linha in range(line('w0'), line('w$'))
        if( len(getline(linha)) > 0 ) "colocará as letras nas linhas não vazias;

            let char = chars[0]
            let chars = chars[1:]
            " move cursor to the next found word
            call setpos('.', [0,linha,1,0])
            " create jump character key to hold associated found word position
            let jumps[char] = [0,linha,1,0]
            " replace first character in word with current jump character
            exe 'norm r'.char
            " change syntax on the jump character to make it highly visible
            call matchadd('AceJumpRedLinhas', '\%'.linha.'l\%'.(1).'c', 50)

        endif
    endfor

    call setpos('.', origPos)

    " this redraw is critical to syntax highlighting
    redraw

    " prompt user again for the jump character to jump to
    echo 'Letra da linha que deseja saltar:'
    let jumpChar = nr2char(getchar())

    " get rid of our syntax search highlighting
    call clearmatches()
    " clear out the status line
    echo ""
    redraw

    " undo all the jump character letter replacement
    norm u

    " if the user input a proper jump character, jump to it
    if has_key(jumps, jumpChar)
        exe "norm ".ini."gg"
        exe "norm zt"
        exe "norm `9"
        call setpos('.', jumps[jumpChar])
    else
        " if it didn't work out, restore original cursor position
        exe "norm ".ini."gg"
        exe "norm zt"
        exe "norm `9"
    endif

    :delmarks 9

    call clearmatches()
    echo ""
    redraw

    return
endfunction


function! AceJumpLetras ()

    "cria uma marca do ponto atual do cursor;
    exe "norm m9"
    let ini = str2nr(line('w0'))+5
    exe "norm ".ini."gg"

    " store some current values for restoring later
    let origPos = getpos('.')
    let origSearch = @/

    " prompt for and capture user's search character
    echo "Procurar pelo caractere: "
    let letter = nr2char(getchar())
    " return if invalid key, mouse press, etc.
    if letter == ' ' "permite buscar qualquer caractere, exceto espaço em branco;
    "if len(matchstr(letter, '\k')) != 1
        echo "apagou"
        redraw
        return
    endif
    " redraws here and there to get past 'more' prompts
    redraw
    " row/col positions of words beginning with user's chosen letter
    let pos = []

    " monotone all text in visible part of window (dark grey by default)
    call matchadd('AceJumpGrey', '\%'.line('w0').'l\_.*\%'.line('w$').'l', 50)

    " loop over every line on the screen (just the visible lines)
    for row in range(line('w0'), line('w$'))
        " find all columns on this line where a word begins with our letter
        let col = 0
        for l in split(getline(row), '\zs')
            if( l == letter )
                call add(pos, [row, col])
            endif
            let col = col +1
        endfor
    endfor

    if len(pos) > 1
        " jump characters used to mark found words (user-editable)
        let chars = "abcdefghijlkmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.;\'\"[]<>{}|\\!@#$%&*()_-=+?:^~/`"

        if len(pos) > len(chars)
            " TODO add groupings here if more pos matches than jump characters
             
        endif

        " trim found positions list; cannot be longer than jump markers list
        let pos = pos[:len(chars)]

        " jumps list to pair jump characters with found word positions
        let jumps = {}
        " change each found word's first letter to a jump character
        for [r,c] in pos
            " stop marking words if there are no more jump characters
            if len(chars) == 0
                break
            endif
            " 'pop' the next jump character from the list
            let char = chars[0]
            let chars = chars[1:]
            " move cursor to the next found word
            call setpos('.', [0,r,c+1,0])
            " create jump character key to hold associated found word position
            let jumps[char] = [0,r,c+1,0]
            " replace first character in word with current jump character
            exe 'norm r'.char
            " change syntax on the jump character to make it highly visible
            call matchadd('AceJumpRed', '\%'.r.'l\%'.(c+1).'c', 50)
        endfor
        call setpos('.', origPos)

        exe "norm ".ini."gg"
        exe "norm zt"
        exe "norm `9"

        " this redraw is critical to syntax highlighting
        redraw

        " prompt user again for the jump character to jump to
        echo 'Saltar para o local procurado por "'.letter.'" '
        let jumpChar = nr2char(getchar())

        " get rid of our syntax search highlighting
        call clearmatches()
        " clear out the status line
        echo ""
        redraw
        " restore previous search register value
        let @/ = origSearch

        " undo all the jump character letter replacement
        norm u

        " if the user input a proper jump character, jump to it
        if has_key(jumps, jumpChar)
            exe "norm ".ini."gg"
            exe "norm zt"
            exe "norm `9"
            call setpos('.', jumps[jumpChar])
        else
            " if it didn't work out, restore original cursor position
            exe "norm ".ini."gg"
            exe "norm zt"
            exe "norm `9"
        endif
    elseif len(pos) == 1
        " if we only found one match, just jump to it without prompting
        " set position to the one match
        let [r,c] = pos[0]
        call setpos('.', [0,r,c+1,0])
    elseif len(pos) == 0
        " no matches; set position back to start
        call setpos('.', origPos)
    endif

    :delmarks 9

    " turn off all search highlighting
    call clearmatches()
    " clean up the status line and return
    echo ""
    redraw

    return
endfunction


map <M-a> :call AceJumpPalavras()<CR>
map <F2> :call AceJumpLetras()<CR>
map <SPACE> :call AceJumpLinhas()<CR>


"Cria diretorio de backup automaticamente;
function! InitBackupDir()
  if has('win32') || has('win32unix') "windows/cygwin
    let l:separator = '_'
  else
    let l:separator = '.'
  endif
  let l:parent = $HOME . '/' . l:separator . 'vim/'
  let l:backup = l:parent . 'backup/'
  let l:tmp = l:parent . 'tmp/'
  let l:undo= l:parent . 'undo/'
  if exists('*mkdir')
    if !isdirectory(l:parent)
      call mkdir(l:parent)
    endif
    if !isdirectory(l:backup)
      call mkdir(l:backup)
    endif
    if !isdirectory(l:tmp)
      call mkdir(l:tmp)
    endif
    if !isdirectory(l:undo)
      call mkdir(l:undo)
    endif
  endif
  let l:missing_dir = 0
  if isdirectory(l:tmp)
    execute 'set backupdir=' . escape(l:backup, ' ') . '/,.'
  else
    let l:missing_dir = 1
  endif
  if isdirectory(l:backup)
    execute 'set directory=' . escape(l:tmp, ' ') . '/,.'
  else
    let l:missing_dir = 1
  endif
  if isdirectory(l:undo)
    execute 'set undodir=' . escape(l:undo, ' ') . '/,.'
  else
    let l:missing_dir = 1
  endif
  if l:missing_dir
    echo 'Warning: Unable to create backup directories:' l:backup 'and' l:tmp 'and' l:undo
    echo 'Try: mkdir -p' l:backup
    echo 'and: mkdir -p' l:tmp
    echo 'and: mkdir -p' l:undo
    set backupdir=.
    set directory=.
    set undodir=.
  endif
endfunction
call InitBackupDir()


"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
let g:netrw_liststyle=0         " thin (change to 3 for tree)
let g:netrw_banner=0            " no banner
let g:netrw_altv=1              " open files on right
let g:netrw_preview=1           " open previews vertically

fun! VexOpen(dir)
  let g:netrw_browse_split=1    " open files in previous window
  let vex_width = 25

  execute "Vexplore " . a:dir
  let t:vex_buf_nr = bufnr("%")
  wincmd H

  call VexSize(vex_width)
endf

fun! VexClose()
  let cur_win_nr = winnr()
  let target_nr = ( cur_win_nr == 1 ? winnr("#") : cur_win_nr )

  1wincmd w
  close
  unlet t:vex_buf_nr

  execute (target_nr - 1) . "wincmd w"
  call NormalizeWidths()
endf

fun! VexSize(vex_width)
  execute "vertical resize" . a:vex_width
  set winfixwidth
  call NormalizeWidths()
endf

fun! NormalizeWidths()
  let eadir_pref = &eadirection
  set eadirection=hor
  set equalalways! equalalways!
  let &eadirection = eadir_pref
endf

fun! VexToggle(dir)
  if exists("t:vex_buf_nr")
    call VexClose()
  else
    call VexOpen(a:dir)
  endif
endf

noremap <Leader><Tab> :call VexToggle(getcwd())<CR>
noremap <Leader>f :call VexToggle("")<CR>
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


"Redimensionar o tamanho da janela;
map <silent> t<left> <C-w><
map <silent> t<down> <C-W>-
map <silent> t<up> <C-W>+
map <silent> t<right> <C-w>>

"exibir lista de marcas no arquivo;
map <Leader>m :marks<CR>

