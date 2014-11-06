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
    rainbow-delimiters    ; Colored parens pairs
;    doctags               ; Docygen docs
;    tuareg                ; OCaml
;    arduino-mode          ; For arduino editing
    auctex                ; LaTeX
    auctex-latexmk        ; LatexMk for auctex
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
    auto-complete-auctex  ; Auto completion for auctex
;    smex
;    rcirc-color           ; color usernames in rcirc
;    rcirc-notify          ; libnotify notifications from rcirc
;    cmake-mode
;    magit                 ; Git
;    ido-ubiquitous
    dired-subtree
    dired-toggle
    dired-k
    dired-rainbow
    nav
    sbt-mode  ; sbt mode
    scala-mode2  ; scala mode
    ruby-mode   ; ruby
 ;   ruby-tools-mode  ; ruby
    xclip                 ; copy paste with X
    dirtree               ; directory view 
    undo-tree)            ; Visualize undo
    
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Turn off mouse interface early in startup to avoid momentary display
(if (functionp 'tool-bar-mode) (tool-bar-mode -1))
(menu-bar-mode -1)
;;(setq scroll-step 1)
(when (require 'mwheel nil 'noerror)
  (mouse-wheel-mode 1))
(blink-cursor-mode 0)

(xterm-mouse-mode t)       ; Enable mouse in terminal

;;X11 clipboard activation
(setq x-select-enable-primary nil)
(setq x-select-enable-clipboard t)
(setq select-active-regions t)
(global-set-key [mouse-2] 'mouse-yank-primary)

(defalias 'yes-or-no-p 'y-or-n-p)

;; Enable x-clipboard interaction
(if (fboundp 'xclip-mode) (xclip-mode 1))

(require 'linum)
(global-linum-mode 1) ; Enable linenumbers on left margin


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

;;(defun terminal-init-gnome ()
;;  "Terminal initialization function for gnome-terminal."
;;  (tty-run-terminal-initialization (selected-frame) "xterm"))

;; Enable auto-completion globally
(global-auto-complete-mode t)
(column-number-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        FLYCHECKING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'prog-mode-hook 'flycheck-mode)
(setq flycheck-check-syntax-automatically '(save))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 KEYBINDINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; emacs comment shortcut
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
	(setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

(global-set-key (kbd "C-d") 'comment-region)
(global-set-key (kbd "C-D") 'comment-or-uncomment-region-or-line)

;; Use regex searches by default.
(global-set-key (kbd "C-f") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

;; alt-d kill word
(global-set-key (kbd "<M-delete>") 'kill-word)
(global-set-key (kbd "<M-backspace>") 'backward-kill-word)

(global-set-key [f1] 'nav)
(global-set-key [f2] 'ibuffer)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; handle tmux's xterm-keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   setw -g xterm-keys on
(if (getenv "TMUX")
    (progn
      (let ((x 2) (tkey ""))
    (while (<= x 8)
      ;; shift
      (if (= x 2)
          (setq tkey "S-"))
      ;; alt
      (if (= x 3)
          (setq tkey "M-"))
      ;; alt + shift
      (if (= x 4)
          (setq tkey "M-S-"))
      ;; ctrl
      (if (= x 5)
          (setq tkey "C-"))
      ;; ctrl + shift
      (if (= x 6)
          (setq tkey "C-S-"))
      ;; ctrl + alt
      (if (= x 7)
          (setq tkey "C-M-"))
      ;; ctrl + alt + shift
      (if (= x 8)
          (setq tkey "C-M-S-"))

      ;; arrows
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d A" x)) (kbd (format "%s<up>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d B" x)) (kbd (format "%s<down>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d C" x)) (kbd (format "%s<right>" tkey)))
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d D" x)) (kbd (format "%s<left>" tkey)))
      ;; home
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d H" x)) (kbd (format "%s<home>" tkey)))
      ;; end
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d F" x)) (kbd (format "%s<end>" tkey)))
      ;; page up
      (define-key key-translation-map (kbd (format "M-[ 5 ; %d ~" x)) (kbd (format "%s<prior>" tkey)))
      ;; page down
      (define-key key-translation-map (kbd (format "M-[ 6 ; %d ~" x)) (kbd (format "%s<next>" tkey)))
      ;; insert
      (define-key key-translation-map (kbd (format "M-[ 2 ; %d ~" x)) (kbd (format "%s<delete>" tkey)))
      ;; delete
      (define-key key-translation-map (kbd (format "M-[ 3 ; %d ~" x)) (kbd (format "%s<delete>" tkey)))
      ;; f1
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d P" x)) (kbd (format "%s<f1>" tkey)))
      ;; f2
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d Q" x)) (kbd (format "%s<f2>" tkey)))
      ;; f3
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d R" x)) (kbd (format "%s<f3>" tkey)))
      ;; f4
      (define-key key-translation-map (kbd (format "M-[ 1 ; %d S" x)) (kbd (format "%s<f4>" tkey)))
      ;; f5
      (define-key key-translation-map (kbd (format "M-[ 15 ; %d ~" x)) (kbd (format "%s<f5>" tkey)))
      ;; f6
      (define-key key-translation-map (kbd (format "M-[ 17 ; %d ~" x)) (kbd (format "%s<f6>" tkey)))
      ;; f7
      (define-key key-translation-map (kbd (format "M-[ 18 ; %d ~" x)) (kbd (format "%s<f7>" tkey)))
      ;; f8
      (define-key key-translation-map (kbd (format "M-[ 19 ; %d ~" x)) (kbd (format "%s<f8>" tkey)))
      ;; f9
      (define-key key-translation-map (kbd (format "M-[ 20 ; %d ~" x)) (kbd (format "%s<f9>" tkey)))
      ;; f10
      (define-key key-translation-map (kbd (format "M-[ 21 ; %d ~" x)) (kbd (format "%s<f10>" tkey)))
      ;; f11
      (define-key key-translation-map (kbd (format "M-[ 23 ; %d ~" x)) (kbd (format "%s<f11>" tkey)))
      ;; f12
      (define-key key-translation-map (kbd (format "M-[ 24 ; %d ~" x)) (kbd (format "%s<f12>" tkey)))
      ;; f13
      (define-key key-translation-map (kbd (format "M-[ 25 ; %d ~" x)) (kbd (format "%s<f13>" tkey)))
      ;; f14
      (define-key key-translation-map (kbd (format "M-[ 26 ; %d ~" x)) (kbd (format "%s<f14>" tkey)))
      ;; f15
      (define-key key-translation-map (kbd (format "M-[ 28 ; %d ~" x)) (kbd (format "%s<f15>" tkey)))
      ;; f16
      (define-key key-translation-map (kbd (format "M-[ 29 ; %d ~" x)) (kbd (format "%s<f16>" tkey)))
      ;; f17
      (define-key key-translation-map (kbd (format "M-[ 31 ; %d ~" x)) (kbd (format "%s<f17>" tkey)))
      ;; f18
      (define-key key-translation-map (kbd (format "M-[ 32 ; %d ~" x)) (kbd (format "%s<f18>" tkey)))
      ;; f19
      (define-key key-translation-map (kbd (format "M-[ 33 ; %d ~" x)) (kbd (format "%s<f19>" tkey)))
      ;; f20
      (define-key key-translation-map (kbd (format "M-[ 34 ; %d ~" x)) (kbd (format "%s<f20>" tkey)))

      (setq x (+ x 1))
      ))
      )
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
