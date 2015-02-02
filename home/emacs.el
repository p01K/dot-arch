;;; CONFIGURATION
(cua-mode t) ;;;remap C-c,C-v,C-x to normal
(setq make-backup-files nil) ;;;no backup files 

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
    flycheck-color-mode-line ; Change color in mode line according to
    flycheck-tip          ; pop-up with info about the error
;    git-gutter+           ; Show git diffs (+-)
;    git-gutter-fringe+    ; Show git diffs (+-)
;    smart-tabs-mode       ; Use tabs for indentation and spaces for
                          ; alignment
;    diff-hl               ; Highlights diffs to HEAD
;    password-store        ; Interact with the password-store
    monokai-theme         ; the theme
    solarized-theme
;   color-theme-molokai
 ;   color-theme-github
;    tango-theme
;    edit-server           ; Chrome plugin
;    browse-kill-ring      ; As it name implies
    markdown-mode         ; Markdown mode
    whole-line-or-region  ; If no region cut/copy the line
;    ecb                   ; Code browser
    auto-complete         ; Auto completion
    auto-complete-auctex  ; Auto completion for auctex
;    smex
;    rcirc-color           ; color usernames in rcirc
;    rcirc-notify          ; libnotify notifications from rcirc
;    cmake-mode
    magit                 ; Git
    ido-ubiquitous
;    dired-subtree
    dired-toggle
;    dired-k
    dired-rainbow
    speedbar
    sr-speedbar
    nav
    sbt-mode  ; sbt mode
    scala-mode2  ; scala mode
    ensime
    ruby-mode   ; ruby
;    ruby-tools-mode  ; ruby
    xclip                 ; copy paste with X
 ;   dirtree               ; directory view 
 ;  undo-tree
)            ; Visualize undo
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                          SETTINGS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Turn off mouse interface early in startup to avoid momentary display
(if (functionp 'tool-bar-mode) (tool-bar-mode -1))
(menu-bar-mode -1)
;;(setq scroll-step 1)

;; (xterm-mouse-mode t)       ; Enable mouse in terminal

;(add-hook 'after-make-frame-functions
;  (lambda (my_frame)
(when (display-graphic-p)
  ;; Font size
  (define-key global-map (kbd "C-+") 'text-scale-increase)
  (define-key global-map (kbd "C--") 'text-scale-decrease)
  ;;
  (set-frame-size (selected-frame) 90 50)
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (set-default-font "Inconsolata-12")
  )

;; Enable set-goal-column
(put 'set-goal-column 'disabled nil)


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

;; Enable ansi coloring
(require 'ansi-color)
;; enable ansi colors in shell-mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; enable ansi colors in compile-mode
(defun colorize-compilation-buffer ()
  (when (eq major-mode 'compilation-mode)
    (ansi-color-apply-on-region compilation-filter-start (point-max))))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; ;(require 'browse-kill-ring)
;; ;(browse-kill-ring-default-keybindings)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           SPEEDBARBAR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'sr-speedbar)
(setq speedbar-use-images nil)
(make-face 'speedbar-face)
(set-face-font 'speedbar-face "Inconsolata-12")
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))


;; (speedbar-change-initial-expansion-list "buffers")
;; (global-set-key  [f3] 'speedbar-get-focus)

;; (require 'tabbar)
;; ; turn on the tabbar
;; (tabbar-mode t)
;; ; define all tabs to be one of 3 possible groups: “Emacs Buffer”, “Dired”,
;; ;“User Buffer”.

;; (defun tabbar-buffer-groups ()
;;   "Return the list of group names the current buffer belongs to.
;; This function is a custom function for tabbar-mode's tabbar-buffer-groups.
;; This function group all buffers into 3 groups:
;; Those Dired, those user buffer, and those emacs buffer.
;; Emacs buffer are those starting with “*”."
;;   (list
;;    (cond
;;     ((string-equal "*" (substring (buffer-name) 0 1))
;;      "Emacs Buffer"
;;      )
;;     ((eq major-mode 'dired-mode)
;;      "Dired"
;;      )
;;     (t
;;      "User Buffer"
;;      )
;;     ))) 

;; (setq tabbar-buffer-groups-function 'tabbar-buffer-groups)

;; (global-set-key [M-s-left] 'tabbar-backward)
;; (global-set-key [M-s-right] 'tabbar-forward)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;                      CHANGE MODE-LINE
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Set the modeline to tell me the filename, hostname, etc..
(setq-default
 mode-line-format
 (list
  "%@"
  ; the name of the buffer (i.e. filename)
  ; note this gets automatically highlighted
  'mode-line-buffer-identification
  " "
  ; */% indicators if the file has been modified
  ;'mode-line-mule-info
  ;'mode-line-modified
  "["
  ;; insert vs overwrite mode, input-method in a tooltip
  '(:eval (propertize
           (if overwrite-mode "Ovr" "Ins")
           'face 'font-lock-preprocessor-face
           'help-echo (concat "Buffer is in "
                              (if overwrite-mode "overwrite" "insert") " mode")))
  ;; was this buffer modified since the last save?
  '(:eval (when (buffer-modified-p)
            (concat ","  (propertize "Mod"
                                     'face 'font-lock-warning-face
                                     'help-echo "Buffer has been modified"))))

  ;; is this buffer read-only?
  '(:eval (when buffer-read-only
            (concat ","  (propertize "RO"
                                     'face 'font-lock-type-face
                                     'help-echo "Buffer is read-only"))))
  "] "
  ; line, column, file %
  'mode-line-position
  ; time ++
  ;'global-mode-string
  ;; add the time, with the date and the emacs uptime in the tooltip
  '(:eval (propertize (format-time-string "%H:%M")
                      'face 'bold
                      'help-echo
                      (concat (format-time-string "%c; ")
                              (emacs-uptime "Uptime:%hh"))))
  ;; check for mails
  '(:eval (if (/= new-mail 0)
              (concat " " (propertize (concat (number-to-string new-mail)
                                              " mail(s)")
                                      'face 'font-lock-warning-face
                                      'help-echo "You 've got mail"))))
  (display-time-mode 1)
  " "
  ; if vc-mode is in effect, display version control
  ; info here
  `vc-mode
  ; hostname
  ;        'system-name
  ; major and minor modes in effect
  'mode-line-modes
  ; if which-func-mode is in effect, display which
  ; function we are currently in.
  '(which-func-mode ("" which-func-format "--"))
  ; dashes sufficient to fill rest of modeline.
  ;        "-%-"
  )
 )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                                         THEME IT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load-theme 'monokai  t) ; set theme
;; (require 'solarized-theme)
;; (load-theme 'solarized-dark  t) ; set theme
;; make the fringe stand out from the background
;; (setq solarized-distinct-fringe-background t)

;; make the modeline high contrast
;; (setq solarized-high-contrast-mode-line t)

;; Use less bolding
;; (setq solarized-use-less-bold t)

;; Use more italics
;; (setq solarized-use-more-italic t)

;; (setq solarized-termcolors 256)
;; (setq solarized-visibility high)
;; Use less colors for indicators such as git:gutter, flycheck and similar.
;; (setq solarized-emphasize-indicators nil)

;; Don't change size of org-mode headlines (but keep other size-changes)
;; (setq solarized-scale-org-headlines nil)

;; (setq x-underline-at-descent-line t)

;; make background transparent
;; (let ((class '((class color) (min-colors 89))))
;;    (custom-theme-set-faces
;;    'solarized-dark
;;    ;   'tango-dark
;;    ;; Ensure sufficient contrast on 256-color xterms.
;;    ;;`(mode-line ((,class (:background "#002B36" ))))
;;    ;; make it transparent
;;    ;`(default ((,class (:background nil))))
;;    `(default ((,class (:background "#073642"))))
;;    ;;  `(mode-line-inactive
;;    ;;    ((,class (:background "#575757" :foreground "#eeeeec"))))
;; ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                          IDO SETUP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use ido
(ido-mode t)
(ido-ubiquitous t) ; IDO in even more places
(setq
 ido-enable-prefix nil
 ido-enable-flex-maatching t
 ido-auto-merge-work-directories-length nil
 ido-create-new-buffer 'always
 ido-use-filename-at-point 'guess
 ido-use-virtual-buffers t
 ido-handle-duplicate-virtual-buffers 2
 ido-max-prospects 10
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                    HIGHLIGHT NASTY THINGS
;;;;(Trailing spaces, text past 80 characters, tabs, empty lines)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'whitespace)
(setq-default
 whitespace-style '(face
;                    spaces
                    tabs
                    empty
                    lines-tail
                    trailing
                    tab-mark
                    )
 whitespace-line-column 110
 whitespace-display-mappings
 '(
   (space-mark ?\ [?\u00B7] [?.])         ; space - centered dot
   (space-mark ?\xA0 [?\u00A4] [?_])      ; hard space - currency
   (newline-mark ?\n [?$ ?\n])            ; eol - dollar sign
   (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t]) ; tab - left quote mark
   )
 )
(global-whitespace-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                     Rainbow Delimiters
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'text-mode-hook 'rainbow-delimiters-mode)
;; (add-hook 'LaTeX-mode-hook 'rainbow-delimiters-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                      SMARTPARENS CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'smartparens-config)      ; Init smartparens
;(sp-use-smartparens-bindings)     ; use the default bindings
;; (global-set-key (kbd "C-M-f") 'sp-forward-sexp)
;; (global-set-key (kbd "C-M-b") 'sp-backward-sexp)
;; (global-set-key (kbd "C-M-d") 'sp-down-sexp)
;; (global-set-key (kbd "C-M-a") 'sp-backward-down-sexp)
;; (global-set-key (kbd "C-S-a") 'sp-beginning-of-sexp)
;; (global-set-key (kbd "C-S-d") 'sp-end-of-sexp)
;; (global-set-key (kbd "C-M-n") 'sp-up-sexp)
;; (global-set-key (kbd "C-M-p") 'sp-backward-sexp)
;; (global-set-key (kbd "C-M-k") 'sp-kill-sexp)
;; (global-set-key (kbd "C-M-w") 'sp-copy-sexp)
;; (smartparens-global-mode 1)        ; Enable smartparens
;; (show-smartparens-global-mode t)   ; Highlight matching pairs

;; other parens settings NOT from smartparens
;; (electric-pair-mode 1)            ; Autoclose Brackets/Braces
(show-paren-mode t)               ; Highlight matching parenthesis


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        AUTO COMPLETE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
	     (local-set-key (kbd "C-d") 'comment-or-uncomment-region-or-line)
	     (local-set-key (kbd "C-D") 'comment-or-uncomment-region-or-line)
             ))

;; Enable auto-completion globally
(global-auto-complete-mode t)
(column-number-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        FLYCHECKING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'prog-mode-hook 'flycheck-mode)
(setq flycheck-check-syntax-automatically '(save))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        COLORIZE DIFFS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add some color in your diff-mode
(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green")
     (set-face-foreground 'diff-removed "red")))

;; Add some color in your magit-diff-mode
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green")
     (set-face-foreground 'magit-diff-del "red")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 KEYBINDINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
;;(global-set-key (kbd "C-f") 'isearch-forward-regexp)
;;(global-set-key (kbd "C-r") 'isearch-backward-regexp)

;; alt-d kill word
(global-set-key (kbd "<M-delete>") 'kill-word)
(global-set-key (kbd "<M-backspace>") 'backward-kill-word)

(global-set-key [f1] 'nav)
(global-set-key [f2] 'ibuffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                          BUFFERS/WINDOW SWITCHING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

(defun next-user-buffer ()
  "Switch to the next user buffer.
 (buffer name does not start with “*”.)"
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-equal "*" (substring (buffer-name) 0 1)) (< i 20))
      (setq i (1+ i)) (next-buffer))))

(defun previous-user-buffer ()
  "Switch to the previous user buffer.
 (buffer name does not start with “*”.)"
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-equal "*" (substring (buffer-name) 0 1)) (< i 20))
      (setq i (1+ i)) (previous-buffer))))

(global-set-key (kbd "M-<right>") 'next-user-buffer )
(global-set-key (kbd "M-<left>") 'previous-user-buffer )
(global-set-key (kbd "C-f") 'switch-to-buffer)

(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)

(global-set-key (kbd "M-i") 'previous-line)
(global-set-key (kbd "M-j") 'backward-char)
(global-set-key (kbd "M-k") 'next-line)
(global-set-key (kbd "M-l") 'forward-char)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                      ADD MARKDOWN MODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'markdown-mode-hook
          '(lambda() (progn
                       (setq-default markdown-content-type 'text/html)
                       (setq-default markdown-coding-system 'utf-8)
                       )))
;; ;; Trailing whitespace is significant in Markdown, so don't mess with it
(defadvice delete-trailing-whitespace (around disable-in-markdown activate)
  (unless (eq major-mode 'markdown-mode)
    ad-do-it))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                        MOUSE/SCROLLING FIX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun up-one () (interactive) (scroll-up 1))
(defun down-one () (interactive) (scroll-down 1))
(global-set-key (kbd "<mouse-4>") 'down-one)
(global-set-key (kbd "<mouse-5>") 'up-one)
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))
(setq mouse-sel-mode t)
(when (require 'mwheel nil 'noerror)
  (mouse-wheel-mode 1))
(blink-cursor-mode 0)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                            LaTeX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-hook 'LaTeX-mode-hook
;; 	  (lambda ()
;; 					; Find which file is the main, for use with multiple tex files
;; 	    (defun guess-TeX-master (filename)
;; 	      "Guess the master file for FILENAME from currently open .tex files."
;; 	      (let ((candidate nil)
;; 		    (filename (file-name-nondirectory filename)))
;; 		(save-excursion
;; 		  (dolist (buffer (buffer-list))
;; 		    (with-current-buffer buffer
;; 		      (let ((name (buffer-name))
;; 			    (file buffer-file-name))
;; 			(if (and file (string-match "\\.tex$" file))
;; 			    (progn
;; 			      (goto-char (point-min))
;; 			      (if (re-search-forward (concat "\\\\input{" filename "}") nil t)
;; 				  (setq candidate file))
;; 			      (if (re-search-forward (concat "\\\\input{" (file-name-sans-extension filename) "}") nil t)
;; 				  (setq candidate file))
;; 			      (if (re-search-forward (concat "\\\\include{" (file-name-sans-extension filename) "}") nil t)
;; 				  (setq candidate file))))))))
;; 		(if candidate
;; 		    (message "TeX master document: %s" (file-name-nondirectory candidate)))
;; 		candidate))
;; 					; Add LaTeXmk support
;; 	    (require 'auctex-latexmk)
;; 	    (auctex-latexmk-setup)
;; 					; Add autocompletion
;; 	    (require 'auto-complete-auctex)
;; 					; Add math auto completion
;; 					;(require 'ac-math)
;; 	    ;; (add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`
;; 	    ;; (setq ac-sources
;; 	    ;;       (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
;; 	    ;;               ac-sources))

;; 	    (setq TeX-master (guess-TeX-master (buffer-file-name)))
;; 	    (setq LaTeX-verbatim-environments-local '("Verbatim" "lstlisting"))
;; 	    (turn-on-reftex)
;; 	    (turn-on-auto-fill)
;; 	    (TeX-fold-mode 1)           ; Hide macros
;; 					; Add LaTeXmk support
;; 	    ;; (add-to-list 'TeX-command-list
;; 	    ;;              '("LaTeXmk" "latexmk -pdf %s" TeX-run-TeX nil t
;; 	    ;;                :help "Run Latexmk on file") t)
;; 	    (defcustom zathura-viewer "zathura --fork -s -x \"emacsclient --eval '(progn (switch-to-buffer  (file-name-nondirectory \"'\"'\"%{input}\"'\"'\")) (goto-line %{line}))'\""
;; 	                    "PDF Viewer for TeX documents. You may want to fork the viewer
;;             so that it detects when the same document is launched twice, and
;;             persists when Emacs gets closed.

;;             Simple command:

;;               zathura --fork

;;             We can use

;;               emacsclient --eval '(progn (switch-to-buffer  (file-name-nondirectory \"%{input}\")) (goto-line %{line}))'

;;             to reverse-search a pdf using SyncTeX. Note that the quotes and double-quotes matter and must be escaped appropriately."
;; 			    :safe 'stringp)
;; 	    (add-to-list 'TeX-view-program-list
;; 			 '("Zathura" zathura-viewer))
;; 	    (add-to-list 'TeX-view-program-list
;; 			 '("Evince" "evince --page-index=%(outpage) %o"))
;; 	    ;;(setq TeX-command-default "LaTeXmk"
;; 	    (setq TeX-auto-save t     ; Auto-save
;; 		  TeX-save-query nil  ; When saving document don't ask
;; 		  TeX-parse-self t    ; Support included files
;; 		  TeX-PDF-mode t      ; Compile to PDF
;; 					; Indent on line feed
;; 		  TeX-newline-function 'reindent-then-newline-and-indent
;; 					; Reftex integration to AUCTeX
;; 		  reftex-plug-into-AUCTeX t
;; 					; Ask for the type (Section, Subsection etc.)  Use
;; 					; Evince
;; 		  TeX-view-program-selection '((output-pdf "Evince"))
;; 		  TeX-source-correlate-method 'synctex
;; 					; must be t for inverse search
;; 		  TeX-source-correlate-start-server t
;; 		  LaTeX-section-hook '(LaTeX-section-heading
;; 					; Ask for the title
;; 				       LaTeX-section-title
;; 					; ask for the title in TOC
;; 				       LaTeX-section-toc
;; 					; Insert the section
;; 				       LaTeX-section-section
;; 					; Ask for the label to use
;; 				       LaTeX-section-label))
;; 	    (TeX-source-correlate-mode)
;; 	    (unless (server-running-p)
;; 	      (server-start))
;; 	                ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; handle tmux's xterm-keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
