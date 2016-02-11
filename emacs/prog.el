(defun align-to-equals (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
		(rx (group (zero-or-more (syntax whitespace))) "=") 1 1 ))

(defun align-to-dot (begin end)
  "Align region to colon (:) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ".") 1 1 ))

;; (defun align-to-equals (begin end)
;;   "Align region to equal signs"
;;   (interactive "r")
;;   (align-regexp begin end "\\(\\s-*\\)=" 1 1 ))
