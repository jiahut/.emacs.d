;;; my-ruby-mode.el --- Emacs Prelude: A nice setup for Ruby (and Rails) devs.
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
(prelude-require-packages '(ruby-tools inf-ruby yari
                                       projectile-rails rvm robe
                                       enh-ruby-mode smartparens highlight-indentation))

;; Rake files are ruby, too, as are gemspecs, rackup files, and gemfiles.
(add-to-list 'auto-mode-alist '("\\.rake\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rabl\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Thorfile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Podfile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.podspec\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Puppetfile\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Berksfile\\'" . enh-ruby-mode))

;; We never want to edit Rubinius bytecode
(add-to-list 'completion-ignored-extensions ".rbc")

(define-key 'help-command (kbd "R") 'yari)


;; (require 'flymake-ruby)
(require 'enh-ruby-mode)
(require 'projectile-rails)
(require 'robe)
(require 'company)

(push 'company-robe company-backends)

;; https://gist.github.com/gnufied/7160799
;; (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

;; (add-hook 'enh-ruby-mode-hook 'flymake-ruby-load)
(add-hook 'enh-ruby-mode-hook 'projectile-rails-mode)
(add-hook 'slim-mode-hook 'projectile-rails-mode)
(add-hook 'enh-ruby-mode-hook 'robe-mode)
;; (setq ruby-deep-indent-paren nil)
(setq enh-ruby-deep-indent-paren nil)
(setq enh-ruby-bounce-deep-indent t)
(setq enh-ruby-hanging-brace-indent-level 2)
(defadvice inf-ruby-console-auto (before active-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

(define-key enh-ruby-mode-map (kbd "C-c r r") 'inf-ruby)
(define-key enh-ruby-mode-map (kbd "C-c r v") 'rvm-activate-corresponding-ruby)
(define-key enh-ruby-mode-map (kbd "C-c C-f") nil)


(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode t)
(show-smartparens-global-mode t)

(require 'highlight-indentation)
(add-hook 'enh-ruby-mode-hook
          (lambda() (highlight-indentation-current-column-mode)))
(add-hook 'coffee-mode-hook
          (lambda() (highlight-indentation-current-column-mode)))

(eval-after-load 'enh-ruby-mode
  '(progn
     (defun prelude-ruby-mode-defaults ()
       (inf-ruby-minor-mode +1)
       (ruby-tools-mode +1)
       ;; CamelCase aware editing operations
       (subword-mode +1))

     (setq prelude-ruby-mode-hook 'prelude-ruby-mode-defaults)

     (add-hook 'ruby-mode-hook (lambda ()
                                 (run-hooks 'prelude-ruby-mode-hook)))))

;; fix the key conflict with robe
;; you can M-x describe-package robe <return>
(require 'evil)
(eval-after-load 'enh-ruby-mode
  '(progn
     (define-key evil-normal-state-map "\M-." nil)
     (define-key evil-normal-state-map "\M-;" nil)
     ))
(add-hook 'ruby-mode-hook
  (function (lambda ()
          (setq evil-shift-width enh-ruby-indent-level))))

(provide 'my-ruby-mode)
;;; my-ruby-mode.el ends here
