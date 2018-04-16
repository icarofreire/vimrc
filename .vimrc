source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" formas de inserir arquivo no .vimrc;
" source $VIM/codigo.vim
" source $HOME/codigo.vim
" source $VIMRUNTIME/codigo.vim

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


"---------------------------------------------------------------------------------------------
"Configurações do vimrc;

"map  - funciona em qualquer modo;
"nmap - apenas no modo Normal;
"imap - apenas no modo de Inserção;
"% => Nome do arquivo atual com extensão;
"%< => Nome do arquivo atual sem extensão;
":p => Arquivo atual com seu caminho completo;


" Dica de REGEX para substituição e inserção;
" \num
" Onde num é um inteiro positivo. Faz referência a substring pertencente à um grupo, um grupo é definido entre "parênteses. Grupos são numerados de 1 até 9.
" Repetir o conteúdo encontrado pela regex numa substituição(Para isso, deve-se utilizar grupo '()');
"  o '\número' memoriza o conteudo do grupo captado pela regex;
" \1 = primeiro grupo; \2 = segundo grupo; \3 = terceiro grupo; ...
" :s/\(<regex dentro do grupo para procurar>\)/\1<conteudo para adicionar apos o match>/g
" ou
" :s/\(<regex dentro do grupo para procurar>\)/<conteudo para adicionar apos o match>\1/g


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

set relativenumber
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

"deixa a barra de status visível;
:set laststatus=2
:set statusline=%<%F\ %n%h%m%r%=%-14.(%l,%c%V%)\ %=\%L\ \%P

"abre um menu atravez da tecla tab depois de escrever o comando;
set wildmenu
set wildmode=longest:list,full

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

"colar no arquivo o conteúdo da memoria do clipboard(texto copiado em outra
"área no computador);
map <M-p> "+p

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

"Exibe uma numeração relativa a posição do cursor (para pular N linhas acima ou para baixo);
nnoremap <F12> :call NumberToggle()<CR>

"exibir espaços em branco, tab, trilha de espaços em branco, e fim de linha;
function! AtivarInvisiveis()
  if(&list == 1)
    set list!
  else
    set listchars=eol:¬,tab:»»,trail:~,extends:>,precedes:<,space:·
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
map <Leader>w :wincmd w<CR>

"compila um programa C++;
map <F8> :w!<CR>:!g++ -std=c++11 -Wall % -o %<<CR>
map <S-F8> :!%<.exe<CR>

"salvar automaticamente o arquivo 1/2 segundo após cada alteração(SOMENTE se o arquivo
"já existe);
set updatetime=500
:autocmd CursorHold,CursorHoldI,BufLeave * silent! :update

"listar os buffers aberto;
nmap <Leader>b :ls<CR>

"ir para o proximo buffer;
nmap <TAB> :bn<CR>

"ir para o buffer anterior;
nmap <S-TAB> :bp<CR>

"refresh do visual do terminal;
nmap v<F5> :redraw!<CR>

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


"Redimensionar o tamanho da janela;
map <silent> t<left> <C-w><
map <silent> t<down> <C-W>-
map <silent> t<up> <C-W>+
map <silent> t<right> <C-w>>

"exibir lista de marcas no arquivo;
map <Leader>m :marks<CR>

"exibir a lista de alterações;
map <Leader>c :changes<CR>

"exibir a lista de saltos;
map <Leader>j :jumps<CR>

"exibir a lista de comandos;
map <Leader>h :history<CR>


" -- RocketJump -- ;
" RocketJump -- jump to a visible line using alphabetic signs instead of line numbers
" Author: Danilov Aleksey <thetruenightwalker@gmail.com>
" Version: 1.0

" Starting ID for signs
if !exists("g:rj_startid")
	let g:rj_startid = 888888
endif
" Sign chars
if !exists("g:rj_chars")
	let g:rj_chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
endif
" Adjust command char
if !exists("g:rj_cmdchar")
	let g:rj_cmdchar = " "
endif
" Sign highlighting scheme
if !exists("g:rj_signscheme")
	let g:rj_signscheme = (has("gui_running")? "guifg=darkred" : "ctermfg=darkred")
endif
exe "highlight rj_signcolor ".g:rj_signscheme

" Initial definition of signs
function! RocketJump_DefineJumpSigns()
	let i = 1
	while i < strlen(g:rj_chars)
		exe "sign define rj_sign".i." text=".strpart(g:rj_chars, i - 1, 1)." texthl=rj_signcolor"
		let i += 1
	endwhile
endfunction

" Jumping with signs
function! RocketJump_PerformJump(visual) range
	let relnum = &relativenumber
	let number = &number
	set norelativenumber
	set nonumber
	" Placing signs
	let id = g:rj_startid
	let i = line("w0")
	let num = 1
	while i <= line("w$") && num <= strlen(g:rj_chars)
		exe "sign place ".id." line=".i." name=rj_sign".num." buffer=".bufnr("%")
		let i += 1
		let id += 2
		let num += 1
	endwhile
	" Getting user input
	echo "Jump to line "
	let char = nr2char(getchar())
	let lstart = 0
	" Adjusting signs on demand
	while char == g:rj_cmdchar
		" Placing new signs
		let lstart = !lstart
		let id = g:rj_startid + lstart
		let i = line("w0") + lstart
		let num = 1
		while i <= line("w$") && num <= strlen(g:rj_chars)
			exe "sign place ".id." line=".i." name=rj_sign".num." buffer=".bufnr("%")
			let i += 1
			let id += 2
			let num += 1
		endwhile
		" Removing old signs
		let id = g:rj_startid + !lstart
		let i = line("w0") + !lstart
		while i <= line("w$")
			exe "sign unplace ".id." buffer=".bufnr("%")
			let i += 1
			let id += 2
		endwhile
		let char = nr2char(getchar())
	endwhile
	" Jumping to sign
	let i = stridx(g:rj_chars, char)
	"if a:visual
	"	normal! gv
	"endif
	if i >= 0
		exe "sign jump ".(g:rj_startid + lstart + i*2)." buffer=".bufnr("%")
	endif
	" Removing signs
	let id = g:rj_startid + lstart
	let i = line("w0") + lstart
	while i <= line("w$")
		exe "sign unplace ".id." buffer=".bufnr("%")
		let i += 1
		let id += 2
	endwhile
	let &relativenumber = relnum
	let &number = number
endfunction

call RocketJump_DefineJumpSigns()
noremap <SPACE> :call RocketJump_PerformJump(0) <CR>
"if !exists("g:rj_nomapping")
	"noremap <silent> gl :call RocketJump_PerformJump(0) <CR>
	"noremap <silent> gn V <bar> :call RocketJump_PerformJump(1) <CR>
	"vnoremap <silent> gl :call RocketJump_PerformJump(1) <CR>
"endif

" -- RocketJump -- ;



"---------------------------------------------------------------------------------------------



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


"*************************************************


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

    let chars = "abcdefghijlkmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.;\'\"[]<>{}|\\!@#$%&*()_-=+?:^~/`"

    " jumps list to pair jump characters with found word positions
    let jumps = {}
    " loop over every line on the screen (just the visible lines)
    for linha in range(line('w0'), line('w$'))
        "if( len(getline(linha)) > 0 ) "colocará as letras nas linhas não vazias;

            let char = chars[0]
            let chars = chars[1:]
            " move cursor to the next found word
            call setpos('.', [0,linha,1,0])
            " create jump character key to hold associated found word position
            let jumps[char] = [0,linha,1,0]

            if( len(getline(linha)) == 0 ) "se for uma linha vazia, insere um caractere de espaço para poder substituir com uma letra; 
                exe 'norm I '
            endif

            " replace first character in word with current jump character
            exe 'norm r'.char
            " change syntax on the jump character to make it highly visible
            call matchadd('AceJumpRedLinhas', '\%'.linha.'l\%'.(1).'c', 50)

        "endif
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
        let li = getline(jumps[jumpChar][1])[0] " pula para a primeira palavra se o primeiro caractere da linha for vazio;
        if li == " "
            exe "norm w"
        endif

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

        " jumps list to pair jump characters with found word positions
        let jumps = {}
        " change each found word's first letter to a jump character
        for [r,c] in pos "[len(chars):]
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
        exe "norm `9"
    endif

    :delmarks 9

    " turn off all search highlighting
    call clearmatches()
    " clean up the status line and return
    echo ""
    redraw

    return
endfunction


"map <M-a> :call AceJumpPalavras()<CR>
"map <SPACE> :call AceJumpLetras()<CR>
map <F2> :call AceJumpLinhas()<CR>



"inserir comentário(//) no inicio da linha do cursor;
"nmap <C-/> :s/^/\/\//g<CR>:nohlsearch<CR>

function! Inserir_e_retirar_comentario()
    let line = getline('.')
    if line[0] == "/" && line[1] == "/"
        s/\/\///g "apaga comentário;
    else
        s/^/\/\//g "insere comentário;
    endif
endfunction
nmap <C-/> :call Inserir_e_retirar_comentario()<CR>:nohlsearch<CR>


function! Colorir22(pos, origPos, origSearch, ini, letter, letras)
        let jumps = {}
        let chars = a:letras

        " jumps list to pair jump characters with found word positions
        " change each found word's first letter to a jump character
        for [r,c] in a:pos
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
        call setpos('.', a:origPos)

        exe "norm ".a:ini."gg"
        exe "norm zt"
        exe "norm `9"

        " this redraw is critical to syntax highlighting
        redraw

        "" prompt user again for the jump character to jump to
        echo 'Saltar para o local procurado por "'.a:letter.'" '
        "let jumpChar = nr2char(getchar())
        let jumpChar = getchar()

        "" get rid of our syntax search highlighting
        call clearmatches()
        "" clear out the status line
        echo ""
        redraw
        "" restore previous search register value
        let @/ = a:origSearch

        "" undo all the jump character letter replacement
        norm u

        return [jumps, jumpChar]
endfunction

function! AceJumpLetras2()
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

        let res = Colorir22(pos, origPos, origSearch, ini, letter, chars)
        let jumps = res[0]
        let jumpChar = res[1]

        let partl = 0
        while jumpChar == "\<F1>" || jumpChar == "\<F4>" && partl >= 0 && partl < len(pos)

            if jumpChar == "\<F4>"
                if (partl + len(chars)) < len(pos)
                    let partl = partl + len(chars)
                endif
            elseif jumpChar == "\<F1>"
                if partl > 0
                    let partl = partl - len(chars)
                endif
            endif

        call matchadd('AceJumpGrey', '\%'.line('w0').'l\_.*\%'.line('w$').'l', 50)

            let sublist = pos[partl:]
            let res = Colorir22(sublist, origPos, origSearch, ini, letter, chars)
            let jumps = res[0]
            let jumpChar = res[1]
        endwhile

        let jumpC = nr2char(jumpChar)
        " if the user input a proper jump character, jump to it
        if has_key(jumps, jumpC)
            exe "norm ".ini."gg"
            exe "norm zt"
            exe "norm `9"
            call setpos('.', jumps[jumpC])
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
        exe "norm `9"
    endif

    :delmarks 9

    " turn off all search highlighting
    call clearmatches()
    " clean up the status line and return
    echo ""
    redraw

    return
endfunction
map <S-SPACE> :call AceJumpLetras2()<CR>



"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" StupidEasyMotion - Vim motions on speed!
"
" Author: Kim Silkebækken <kim.silkebaekken+vim@gmail.com>
" Source repository: https://github.com/Lokaltog/vim-easymotion

" Default configuration functions {{{
	function! StupidEasyMotion_InitOptions(options) " {{{
		for [key, value] in items(a:options)
			if ! exists('g:StupidEasyMotion_' . key)
				exec 'let g:StupidEasyMotion_' . key . ' = ' . string(value)
			endif
		endfor
	endfunction " }}}
	
    function! StupidEasyMotion_InitHL(group, colors) " {{{
		let group_default = a:group . 'Default'

		" Prepare highlighting variables
		let guihl = printf('guibg=%s guifg=%s gui=%s', a:colors.gui[0], a:colors.gui[1], a:colors.gui[2])
		if !exists('g:CSApprox_loaded')
			let ctermhl = &t_Co == 256
				\ ? printf('ctermbg=%s ctermfg=%s cterm=%s', a:colors.cterm256[0], a:colors.cterm256[1], a:colors.cterm256[2])
				\ : printf('ctermbg=%s ctermfg=%s cterm=%s', a:colors.cterm[0], a:colors.cterm[1], a:colors.cterm[2])
		else
			let ctermhl = ''
		endif

		" Create default highlighting group
		execute printf('hi default %s %s %s', group_default, guihl, ctermhl)

		" Check if the hl group exists
		if hlexists(a:group)
			redir => hlstatus | exec 'silent hi ' . a:group | redir END

			" Return if the group isn't cleared
			if hlstatus !~ 'cleared'
				return
			endif
		endif

		" No colors are defined for this group, link to defaults
		execute printf('hi default link %s %s', a:group, group_default)
	endfunction " }}}
    

	function! StupidEasyMotion_F(visualmode, direction) " {{{
		let char = s:GetSearchChar(a:visualmode)

		if empty(char)
			return
		endif

		let re = '\C' . escape(char, '.$^~')

		call StupidEasyMotion(re, a:direction, a:visualmode ? visualmode() : '', mode(1))
	endfunction " }}}
" }}}


" Helper functions {{{
	function! s:Message(message) " {{{
		echo 'StupidEasyMotion: ' . a:message
	endfunction " }}}
	function! s:Prompt(message) " {{{
		echohl Question
		echo a:message . ': '
		echohl None
	endfunction " }}}


	function! s:VarReset(var, ...) " {{{
		if ! exists('s:var_reset')
			let s:var_reset = {}
		endif

		let buf = bufname("")

		if a:0 == 0 && has_key(s:var_reset, a:var)
			" Reset var to original value
			call setbufvar(buf, a:var, s:var_reset[a:var])
		elseif a:0 == 1
			let new_value = a:0 == 1 ? a:1 : ''

			" Store original value
			let s:var_reset[a:var] = getbufvar(buf, a:var)

			" Set new var value
			call setbufvar(buf, a:var, new_value)
		endif
	endfunction " }}}


	function! s:SetLines(lines, key) " {{{
		try
			" Try to join changes with previous undo block
			undojoin
		catch
		endtry

		for [line_num, line] in a:lines
			call setline(line_num, line[a:key])
		endfor
	endfunction " }}}


	function! s:GetChar() " {{{
		let char = getchar()

		if char == 27
			" Escape key pressed
			redraw

			call s:Message('Cancelled')

			return ''
		endif

		return nr2char(char)
	endfunction " }}}


	function! s:GetSearchChar(visualmode) " {{{
		call s:Prompt('Search for character')

		let char = s:GetChar()

		" Check that we have an input char
		if empty(char)
			" Restore selection
			if ! empty(a:visualmode)
				silent exec 'normal! gv'
			endif

			return ''
		endif

		return char
	endfunction " }}}
" }}}


" Grouping algorithms {{{
	let s:grouping_algorithms = {
	\   1: 'SCTree'
	\ , 2: 'Original'
	\ }
	" Single-key/closest target priority tree {{{
		" This algorithm tries to assign one-key jumps to all the targets closest to the cursor.
		" It works recursively and will work correctly with as few keys as two.
		function! s:GroupingAlgorithmSCTree(targets, keys)
			" Prepare variables for working
			let targets_len = len(a:targets)
			let keys_len = len(a:keys)

			let groups = {}

			let keys = reverse(copy(a:keys))

			" Semi-recursively count targets {{{
				" We need to know exactly how many child nodes (targets) this branch will have
				" in order to pass the correct amount of targets to the recursive function.

				" Prepare sorted target count list {{{
					" This is horrible, I know. But dicts aren't sorted in vim, so we need to
					" work around that. That is done by having one sorted list with key counts,
					" and a dict which connects the key with the keys_count list.

					let keys_count = []
					let keys_count_keys = {}

					let i = 0
					for key in keys
						call add(keys_count, 0)

						let keys_count_keys[key] = i

						let i += 1
					endfor
				" }}}

				let targets_left = targets_len
				let level = 0
				let i = 0

				while targets_left > 0
					" Calculate the amount of child nodes based on the current level
					let childs_len = (level == 0 ? 1 : (keys_len - 1) )

					for key in keys
						" Add child node count to the keys_count array
						let keys_count[keys_count_keys[key]] += childs_len

						" Subtract the child node count
						let targets_left -= childs_len

						if targets_left <= 0
							" Subtract the targets left if we added too many too
							" many child nodes to the key count
							let keys_count[keys_count_keys[key]] += targets_left

							break
						endif

						let i += 1
					endfor

					let level += 1
				endwhile
			" }}}


			" Create group tree {{{
				let i = 0
				let key = 0

				call reverse(keys_count)

				for key_count in keys_count
					if key_count > 1
						" We need to create a subgroup
						" Recurse one level deeper
						let groups[a:keys[key]] = s:GroupingAlgorithmSCTree(a:targets[i : i + key_count - 1], a:keys)
					elseif key_count == 1
						" Assign single target key
						let groups[a:keys[key]] = a:targets[i]
					else
						" No target
						continue
					endif

					let key += 1
					let i += key_count
				endfor
			" }}}

			" Finally!
			return groups
		endfunction
	" }}}


	" Original {{{
		function! s:GroupingAlgorithmOriginal(targets, keys)
			" Split targets into groups (1 level)
			let targets_len = len(a:targets)
			let keys_len = len(a:keys)

			let groups = {}

			let i = 0
			let root_group = 0
			try
				while root_group < targets_len
					let groups[a:keys[root_group]] = {}

					for key in a:keys
						let groups[a:keys[root_group]][key] = a:targets[i]

						let i += 1
					endfor

					let root_group += 1
				endwhile
			catch | endtry

			" Flatten the group array
			if len(groups) == 1
				let groups = groups[a:keys[0]]
			endif

			return groups
		endfunction
	" }}}


	" Coord/key dictionary creation {{{
		function! s:CreateCoordKeyDict(groups, ...)
			" Dict structure:
			" 1,2 : a
			" 2,3 : b
			let sort_list = []
			let coord_keys = {}
			let group_key = a:0 == 1 ? a:1 : ''

			for [key, item] in items(a:groups)
				let key = ( ! empty(group_key) ? group_key : key)

				if type(item) == 3
					" Destination coords

					" The key needs to be zero-padded in order to
					" sort correctly
					let dict_key = printf('%05d,%05d', item[0], item[1])
					let coord_keys[dict_key] = key

					" We need a sorting list to loop correctly in
					" PromptUser, dicts are unsorted
					call add(sort_list, dict_key)
				else
					" Item is a dict (has children)
					let coord_key_dict = s:CreateCoordKeyDict(item, key)

					" Make sure to extend both the sort list and the
					" coord key dict
					call extend(sort_list, coord_key_dict[0])
					call extend(coord_keys, coord_key_dict[1])
				endif

				unlet item
			endfor

			return [sort_list, coord_keys]
		endfunction
	" }}}
" }}}


        "{{{ function! LinesInRange(lines_prev, lines_next)
        function! LinesInRange(lines_prev, lines_next)
            let all_lines = filter( range(line('w0'), line('w$')), 'foldclosed(v:val) == -1' )
            let current = index(all_lines, line('.'))

            let lines_prev = a:lines_prev == -1 ? current : a:lines_prev
            let lines_next = a:lines_next == -1 ? len(all_lines) : a:lines_next

            let lines_prev_i   = max( [0, current - lines_prev] )
            let lines_next_i   = min( [len(all_lines), current + lines_next] )

            return all_lines[ lines_prev_i : lines_next_i ]
        endfunction
        "}}}
        "

        "{{{ function! FindTargets(re, line_numbers)
        function! FindTargets(re, line_numbers)
            let targets = []
            for l in a:line_numbers
                let n = 1
                let match_start = match(getline(l), a:re, 0, 1)
                while match_start != -1
                    call add(targets, [l, match_start + 1])
                    let n += 1
                    let match_start = match(getline(l), a:re, 0, n)
                endwhile
            endfor
            return targets
        endfunction
        "}}}


" Core functions {{{
	function! s:PromptUser(groups) "{{{
		" If only one possible match, jump directly to it {{{
			let group_values = values(a:groups)

			if len(group_values) == 1
				redraw

				return group_values[0]
			endif
		" }}}
		" Prepare marker lines {{{
			let lines = {}
			let hl_coords = []
			let coord_key_dict = s:CreateCoordKeyDict(a:groups)

			for dict_key in sort(coord_key_dict[0])
				let target_key = coord_key_dict[1][dict_key]
				let [line_num, col_num] = split(dict_key, ',')

				let line_num = str2nr(line_num)
				let col_num = str2nr(col_num)

				" Add original line and marker line
				if ! has_key(lines, line_num)
					let current_line = getline(line_num)

					let lines[line_num] = { 'orig': current_line, 'marker': current_line }
				endif

				" Compensate for byte difference between marker
				" character and target character
				"
				" This has to be done in order to match the correct
				" column; \%c matches the byte column and not display
				" column.
				let target_char_len = strdisplaywidth(matchstr(lines[line_num]['marker'], '\%' . col_num . 'c.'))
				let target_key_len = strdisplaywidth(target_key)

				if strlen(lines[line_num]['marker']) > 0
					" Substitute marker character if line length > 0
					let lines[line_num]['marker'] = substitute(lines[line_num]['marker'], '\%' . col_num . 'c.', target_key . repeat(' ', target_char_len - target_key_len), '')
				else
					" Set the line to the marker character if the line is empty
					let lines[line_num]['marker'] = target_key
				endif

				" Add highlighting coordinates
				call add(hl_coords, '\%' . line_num . 'l\%' . col_num . 'c')
			endfor

			let lines_items = items(lines)
		" }}}
		" Highlight targets {{{
			let target_hl_id = matchadd(g:StupidEasyMotion_hl_group_target, join(hl_coords, '\|'), 1)
		" }}}

		try
			" Set lines with markers
			call s:SetLines(lines_items, 'marker')

			redraw

			" Get target character {{{
				call s:Prompt('Target key')

				let char = s:GetChar()
			" }}}
		finally
			" Restore original lines
			call s:SetLines(lines_items, 'orig')

			" Un-highlight targets {{{
				if exists('target_hl_id')
					call matchdelete(target_hl_id)
				endif
			" }}}

			redraw
		endtry

		" Check if we have an input char {{{
			if empty(char)
				throw 'Cancelled'
			endif
		" }}}
		" Check if the input char is valid {{{
			if ! has_key(a:groups, char)
				throw 'Invalid target'
			endif
		" }}}

		let target = a:groups[char]

		if type(target) == 3
			" Return target coordinates
			return target
		else
			" Prompt for new target character
			return s:PromptUser(target)
		endif
	endfunction "}}}


	function! StupidEasyMotion(regexp, direction, visualmode, mode) " {{{
		let orig_pos = [line('.'), col('.')]
		let targets = []

		try
			" Reset properties {{{
				call s:VarReset('&scrolloff', 0)
				call s:VarReset('&modified', 0)
				call s:VarReset('&modifiable', 1)
				call s:VarReset('&readonly', 0)
				call s:VarReset('&spell', 0)
				call s:VarReset('&virtualedit', '')
			" }}}
			" Find motion targets {{{
				let search_direction = (a:direction == 1 ? 'b' : '')
				let search_stopline = line(".")
				normal ^

				" as posições dos caracteres vão para targets;
				" fazer com que pegue todos os respectivos caracteres X exibidos na tela;
				let lnums = LinesInRange(-1, -1)
				let targets = FindTargets(a:regexp, lnums)

				let targets_len = len(targets)
				if targets_len == 0
					throw 'No matches'
				endif
			" }}}

			let GroupingFn = function('s:GroupingAlgorithm' . s:grouping_algorithms[g:StupidEasyMotion_grouping])
			let groups = GroupingFn(targets, split(g:StupidEasyMotion_keys, '\zs'))

			" Prompt user for target group/character
			let coords = s:PromptUser(groups)

			" Update selection {{{
				if ! empty(a:visualmode)
					keepjumps call cursor(orig_pos[0], orig_pos[1])

					exec 'normal! ' . a:visualmode
				endif
			" }}}
			" Handle operator-pending mode {{{
				if a:mode == 'no'
					" This mode requires that we eat one more
					" character to the right if we're using
					" a forward motion
					if a:direction != 1
						let coords[1] += 1
					endif
				endif
			" }}}

			" Update cursor position
			call cursor(orig_pos[0], orig_pos[1])
			mark '
			call cursor(coords[0], coords[1])

			call s:Message('Jumping to [' . coords[0] . ', ' . coords[1] . ']')
		catch
			redraw

			" Show exception message
			call s:Message(v:exception)

			" Restore original cursor position/selection {{{
				if ! empty(a:visualmode)
					silent exec 'normal! gv'
				else
					keepjumps call cursor(orig_pos[0], orig_pos[1])
				endif
			" }}}
		finally
			" Restore properties {{{
				call s:VarReset('&scrolloff')
				call s:VarReset('&modified')
				call s:VarReset('&modifiable')
				call s:VarReset('&readonly')
				call s:VarReset('&spell')
				call s:VarReset('&virtualedit')
			" }}}
			" Remove shading {{{
				if g:StupidEasyMotion_do_shade && exists('shade_hl_id')
					call matchdelete(shade_hl_id)
				endif
			" }}}
		endtry
	endfunction " }}}
" }}}

" vim: fdm=marker:noet:ts=4:sw=4:sts=4


" StupidEasyMotion - Vim motions on speed!
"
" Author: Kim Silkebækken <kim.silkebaekken+vim@gmail.com>
" Source repository: https://github.com/joequery/Stupid-EasyMotion

" Script initialization {{{
	if exists('g:StupidEasyMotion_loaded') || &compatible || version < 702
		finish
	endif

	let g:StupidEasyMotion_loaded = 1
" }}}
" Default configuration {{{
	" Default options {{{
		call StupidEasyMotion_InitOptions({
		\   'leader_key'      : '<Leader><Leader>'
		\ , 'keys'            : 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
		\ , 'do_shade'        : 1
		\ , 'do_mapping'      : 1
		\ , 'grouping'        : 1
		\
		\ , 'hl_group_target' : 'StupidEasyMotionTarget'
		\ , 'hl_group_shade'  : 'StupidEasyMotionShade'
		\ })
	" }}}
	" Default highlighting {{{
		let s:target_hl_defaults = {
		\   'gui'     : ['NONE', 'darkred' , 'bold']
		\ , 'cterm256': ['NONE', '196'     , 'bold']
		\ , 'cterm'   : ['NONE', 'red'     , 'bold']
		\ }

		let s:shade_hl_defaults = {
		\   'gui'     : ['NONE', 'darkred' , 'NONE']
		\ , 'cterm256': ['NONE', '242'     , 'NONE']
		\ , 'cterm'   : ['NONE', 'grey'    , 'NONE']
		\ }

		call StupidEasyMotion_InitHL(g:StupidEasyMotion_hl_group_target, s:target_hl_defaults)
		call StupidEasyMotion_InitHL(g:StupidEasyMotion_hl_group_shade,  s:shade_hl_defaults)

" vim: fdm=marker:noet:ts=4:sw=4:sts=4


"formas de executar;
map <C-j> :call StupidEasyMotion_F('WBW', '1')<CR>
"call StupidEasyMotion_F('', '')
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

