;;; my-scheme.el --- Emacs Prelude: A nice setup for Ruby (and Rails) devs.
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

(prelude-require-packages '(geiser))
(require 'geiser)
;; (require 'geiser-chicken)
(require 'geiser-company)

;; (add-to-list 'load-path "~/.emacs.d/personal/chicken")
;; (require 'geiser-chicken)

(setq geiser-active-implementations '(chicken guile))
(setq geiser-mode-smart-tab-p t)
(geiser-company--setup 1)
;; (geiser-smart-tab-mode 1)

;; (require 'chicken)

;; (prelude-require-packages '(scheme-complete))

;; (autoload 'scheme-smart-complete "scheme-complete" nil t)
;; (eval-after-load 'scheme
;;   '(define-key scheme-mode-map "\t" 'scheme-complete-or-indent))
;; (setq lisp-indent-function 'scheme-smart-indent-function)

(provide 'my-scheme)
;;; my-scheme.el ends here
