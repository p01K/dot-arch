;;; settings --- various conf settings

(cua-mode t) ;;;remap C-c,C-v,C-x to normal
(setq make-backup-files nil) ;;;no backup files 

;;disable splash screen and startup message
(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)
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
;; (global-set-key [mouse-2] 'mouse-yank-primary)

(defalias 'yes-or-no-p 'y-or-n-p)

;; Enable x-clipboard interaction
(if (fboundp 'xclip-mode) (xclip-mode 1))
;; (global-set-key (kbd "<mouse-2>") 'x-clipboard-yank)

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
;; (require 'sr-speedbar)
;; (setq speedbar-use-images nil)
;; (make-face 'speedbar-face)
;; (set-face-font 'speedbar-face "Inconsolata-12")
;; (setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;                      CHANGE MODE-LINE
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Set the modeline to tell me the filename, hostname, etc..

(require 'powerline)
(setq powerline-arrow-shape 'curve)
(powerline-default-theme)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                                         THEME IT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (display-graphic-p)
    (progn
      ;; if graphic
      (load-theme 'solarized-dark  t))
  ;; else (optional)
  (load-theme 'monokai t)
  )
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
