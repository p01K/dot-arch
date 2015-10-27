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
    smex
;    rcirc-color           ; color usernames in rcirc
;    rcirc-notify          ; libnotify notifications from rcirc
;    cmake-mode
    magit                 ; Git
    ido-ubiquitous
    pdf-tools
    powerline
    ;    dired-subtree
    dired-toggle
;    dired-k
    dired-rainbow
    speedbar
    sr-speedbar
    professional-theme
    nav
    sbt-mode  ; sbt mode
    julia-mode
    scala-mode2  ; scala mode
    ;; scala-outline-popup
    ensime
    ruby-mode   ; ruby
;    ruby-tools-mode  ; ruby
    xclip                 ; copy paste with X
 ;   dirtree               ; directory view 
    undo-tree
    julia-mode
    scala-outline-popup
    ;; ensime
)            ; Visualize undo
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
