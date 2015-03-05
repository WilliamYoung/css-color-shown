;;; css-color-shown.el --- show CSS color in GNU Emacs

;; Copyright (C) 2015 -- William Young


;; Author: William Young
;; URL: http://github.com/williamyoung/css-color-shown
;; Created: Mar 3, 2015
;; Keywords: languages elisp, css
;; Version: 0.0.1

;; This file is not part of GNU Emacs.

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 2 of the License, or
;; (at your option) any later version.

;; It is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.

;; You should have received a copy of the GNU General Public License
;; along with it.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;; Most of the features are collected from the internet. They could be 
;;; used to show css color directly in Emacs.
;;; e.g.
;;; (require 'css-color-shown)
;;; (add-hook 'css-mode-hook 'xah-syntax-color-hex)
;;; (add-hook 'html-mode-hook 'xah-syntax-color-hex)
;;; (add-hook 'php-mode-hook 'xah-syntax-color-hsl)

;;;;;colored hex color spec.
(defun xah-syntax-color-hex ()
"Syntax color hex color spec such as 「#ff1100」 in current buffer."
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[abcdef[:digit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-fontify-buffer)
  )



;;;;;color CSS HSL syntax
(defun xah-syntax-color-hsl ()
  "Syntax color hex color spec such as 「hsl(0,90%,41%)」 in current buffer."
  (interactive)
  (font-lock-add-keywords
   nil
  '(("hsl( *\\([0-9]\\{1,3\\}\\) *, *\\([0-9]\\{1,3\\}\\)% *, *\\([0-9]\\{1,3\\}\\)% *)"
     (0 (put-text-property
         (+ (match-beginning 0) 3)
         (match-end 0)
         'face (list :background
 (concat "#" (mapconcat 'identity
                        (mapcar
                         (lambda (x) (format "%02x" (round (* x 255))))
                         (color-hsl-to-rgb
                          (/ (string-to-number (match-string-no-properties 1)) 360.0)
                          (/ (string-to-number (match-string-no-properties 2)) 100.0)
                          (/ (string-to-number (match-string-no-properties 3)) 100.0)
                          ) )
                        "" )) ;  "#00aa00"
                      ))))) )
  (font-lock-fontify-buffer)
  )



  ;;;;;;insert a random CSS color
(defun insert-random-color-hsl ()
  "Insert a random color string of CSS HSL format.
Example output: hsl(100,24%,82%)"
  (interactive)
  (insert (format "hsl(%d,%d%%,%d%%)" (random 360) (random 100) (random 100))) )



(provide 'css-color-shown)


