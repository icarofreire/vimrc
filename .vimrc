source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" formas de inserir arquivo no .vimrc;
" source $VIM/codigo.vim
" source $HOME/codigo.vim
" source $VIMRUNTIME/codigo.vim

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

" possibilidade de mapear a tecla 'leader' para a tecla que desejar;
"let mapleader = "-"

" fazer a mesma coisa que ':' ;
map <F4> :
nmap <space> :

" editar/recarregar o arquivo .vimrc;
cmap ev :tabnew<CR>:e $MYVIMRC<CR>
cmap sv :so $MYVIMRC<CR>:nohlsearch<CR>

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

"colar no arquivo o conteúdo da memoria do clipboard(texto copiado em outra
"área no computador);
map <M-p> "+p

"salvar automaticamente o arquivo 1/2 segundo após cada alteração(SOMENTE se o arquivo
"já existe);
set updatetime=500
:autocmd CursorHold,CursorHoldI,BufLeave * silent! :update

"ir para o proximo buffer;
nmap <TAB> :bn<CR>

"ir para o buffer anterior;
nmap <S-TAB> :bp<CR>

"refresh do visual do terminal;
nmap <S-F5> :redraw!<CR>

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
    elseif fileType == 'python'
        if line[0] == "#"
            s/^#//g "apaga comentário;
        else
            s/^/#/g "insere comentário;
        endif
    endif
endfunction
nmap <C-/> :call Inserir_e_retirar_comentario()<CR>:nohlsearch<CR>


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
call Ativar_alt_term_linux()

"==============================================================================
