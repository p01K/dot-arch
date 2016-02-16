;;;;;;;;;;;;;; scala settings ---  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'yasnippet)

;; (define-key yas-minor-mode-map (kbd "<C-tab>")  'yas-ido-expand)
;; (add-hook 'scala-mode-hook
;;           '(lambda ()
;;              (yas/minor-mode-on)));


(add-hook 'scala-mode-hook
	  '(lambda ()
	     ;; 	     (scala-mode2-feature-electric-mode)
	     (local-set-key (kbd "C-x p") 'scala-outline-popup)
	     ))

(require 'sbt-mode)

(require 'popup)

(scala-mode:goto-start-of-code)
;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
