;;; my-kotlin.el --- Emacs Prelude: A nice setup for Ruby (and Rails) devs.
;;
;; Copyright © 2014 jiahut@gmail.com
;;
;; Author: zhijia,.zhang <jiahut@gmail.com>
;; URL: https://github.com/jiahut/.emacs.d
;; Version: 0.0.1
;; Keywords: go

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

(prelude-require-packages '(kotlin-mode))

(require 'kotlin-mode)

(provide 'my-kotlin)
;;; my-kotlin.el ends here