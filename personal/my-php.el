;;; package ---- my-custom.el
;;; Commentary:

;;; Code:

(prelude-require-packages '(php-mode))
(require 'prelude-programming)

(require 'php-mode)
(eval-after-load 'php-mode
  '(progn
     (defun prelude-php-mode-defaults ()
       (flymake-php-load))

       ;; electric-layout-mode doesn't play nice with smartparens

     (setq prelude-php-mode-hook 'prelude-php-mode-defaults)

     (add-hook 'php-mode-hook (lambda () (run-hooks 'prelude-php-mode-hook)))))

(provide 'my-php)

;;; my-php.el ends here
