;;;;;;;;;;;;;; scala settings ---  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(add-hook 'scala-mode-hook
	  '(lambda ()
	     ;; 	     (scala-mode2-feature-electric-mode)
	     (local-set-key (kbd "C-x p") 'scala-outline-popup)
	     
	     ))

(require 'sbt-mode)

(require 'popup)

;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
