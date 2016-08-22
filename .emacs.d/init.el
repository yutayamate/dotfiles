;; 言語・文字コード
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)


;; ユーザーインターフェース
(xterm-mouse-mode t)
(mouse-wheel-mode t)
(tool-bar-mode 0)
(global-set-key [mouse-4] '(lambda () (interactive) (scroll-down 1)))
(global-set-key [mouse-5] '(lambda () (interactive) (scroll-up 1)))
(display-time)                                      ;; 現在時刻を表示する
(line-number-mode t)                                ;; カーソル位置の行番号を表示する
(column-number-mode t)                              ;; カーソル位置の列番号を表示する
(global-hl-line-mode t)                             ;; カーソル行をハイライトする
(global-linum-mode t)                               ;; 行番号を表示する
(size-indication-mode t)                            ;; ファイルサイズを表示する
(show-paren-mode t)                                 ;; 対応するかっこを光らせる
(fset 'yes-or-no-p 'y-or-n-p)                       ;; y or nで選択する
(setq x-select-enable-clipboard t)                  ;; システムのクリップボードを使用する
(set-frame-parameter nil 'fullscreen 'maximized)    ;; GUI起動時にウィンドウを最大化する
;; (set-frame-parameter nil 'alpha 75)                 ;; GUI起動時にウィンドウを透過する


(require 'whitespace)
(global-whitespace-mode 1)                                      ;; 不可視文字を表示する
(setq whitespace-style '(face trailing tabs tab-mark empty))    ;; タブ、行末スペースを表示する


;; 編集
(setq-default tab-width 4 indent-tabs-mode nil)     ;; タブの代わりにスペース4つを挿入する
(setq require-final-newline t)                      ;; 最終行に空白行を1つ挿入する
(setq kill-whole-line t)                            ;; C-kで行全体を削除する
(setq completion-ignore t)                          ;; 補完時に大文字小文字を区別しない
(setq read-file-name-completion-ignore-case t)      ;; 補完時に大文字小文字を区別しない
(setq make-backup-files nil)                        ;; バックアップファイルを作成しない
(auto-compression-mode t)                           ;; 圧縮されたファイルの編集を可能にする
(setq auto-save-default nil)                        ;; オートセーブファイルを作成しない
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)


;; 外部パッケージ管理
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(defvar my/packages '(
    auto-complete
    smartparens
    volatile-highlights
    jbeans-theme
))

(require 'cl)
(let ((not-installed-packages (loop for pkg in my/packages when (not (package-installed-p pkg)) collect pkg)))
    (when not-installed-packages
        (package-refresh-contents)
        (dolist (pkg not-installed-packages)
            (package-install pkg))))


(require 'auto-complete-config)
(ac-config-default)

(require 'smartparens-config)
(smartparens-global-mode)

(require 'volatile-highlights)
(volatile-highlights-mode)

(when (not window-system)
    (load-theme 'jbeans t)
)
