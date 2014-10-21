(global-set-key [f12] 'compile)

(setq make-backup-files nil) ;no backup files 

(cua-mode t) ;remap C-c,C-v,C-x to normal


(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(rainbow-mode          ; Color color-codes #ffffff
;    rainbow-delimiters    ; Colored parens pairs
;    doctags               ; Docygen docs
;    tuareg                ; OCaml
;    arduino-mode          ; For arduino editing
;    auctex                ; LaTeX
;    auctex-latexmk        ; LatexMk for auctex
;    ag                    ; ag to replace grep
;    ac-math               ; auto complete math symbols
;    helm                  ; helm
     flycheck              ; Compile and warn on the fly
;    flycheck-color-mode-line ; Change color in mode line according to
;    flycheck-tip          ; pop-up with info about the error
;    git-gutter+           ; Show git diffs (+-)
;    git-gutter-fringe+    ; Show git diffs (+-)
;    smart-tabs-mode       ; Use tabs for indentation and spaces for
                          ; alignment
;    diff-hl               ; Highlights diffs to HEAD
;    password-store        ; Interact with the password-store
;    monokai-theme         ; the theme
;    edit-server           ; Chrome plugin
;    browse-kill-ring      ; As it name implies
;    markdown-mode         ; Markdown mode
;    whole-line-or-region  ; If no region cut/copy the line
;    ecb                   ; Code browser
    auto-complete         ; Auto completion
;    auto-complete-auctex  ; Auto completion for auctex
;    smex
;    rcirc-color           ; color usernames in rcirc
;    rcirc-notify          ; libnotify notifications from rcirc
;    cmake-mode
;    magit                 ; Git
;    ido-ubiquitous
    xclip                 ; copy paste with X
    undo-tree)            ; Visualize undo
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Turn off mouse interface early in startup to avoid momentary display
(tool-bar-mode -1)
;(scroll-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode 0)

(xterm-mouse-mode t)       ; Enable mouse in terminal

;;X11 clipboard activation
(setq x-select-enable-primary nil)
(setq x-select-enable-clipboard t)
(setq select-active-regions t)
(global-set-key [mouse-2] 'mouse-yank-primary)

(defalias 'yes-or-no-p 'y-or-n-p)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        AUTO COMPLETE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)                     ; Load the defaults
(ac-flyspell-workaround)

(ac-set-trigger-key "TAB")              ; Use TAB for autocompletion

(setq ac-auto-show-menu t               ; Auto show the selection menu
      ac-dwim t                         ; Do What I Mean
      ac-use-menu-map t                 ; Only bind M-p and M-n when menu is present
      ac-use-fuzzy t                    ; Enable fuzzy matching
      ac-fuzzy-cursor-color 'color-202  ; set color for fuzzy completion
      ac-quick-help-delay 2             ; Show quick help after 2 secs
      ac-quick-help-height 60
      ac-show-menu-immediately-on-auto-complete t ; No Delay for auto-complete
      ac-expand-on-auto-complete t)

;; Set the colors
(set-face-background 'ac-candidate-face "darkgray")
(set-face-foreground 'ac-candidate-face "black")
(set-face-background 'ac-selection-face "steelblue")
(set-face-foreground 'ac-selection-face "white")

;; Add sources for programming modes
(add-hook 'prog-mode-hook
          '(lambda ()
             (add-to-list 'ac-sources 'ac-source-filename)
             (add-to-list 'ac-sources 'ac-source-semantic)
             (add-to-list 'ac-sources 'ac-source-gtags)
             (setq-default srecode-minor-mode 1) ; enable srecode minor mode
             ))

;; Enable auto-completion globally
(global-auto-complete-mode t)
(column-number-mode 1)
