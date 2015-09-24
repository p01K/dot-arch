(require 'pdf-tools)
(pdf-tools-install)

(eval-after-load "preview"
  (lambda ()
    '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t)
    '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{itemize}" t)
    '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{enumerate}" t)
    )
  )

;; Add LaTeXmk support
(auctex-latexmk-setup)
;(setq TeX-command-default "LaTeXmk"
;; (add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`
;; (setq ac-sources
;;       (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
;;               ac-sources))

;;(setq TeX-master (guess-TeX-master))
(setq LaTeX-verbatim-environments-local '("Verbatim" "lstlisting" "comment"))
(TeX-fold-mode 1)           ; Hide macros
;; (add-to-list 'TeX-view-program-list
;;              '("Evince" "evince --page-index=%(outpage) %o"))
(setq TeX-auto-save t     ; Auto-save
      TeX-save-query nil  ; When saving document don't ask
      TeX-parse-self t    ; Support included files
      TeX-PDF-mode t      ; Compile to PDF
      TeX-engine 'xetex   ; Use xetex
      TeX-command-extra-options "-halt-on-error"
      ;; Indent on line feed
      TeX-newline-function 'reindent-then-newline-and-indent
      ;; Reftex integration to AUCTeX
      reftex-plug-into-AUCTeX t
      ;; Use PDF tools
      TeX-view-program-selection '((output-pdf "PDF Tools"))
      ;; Fix no new-line in itemize env
      comment-auto-fill-only-comments nil
      ;; preview settings
      preview-image-type 'dvipng
      preview-auto-cache-preamble t
      preview-default-document-pt 12
      preview-scale-function 1.2
      TeX-source-correlate-method 'synctex
      ;; must be t for inverse search
      TeX-source-correlate-start-server t
      ;; Ask for the type (Section, Subsection etc.)
      LaTeX-section-hook '(LaTeX-section-heading
                           ;; Ask for the title
                           LaTeX-section-title
                           ;; ask for the title in TOC
                           LaTeX-section-toc
                           ;; Insert the section
                           LaTeX-section-section
                           ;; Ask for the label to use
                           LaTeX-section-label)
      pdf-view-resize-factor 1.10)

(add-hook 'LaTeX-mode 'turn-on-reftex)
(add-hook 'latex-mode 'turn-on-reftex)
(add-hook 'TeX-mode 'turn-on-reftex)
(add-hook 'tex-mode 'turn-on-reftex)

(add-hook 'pdf-view-mode-hook 'auto-revert-mode)
(TeX-source-correlate-mode)

(require 'server)
(unless (server-running-p) (server-start))

;; (setq TeX-view-program-list '(("PDF Tools" "mupdf  %o")))
;; (setq TeX-view-program-list '(quote (("Preview" "\"open -a Preview.app %o\""))))
;; (setq TeX-view-program-selection '((output-pdf "Preview")))
;;; latex-conf.el ends here
;; (setq TeX-view-program-list '(("Mupdf" "mupdf  %o")))
;; (setq TeX-view-program-selection '((output-pdf "Mupdf")))
;; (setq TeX-command-extra-options "-synctex=1")
;; (setq         TeX-source-correlate-method 'synctexd
	      ;; TeX-source-correlate-start-server 
