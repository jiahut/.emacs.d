;;; package ---- my-custom.el
;;; Commentary:
;;; code:
(prelude-require-packages '(evil surround monokai-theme solarized-theme tramp helm-company jade-mode help-fns+ coffee-mode dirtree helm-ag))

(require 'dirtree)
(autoload 'dirtree "dirtree" "Add directory to tree view" t)
;; (disable-theme 'zenburn)
(load-theme 'solarized-dark t)

;; TODO err when load this
;; (prelude-require-packages '(color-theme-solarized))
;; (eval-after-load "color-theme"
;;   '(progn
;;      (color-theme-initialize)
;;      (color-theme-solarized-dark)
;;     )
;; )

;; (add-hook 'emacs-startup-hook
;;   (lambda ()
;;     (load-theme 'solarized-dark t)
;; ))

;; (add-hook 'after-init-hook
;;   (lambda ()
;;     (load-theme 'solarized-dark t))
;; )

;; END

;; (load-theme 'monokai t)
(global-linum-mode t)
;;(require 'xcscope)

;; func comment
;; use M-\; replace
;; (defun comment-or-uncomment-region-or-line ()
;;     "Comments or uncomments the region or the current line if there's no active region."
;;     (interactive)
;;     (let (beg end)
;;         (if (region-active-p)
;;             (setq beg (region-beginning) end (region-end))
;;             (setq beg (line-beginning-position) end (line-end-position)))
;;         (comment-or-uncomment-region beg end)
;;         (next-line)))
;; (global-set-key (kbd "C-c /") 'comment-or-uncomment-region-or-line)

(global-set-key (kbd "C-c C-f") 'helm-ag)
(global-set-key (kbd "C-c C-c") 'helm-company)
(global-set-key (kbd "C-c C-t") 'dirtree-show)

;; remote the C-c t
(define-key prelude-mode-map (kbd "C-c t") nil)
;;; gloabl set
(add-hook 'after-init-hook 'global-company-mode)
;;; transparency
(defun djcb-opacity-modify (&optional dec)
  "modify the transparency of the emacs frame; if DEC is t,
   decrease the transparency, otherwise increase it in 10%-steps"
  (let* ((alpha-or-nil (frame-parameter nil 'alpha)) ; nil before setting
          (oldalpha (if alpha-or-nil alpha-or-nil 100))
          (newalpha (if dec (- oldalpha 5) (+ oldalpha 5))))
    (when (and (>= newalpha frame-alpha-lower-limit) (<= newalpha 100))
      (modify-frame-parameters nil (list (cons 'alpha newalpha))))))

 ;; C-8 will increase opacity (== decrease transparency)
 ;; C-9 will decrease opacity (== increase transparency
 ;; C-0 will returns the state to normal
(global-set-key (kbd "C-8") '(lambda()(interactive)(djcb-opacity-modify)))
(global-set-key (kbd "C-9") '(lambda()(interactive)(djcb-opacity-modify t)))
(global-set-key (kbd "C-0") '(lambda()(interactive)
                               (modify-frame-parameters nil `((alpha . 100)))))

(require 'tramp)
(setq tramp-default-method "scp")

(require 'evil)
(evil-mode 1)
(evil-set-initial-state 'dirtree-mode 'emacs)
(evil-set-initial-state 'ibuffer-mode 'normal)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(require 'surround)
(global-surround-mode 1)
;;; (setq evil-default-state 'normal)

;;; I want the keybinding X to work in Evil!
;;; override the \C-e
;; (define-key evil-normal-state-map "\C-r" 'isearch-backward)
(define-key evil-normal-state-map "\C-e" 'end-of-line)
;; (define-key evil-motion-state-map "\C-e" 'evil-end-of-line)
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-insert-state-map "\C-d" 'evil-delete-char)


(define-key evil-insert-state-map "\C-n" 'evil-next-line)
(define-key evil-insert-state-map "\C-p" 'evil-previous-line)
;;; Evil bindings for key X shadow the default bindings in mode Y
;;; A common culprit here is the return key, which is ordinarily bound to evil-ret
;;; (a command that, as of this writing, doesn't know about what return is supposed to do in a current mode).

(evil-declare-key 'motion completion-list-mode-map (kbd "<return>") 'choose-completion)
(evil-declare-key 'motion completion-list-mode-map (kbd "RET") 'choose-completion)
(evil-declare-key 'motion browse-kill-ring-mode-map (kbd "<return>") 'browse-kill-ring-insert-and-quit)
(evil-declare-key 'motion browse-kill-ring-mode-map (kbd "RET") 'browse-kill-ring-insert-and-quit)
(evil-declare-key 'motion occur-mode-map (kbd "<return>") 'occur-mode-goto-occurrence)
(evil-declare-key 'motion occur-mode-map (kbd "RET") 'occur-mode-goto-occurrence)

;; @see http://stackoverflow.com/questions/10569165/how-to-map-jj-to-esc-in-emacs-evil-mode
;; @see http://zuttobenkyou.wordpress.com/2011/02/15/some-thoughts-on-emacs-and-vim/
(define-key evil-insert-state-map "j" #'cofi/maybe-exit)
(evil-define-command cofi/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "j")
    (let ((evt (read-event (format "Insert %c to exit insert state" ?j)
               nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt ?j))
    (delete-char -1)
    (set-buffer-modified-p modified)
    (push 'escape unread-command-events))
       (t (setq unread-command-events (append unread-command-events
                          (list evt))))))))

;; buffer burial
;; necessary support function for buffer burial
    (defun crs-delete-these (delete-these from-this-list)
      "Delete DELETE-THESE FROM-THIS-LIST."
      (cond
       ((car delete-these)
        (if (member (car delete-these) from-this-list)
            (crs-delete-these (cdr delete-these) (delete (car delete-these)
                                                     from-this-list))
          (crs-delete-these (cdr delete-these) from-this-list)))
       (t from-this-list)))
    ; this is the list of buffers I never want to see
    (defvar crs-hated-buffers
      '("KILL" "*Compile-Log*"))
    ; might as well use this for both
    (setq iswitchb-buffer-ignore (append '("^ " "*Buffer") crs-hated-buffers))
    (defun crs-hated-buffers ()
      "List of buffers I never want to see, converted from names to buffers."
      (delete nil
              (append
               (mapcar 'get-buffer crs-hated-buffers)
               (mapcar (lambda (this-buffer)
                         (if (string-match "^ " (buffer-name this-buffer))
                             this-buffer))
                       (buffer-list)))))
    ; I'm sick of switching buffers only to find KILL right in front of me
    (defun crs-bury-buffer (&optional n)
      (interactive)
      (unless n
        (setq n 1))
      (let ((my-buffer-list (crs-delete-these (crs-hated-buffers)
                                              (buffer-list (selected-frame)))))
        (switch-to-buffer
         (if (< n 0)
             (nth (+ (length my-buffer-list) n)
                  my-buffer-list)
           (bury-buffer)
           (nth n my-buffer-list)))))
    (global-set-key [(control tab)] 'crs-bury-buffer)
    (global-set-key [(control shift tab)] (lambda ()
                                           (interactive)
                                           (crs-bury-buffer -1)))

(provide 'my-custom)
;;; my-custom.el ends here
