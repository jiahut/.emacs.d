;;; my-coffee-mode.el --- Emacs Prelude: A nice setup for Ruby (and Rails) devs.
;;
;; Copyright © 2011-2014 jiahut@gmail.com
;;
;; Author: zhijia,.zhang <jiahut@gmail.com>
;; URL: https://github.com/jiahut/.emacs.d
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Some basic configuration for javascript development.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(prelude-require-packages '(coffee-mode js3-mode jade-mode stylus-mode json-mode nodejs-repl))
(require 'prelude-programming)
(require 'coffee-mode)

(require 'nodejs-repl)

(require 'js3-mode)
(defun send-region-to-nodejs-repl(start end)
    "Send region to `nodejs-repl' process."
    (interactive "r")
    (save-selected-window
    (save-excursion (nodejs-repl)))
    (comint-send-region (get-process nodejs-repl-process-name)
                      start end))


;; (require 'flymake-jshint)
;; (add-hook 'js3-mode-hook 'flymake-jshint-load)

(eval-after-load 'js3-mode
  '(progn
     (defun prelude-js-mode-defaults ()
       )

     (setq prelude-js-mode-hook 'prelude-js-mode-defaults)

     (define-key js3-mode-map (kbd "C-x C-e") 'send-region-to-nodejs-repl)

     (add-hook 'js-mode-hook (lambda () (run-hooks 'prelude-js-mode-hook)))))

;; (require 'flymake-coffee)
;; (add-hook 'coffee-mode-hook 'flymake-coffee-load)
;; (remove-hook 'coffee-mode-hook 'flymake-coffee-load)

;; (defvar coffee-mode-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "C-x C-e") 'coffee-compile-buffer)
;;     map)
;;   "Keymap used in Coffee mode.")
(defvar coffee-mode-map(make-keymap)
  "Keymap for Coffee major mode")

(define-key coffee-mode-map (kbd "C-x C-e") 'coffee-compile-buffer)

(add-hook 'coffee-mode-hook
          (function (lambda ()
                      (setq evil-shift-width 2))))

;;; avoid lambda in hook
(defun add-q-key-for-quit-compiled()
  (interactive)
  ;; (message (buffer-name))
  (if (equal "*coffee-compiled*" (buffer-name))
      (progn
        (message (buffer-name))
        (define-key evil-normal-state-map "q" nil)
        (define-key js3-mode-map (kbd "q") 'delete-window)
        ))
  )

(remove-hook 'prelude-coffee-mode-hook 'prelude-coffee-mode-defaults)
;;; (add-hook 'prelude-coffee-mode-hook 'prelude-coffee-mode-defaults)

(add-hook 'js3-mode-hook 'add-q-key-for-quit-compiled)
;;; (remove-hook 'js3-mode-hook 'add-q-key-for-quit-compiled)

(provide 'my-coffee-mode)
;;; my-coffee-mode.el ends here
