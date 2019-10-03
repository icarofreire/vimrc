source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" formas de inserir arquivo no .vimrc;
" source $VIM/codigo.vim
" source $HOME/codigo.vim
" source $VIMRUNTIME/codigo.vim
"colorscheme sierra
"==============================================================================
"Configurações do vimrc;
"

"map  - funciona em qualquer modo;
"nmap - apenas no modo Normal;
"imap - apenas no modo de Inserção;
"cmap - funciona em modo de linha de comando (':');
"% => Nome do arquivo atual com extensão;
"%< => Nome do arquivo atual sem extensão;
":p => Arquivo atual com seu caminho completo;


set expandtab "Tabs por espaços;
set shiftwidth=4
set tabstop=4 "tamanho das tabulações
set linebreak   "quebra de linha
set number  "numero de linhas
set ruler   "Sempre mostre a posição do cursor;
set relativenumber  "numeros relativos;
set nu       "mostra numeração de linhas
set showmode "mostra o modo em que estamos
set showcmd  "mostra no status os comandos inseridos
syntax on    "habilita cores
set hls      "destaca com cores os termos procurados
set incsearch "habilita a busca incremental
set ai       "auto identação
set aw       "salvamento automático - veja :help aw
set ignorecase "faz o vim ignorar maiúsculas e minúsculas nas buscas
set smartcase  "Se começar uma busca em maiúsculo ele habilita o case
set encoding=utf-8
set fileencoding=utf-8

"deixa a barra de status visível;
:set laststatus=2
:set statusline=%<%F\ %n%h%m%r%=%-14.(%l,%c%V%)\ %=\%L\ \%P

"abre um menu atravez da tecla tab depois de escrever o comando;
set wildmenu
set wildmode=longest:list,full

"exibir o netrw como uma arvore;
let g:netrw_liststyle=3

"pesquisar em subdiretórios recursivamente;
set path+=**

" possibilidade de mapear a tecla 'leader' para a tecla que desejar;
"let mapleader = "-"

" fazer a mesma coisa que ':' ;
nmap <space> :

"saltar para a linhaa e coluna da marca;"
map <F2> `

"executar a ultima macro executada;
map <F4> @@

"editar/recarregar o arquivo .vimrc;
nmap -ev :tabnew<CR>:e $MYVIMRC<CR>
nmap -sv :so $MYVIMRC<CR>:nohlsearch<CR>

"pesquisar em todos os arquivos;
nmap -pes :vimgrep // **/*<C-Left><C-Left><Right>

"salvar todos os buffers abertos;
nmap -w :wa<CR>
nmap sa :wa<CR>

"trocar de janela separada na mesma aba(o mesmo que ctrl+w);
nmap tw :wincmd w<CR>

"modificar a cor da selecao no modo visual;
hi Visual cterm=bold ctermbg=Blue ctermfg=black

"modificar cor para resultados na busca (verde);
"hi Search ctermfg=DarkRed ctermbg=DarkGreen

"faz substituição no conteúdo selecionado(movo visual);
vmap <C-r> :s###g<Left><Left><Left>

"faz substituição em todo o arquivo(modo comando);
nmap <M-k> :%s###g<Left><Left><Left>

"faz substituição em uma linha(modo comando);
nmap <M-l> :s###<Left><Left>

"abrir qualquer arquivo recursivamente para o buffer;
nmap <M-o> :arg **/*.*<CR>

"abrir recursivamente arquivos especificos para o buffer;
nmap <M-i> :arg **/*.cpp

"faz uma substituição em todos os arquivos no buffer;
nmap <M-b> :argdo %s###ge

"faz uma listagem de todos os arquivos no buffer; E insere logo o numero do buffer para abri-lo;
"se a lista do buffer estiver grande, precione espaço <Space> para logo iserir o numero do buffer desejado;
nmap sd :buffers<CR>:buffer<Space>

"sobe N linhas;
map <F5> 10k

"desce N linhas;
map <F6> 10j

"saltar para a linha N teclando ENTER;
map <CR> gg

"deletar uma palavra inteira em modo de inserção;
imap <C-e> <C-o>ciw

"atalho para saltar para o final de cada palavra;
map <M-e> ge

"trocar de abas (direita/esquerda);
map <M-s> gt
map <M-a> gT

"passar para a aba anterior - aba esquerda;
nmap tg gT

"colar no arquivo o conteúdo da memoria do clipboard(texto copiado em outra
"área no computador);
map <M-p> "+p

"filtrar resultados de arquivos já abertos;
noremap <M-r> :browse filter // oldfiles<C-Left><C-Left><Right>

"salvar automaticamente o arquivo 1/2 segundo após cada alteração(SOMENTE se o arquivo
"já existe);
function! AutoSave()
    set updatetime=500
    :autocmd CursorHold,CursorHoldI,BufLeave * silent! :update
endfunction
"call AutoSave()

"ir para o proximo buffer;
nmap <TAB> :bn<CR>

"ir para o buffer anterior;
nmap <S-TAB> :bp<CR>

"refresh do visual do terminal;
nmap <S-F5> :redraw!<CR>

"autocompletar palavras no modo de insercao
imap <F5> <c-n>

"Redimensionar o tamanho da janela;
map <silent> t<left> <C-w><
map <silent> t<down> <C-W>-
map <silent> t<up> <C-W>+
map <silent> t<right> <C-w>>

" navegação de janelas divididas (Splits);
" esquerda/direita/cima/baixo;
map <c-h> <c-w>h
map <c-l> <c-w>l
map <c-k> <c-w>k
map <c-j> <c-w>j

"saltar para caracteres (,{,[," e ';
nnoremap <silent> <M-1> :call search("[\(\{\[\"\']", 'b')<CR>
nnoremap <silent> <M-2> :call search("[\(\{\[\"\']")<CR>

"trocar a palavra do cursor para a proxima palavra;
:nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>:nohlsearch<CR>

"trocar a palavra do cursor para uma palavra anterior;
:nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>

"desabilita a coloração da busca até a próxima busca;
map <Leader>n :nohlsearch<CR>

"abre o file explorer;
map <Leader>o :Explore<CR>

"fechar janela;
map <Leader>f :q!<CR>

"fechar todas as janelas;
map <Leader>q :qa!<CR>

"abre uma nova aba;
map <Leader>t :tabnew<CR>

"trocar de janela separada na mesma aba(o mesmo que ctrl+w);
map <Leader>w :wincmd w<CR>

"listar os buffers aberto;
nmap <Leader>b :ls<CR>

"exibir lista de marcas no arquivo;
map <Leader>m :marks<CR>

"deletar marcas facilmente;
map <Leader>d :delm<space>

"abrir lista de arquivos recentemente abertos;
"(Aberta a lista, pressione 'ESC' ou 'q' para cancelar o '-- More --' e digitar o número do arquivo a ser aberto da lista);
map <Leader>r :browse oldfiles<CR>

"Abrir o manual de referência de comandos do próprio vim;
map <Leader>h :help quickref<CR>

"abrir lista de resultados da busca do vimgrep(:vimgrep /string/gj **/*);
map <Leader>g :copen<CR>

"pesquisar em subdiretórios pela parte do nome inserida, expandindo uma lista com os resultados com <Tab>;
noremap <Leader>z :find **<Left>


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


"inserir comentário(//) no inicio da linha do cursor;
function! Inserir_e_retirar_comentario()
    let fileType = &ft
    let line = getline('.')
    if fileType == 'c' || fileType == 'cpp' || fileType == 'php' || fileType == 'java'
        if line[0] == "/" && line[1] == "/"
            s/^\/\///g "apaga comentário;
        else
            s/^/\/\//g "insere comentário;
        endif
    elseif fileType == 'python' || fileType == 'ruby'
        if line[0] == "#"
            s/^#//g "apaga comentário;
        else
            s/^/#/g "insere comentário;
        endif
    endif
endfunction
nmap <M-c> :call Inserir_e_retirar_comentario()<CR>:nohlsearch<CR>


" -- resolver o problema de combinações com a tecla alt não funcionar no terminal do linux;
function! Ativar_alt_term_linux()
    let c='a'
    while c <= 'z'
      exec "set <A-".c.">=\e".c
      exec "imap \e".c." <A-".c.">"
      let c = nr2char(1+char2nr(c))
    endw

    let c='0'
    while c <= '9'
      exec "set <A-".c.">=\e".c
      exec "imap \e".c." <A-".c.">"
      let c = nr2char(1+char2nr(c))
    endw
    set timeout ttimeoutlen=50
endfunction
"call Ativar_alt_term_linux()


"listar todos os arquivos recursivamente a partir do diretório atual em um
"buffer;
"map <F3> :call ListTree('.')<CR>
function! ListTree(dir)
  "new
  vnew
  set buftype=nofile
  set bufhidden=hide
  set noswapfile
  set cursorline
  normal i.
  while 1
    let file = getline(".")
    if (file == '')
      normal dd
    elseif (isdirectory(file))
      normal dd
      let @" = glob(file . "/*")
      normal O
      normal P
      let @" = glob(file . "/.[^.]*")
      if (@" != '')
        normal O
        normal P
      endif
    else
      if (line('.') == line('$'))
        return
      else
        normal j
      endif
    endif
  endwhile
endfunction


"ativar a linha horizontal do cursor visível;
function! CursorLinha()
  if(&cursorline == 0)
    set cursorline
  else
    set nocursorline
  endif
endfunc
noremap <silent> <Leader>l :call CursorLinha()<CR>


" setar se o buffer poderá ser alterável ou não;
function! Modfile()
  if(&modifiable == 1)
    "setar para o buffer nao poder ser modificado;
    set nomodifiable
    echo ' Buffer inalterável'
  else
    "setar para o buffer poder ser modificado;
    set modifiable
    echo ' Buffer alterável'
  endif
endfunc


"Realiza uma busca por string em todo o diretorio do projeto utilizando o git-grep (O Git deve estar instalado);
"A opção '--no-index' Se git grep é executado fora de um repositório git;
":G string
function! Grep(args)
    let grepprg_bak=&grepprg
    let g:mygrepprg="git\\ grep\\ -ni"
    let g:grepcmd="silent! grep --no-index " . a:args

    exec "set grepprg=" . g:mygrepprg
    execute g:grepcmd
    botright copen
    let &grepprg=grepprg_bak
    exec "redraw!"
endfunction

func GrepWord()
  normal! "zyiw
  call Grep(getreg('z'))
endf

"realizar uma busca da palavra sob o cursor;
nmap <C-x><C-x> :call GrepWord()<CR>
command! -nargs=1 G call Grep('<args>')


" detectar sistema operacional usado;
function! Detect_OS()
  let os = ''
  if has("unix") " Unix
    let os = 'unix'
  elseif has("win32") || has("win64") " Windowns
    let os = 'win'
  elseif has("linux") " Linux
    let os = 'linux'
  elseif has("mac") " Mac
    let os = 'mac'
  else
    let os = -1 " Unknown OS!!!!
  endif
  return os
endfunction


" executar comandos externos no terminal exibindo somente o resultado numa 
" janela inferior;
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction


"simula o comando M-x do Emacs;
function! Mx()
    let cmd = input("Inserir um comando:")
    let cmd = split(cmd)

    if len(cmd) > 0
        if cmd[0] == "beer" "<<-- string a ser comparada para executar o comando desejado;
            echo "Cheers!"
        elseif cmd[0] == "cpp" "compilar e executar arquivos C++ padrão c++11;
            :!g++ -Wall -o  %:r % -std=c++11
        elseif cmd[0] == "exe" "executar arquivo
            :!%:r
        elseif cmd[0] == "s"
            :wa
        elseif cmd[0] == "my7"
            :%s#mysql_#mysqli_#g
        elseif cmd[0] == "tree"
            :call ListTree('.')
        elseif cmd[0] == "grep"
            :call Grep(cmd[1])
        elseif cmd[0] == "all" " <-- abrir qualquer arquivo recursivamente para o buffer;
            :arg **/*.*
        elseif cmd[0] == "allf" " <-- abrir recursivamente arquivos especificos para o buffer;
            :execute 'arg **/*.' . cmd[1]
        elseif cmd[0] == "suball" " <-- faz uma substituição em todos os arquivos no buffer;
            :execute 'argdo %s#' . cmd[1] . '#' . cmd[2] . '#ge' . ' | update'
        elseif cmd[0] == "mod"
            :call Modfile()
        else
            echo " -- Não encontrado --"
        endif
    endif
endfunction
nmap <F8> :call Mx()<CR>
nmap -x :call Mx()<CR>
"==============================================================================
