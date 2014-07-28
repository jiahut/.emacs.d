;;; my-python-mode.el --- Emacs Prelude: A nice setup for Ruby (and Rails) devs.
;;
;; Copyright © 2011-2014 jiahut@gmail.com
;;
;; Author: zhijia,.zhang <jiahut@gmail.com>
;; URL: https://github.com/jiahut/.emacs.d
;; Version: 1.0.0
;; Keywords: convenience
;; This file is not part of GNU Emacs.

;;; Commentary:

;; Some basic configuration for Ruby and Rails development.

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

(require 'prelude-programming)

(prelude-require-packages '(python pymacs))
(add-hook 'python-mode-hook
          (function (lambda ()
                      (setq evil-shift-width python-indent))))

(require 'python)
(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
 "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
 "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
 "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

(add-to-list 'load-path "~/.emacs.d/personal/pyenv")

(require 'pyenv)
(if (eq system-type 'darwin)
    (progn
      (setq pyenv-executable "/usr/local/bin/pyenv")
      (global-pyenv-mode)
      (pyenv-use "py34")
    ))

(require 'pymacs)
;; Initialize Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;; Initialize Rope
;; (pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)
(setq py-load-pymacs-p nil)

(add-hook 'python-mode-hook
          (lambda()
            (global-set-key (kbd "RET") 'newline-and-indent)
            (auto-fill-mode 1)
            ))


(require 'company)
(defun load-repemacs()
  (interactive)
  (pymacs-load "ropemacs" "rope-")
  (push 'company-ropemacs company-backends)
  )

(provide 'my-python-mode)
;;; my-python-mode.el ends here
