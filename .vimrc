set cursorline                  " カーソル行をハイライトする
set laststatus=2                " ステータスバーを常に表示する
set list                        " 不可視文字を表示する
set listchars=eol:↲,tab:▸\      " 不可視文字を置き換える
set mouse=a                     " マウスでの操作を有効にする
set notitle                     " タイトルをバッファ名に変更しない
set number                      " 行番号を表示する
set pumheight=20                " ポップアップメニューの高さを20にする
set scrolloff=5                 " スクロール時にカーソルの5行下を表示する
set showcmd                     " 入力中のコマンドを表示する
set showmode                    " 現在のモードを表示する
set ruler                       " 右下に行・列の番号を表示する
set visualbell                  " ビープ音の代わりに画面を点滅させる
set wildmenu                    " コマンドラインでの補完を強化する
set wildmode=list:full          " 複数のマッチが存在する場合にリストを表示し最初のマッチを補完する
set clipboard+=unnamed          " クリップボードを共有する
set autoindent                  " 改行時に前の行のインデントを継続する
set backspace=start,eol,indent  " バックスペースで不可視文字を削除する
set expandtab                   " タブ入力を複数の空白入力に置き換える
set nobackup                    " バックアップしない
set noswapfile                  " スワップを作成しない
set nowritebackup               " バックアップを作成しない
set viminfo=                    " .viminfoを作成しない
set shiftwidth=4                " インデントの幅をスペース4つ分にする
set showmatch                   " 対応する括弧をハイライトする
set tabstop=4                   " <TAB>の見かけの幅をスペース4つ分にする
set whichwrap+=h,l,<,>,[,]      " 改行を超えて移動する
set ignorecase                  " 大文字・小文字を区別しないで検索する
set incsearch                   " インクリメンタルサーチを行う
set hlsearch                    " 検索結果をハイライトする
set smartcase                   " set ignorecaseとの併用で、検索パターンに大文字が含まれている場合は、大文字・小文字を区別して検索する
syntax enable

if isdirectory(expand('~/.vim/bundle/Vundle.vim'))
    set runtimepath+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'itchyny/lightline.vim'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'Shougo/neocomplcache.vim'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'nanotech/jellybeans.vim'
    call vundle#end()
    filetype plugin indent on

    let g:neocomplcache_enable_at_startup=1
    let g:neocomplcache_enable_smart_case=1
    imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

    let g:indent_guides_enable_on_vim_startup=1
    let g:indent_guides_start_level=1
    let g:indent_guides_guide_size=1

    let g:jellybeans_overrides = {
    \ 'background': { 'ctermbg': 'none', '256ctermbg': 'none' }
    \ }
    colorscheme jellybeans
endif
