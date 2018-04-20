source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" formas de inserir arquivo no .vimrc;
" source $VIM/codigo.vim
" source $HOME/codigo.vim
" source $VIMRUNTIME/codigo.vim
"source $VIM/EasyMotion.vim

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
map <F5> 10k

"desce N linhas;
map <F6> 10j

"saltar para a linha N teclando ENTER;
map <CR> gg

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

"abrir lista de arquivos recentemente abertos;
"(Aberta a lista, pressione 'ESC' ou 'q' para cancelar o '-- More --' e digitar o número do arquivo a ser aberto da lista);
map <Leader>r :browse oldfiles<CR>


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
    let line = getline('.')
    if line[0] == "/" && line[1] == "/"
        s/\/\///g "apaga comentário;
    else
        s/^/\/\//g "insere comentário;
    endif
endfunction
nmap <C-/> :call Inserir_e_retirar_comentario()<CR>:nohlsearch<CR>




"---------------------------------------------------------------------------------------------
