;;; package ---- my-custom.el
;;; Commentary:
;;; code:

(require 'package)
(setq package-archives nil)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gun" . "http://elpa.gnu.org/packages/") t)
;; (add-to-list 'package-archives
;;   '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

(prelude-require-packages '(evil evil-surround tramp thrift powerline-evil
                                 helm-company help-fns+ evil-commentary helm-dash ctags-update
                                 dirtree ag helm-ag helm-swoop impatient-mode powerline
                                 smooth-scrolling indent-guide emmet-mode yasnippet evil-leader evil-exchange
                                 evil-matchit dash-at-point grandshell-theme workgroups2 fcitx
                                 neotree evil-snipe)) ;; flymake-ruby sr-speedbar projectile-speedbar

;; disable speedbar open default
;; (setq projectile-speedbar-projectile-speedbar-enable nil)

(setq neo-smart-open t)
(setq projectile-switch-project-action 'neotree-projectile-action)

(defun neotree-projectile-dir-update()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (if (not (neo-global--window-exists-p))
             (neotree-show))
        (if project-dir
            (if (neo-global--window-exists-p)
                (progn
                  (neotree-dir project-dir)
                  (neotree-find file-name)))
          (message "Could not find git project root."))))

(defun neotree-projectile-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (neotree-toggle)
    (if project-dir
        (if (neo-global--window-exists-p)
            (progn
              (neotree-dir project-dir)
              (neotree-find file-name)))
      (message "Could not find git project root."))))
;; (global-set-key [f8] 'neotree-toggle)
(global-set-key [f8] 'neotree-projectile-dir)
(global-set-key [f5] 'neotree-projectile-dir-update)
(add-hook 'neotree-mode-hook
          (lambda ()
            (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
            (evil-define-key 'normal neotree-mode-map (kbd "o") 'neotree-enter)
            (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
            (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)))


(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'ruby-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'lisp-mode-hook 'hs-minor-mode)
(add-hook 'coffee-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)

;; enable osx-clipboard in terminal-emacs
(unless (display-graphic-p)
  (if (eq system-type 'darwin)
      (progn
        (prelude-require-packages '(osx-clipboard))
        (osx-clipboard-mode t)
        )))

;; (global-set-key (kbd "C-c C-v") 'hs-toggle-hiding)
(define-key prelude-mode-map (kbd "C-c v") 'hs-toggle-hiding)

(global-company-mode t)

(yas-global-mode 1)

;; emmet-mode
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)

;; map with the vim
;; (define-key prelude-mode-map (kbd "C-w q") 'delete-window)

(define-key evil-window-map "q" 'evil-window-delete)
;; (define-key prelude-mode-map (kbd "C-c d") nil)
(define-key prelude-mode-map (kbd "C-c d") 'helm-dash-at-point)
;; switch the C-c t
(define-key prelude-mode-map (kbd "C-c r") nil)
(define-key prelude-mode-map (kbd "C-c C-r") 'prelude-rename-buffer-and-file)

(require 'helm-ag)
(require 'projectile)

(setq helm-ag-insert-at-point 'word)
(defun helm-ag-with-dir (&optional basedir)
  (interactive)
  (custom-set-variables '(projectile-require-project-root nil))
  (let ((helm-ag-default-directory (or basedir
                                       (read-directory-name "Search Directory: " (helm-ag--default-directory))))
        (header-name (format "Search at %s" helm-ag-default-directory)))
    (helm-ag--query)
    (helm-attrset 'search-this-file nil helm-ag-source)
    (helm-attrset 'name header-name helm-ag-source)
    (helm :sources (helm-ag--select-source) :buffer "*helm-ag*"))
  )

;; (setq url-proxy-services
;;    '(("http" . "http://127.0.0.1:9742")
;;      ("https" . "http://127.0.0.1:9743"))

(require 'helm-swoop)
(global-set-key (kbd "C-c C-f") 'helm-swoop)



(require 'dirtree)
(autoload 'dirtree "dirtree" "Add directory to tree view" t)

;; refactor to perlsonal/preload/my-theme.el
;; (disable-theme 'zenburn)
;; (require 'monokai-theme)
;; (enable-theme 'monokai)
;; (require 'grandshell-theme)
;; (enable-theme 'grandshell)
;; (load-theme 'solarized-dark t)


;; (defun print-elements-of-list (list)
;;        "Print each element of LIST on a line of its own."
;;        (while list
;;          (print (car list))
;;          (setq list (cdr list))))

;; (print-elements-of-list load-path)

(global-set-key (kbd "C-x m") 'helm-M-x)

;;; had been setting in prelue-helm-everywhere.el
;; (global-set-key (kbd "C-x C-m") 'helm-M-x)

;; (global-set-key (kbd "C-c C-h") 'helm-prelude)

(custom-set-variables '(helm-projectile-sources-list
                        '(helm-source-projectile-files-list
                          helm-source-projectile-buffers-list
                          helm-source-projectile-recentf-list
                          helm-source-projectile-projects)
                        "Default sources for `helm-projectile'."))

(setq projectile-switch-project-action 'helm-projectile)

;; (add-to-list 'load-path "~/.emacs.d/personal/sdcv-mode")
;; (require 'sdcv-mode)
;; (global-set-key (kbd "C-c C-s") 'kid-star-dict)
;; use \ s  ;; update at 2014-12-15 00:45

;; https://github.com/alexott/emacs-configs/blob/master/rc/emacs-rc-sdcv.el
(defun kid-star-dict ()
  (interactive)
  (let ((begin (point-min))
        (end (point-max)))
    (if mark-active
        (setq begin (region-beginning)
              end (region-end))
      (save-excursion
        (backward-word)
        (mark-word)
        (setq begin (region-beginning)
              end (region-end))))
    (message "searching for %s ..." (buffer-substring begin end))
    (tooltip-show (shell-command-to-string
                   (concat "sdcv -n --utf8-output --utf8-input "
                           (buffer-substring begin end))))))

;; fix the sdcv-mode
;; (evil-declare-key 'normal sdcv-mode-map (kbd "q") 'delete-window)

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

;; use C-c p A for ag search in projectile
;; use C-u for set search root
(global-set-key (kbd "C-c C-g") 'helm-ag-with-dir)
(global-set-key (kbd "C-c C-c") 'helm-company)
(global-set-key (kbd "C-c C-t") 'dirtree-show)

;; remove the C-c t
;; default open terminal
(define-key prelude-mode-map (kbd "C-c t") nil)
;;; gloabl set
;;; (add-hook 'after-init-hook 'global-company-mode)
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
(evil-set-initial-state 'vkill-mode 'emacs)

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'evil-leader)
(global-evil-leader-mode 1)

(add-hook 'messages-buffer-mode 'evil-leader-mode)
(add-hook 'special-mode 'evil-leader-mode)
(add-hook 'fundamental-mode 'evil-mode)
(add-hook 'fundamental-mode 'evil-leader-mode)

;;; (setq evil-default-state 'normal)

;;; I want the keybinding X to work in Evil!
;;; override the \C-e

;;; what's difference between motion and normal
(define-key evil-motion-state-map "\C-u" 'evil-scroll-up)
;; (setq-default evil-want-c-u-scroll t)

;; (define-key evil-normal-state-map "\C-r" 'isearch-backward)
(define-key evil-normal-state-map "\C-e" 'end-of-line)
;; (define-key evil-motion-state-map "\C-e" 'evil-end-of-line)
(define-key evil-insert-state-map "\C-e" 'end-of-line)
;; ctrl-d  Scroll window Downwards in the buffer default in vim-insert-mode
(define-key evil-insert-state-map "\C-d" 'evil-delete-char)

;; always mistake
;; default set-fill-column
;; you can type `\` then `C-x f` to set-fill-column in `emacs` status
(define-key prelude-mode-map (kbd "\C-x f") 'helm-recentf)
(define-key prelude-mode-map (kbd "\C-w z") 'winner-undo)
(evil-declare-key 'emacs prelude-mode-map (kbd "\C-x f") 'set-fill-column)

(define-key evil-insert-state-map "\C-n" 'evil-next-line)
(define-key evil-insert-state-map "\C-p" 'evil-previous-line)
(define-key evil-insert-state-map "\C-k" 'kill-line)
;;; Evil bindings for key X shadow the default bindings in mode Y
;;; A common culprit here is the return key, which is ordinarily bound to evil-ret
;;; (a command that, as of this writing, doesn't know about what return is supposed to do in a current mode).

(evil-declare-key 'motion completion-list-mode-map (kbd "<return>") 'choose-completion)
(evil-declare-key 'motion completion-list-mode-map (kbd "RET") 'choose-completion)
(evil-declare-key 'motion browse-kill-ring-mode-map (kbd "<return>") 'browse-kill-ring-insert-and-quit)
(evil-declare-key 'motion browse-kill-ring-mode-map (kbd "RET") 'browse-kill-ring-insert-and-quit)
(evil-declare-key 'motion occur-mode-map (kbd "<return>") 'occur-mode-goto-occurrence)
(evil-declare-key 'motion occur-mode-map (kbd "RET") 'occur-mode-goto-occurrence)

(evil-declare-key 'emacs magit-log-mode-map (kbd "\C-d") 'evil-scroll-down)
(evil-declare-key 'emacs magit-log-mode-map (kbd "\C-u") 'evil-scroll-up)

(evil-declare-key 'emacs magit-commit-mode-map (kbd "\C-d") 'evil-scroll-down)
(evil-declare-key 'emacs magit-commit-mode-map (kbd "\C-u") 'evil-scroll-up)

(evil-declare-key 'emacs magit-branch-manager-mode-map (kbd "\C-d") 'evil-scroll-down)
(evil-declare-key 'emacs magit-branch-manager-mode-map (kbd "\C-u") 'evil-scroll-up)

(evil-declare-key 'emacs magit-status-mode-map (kbd "\C-d") 'evil-scroll-down)
(evil-declare-key 'emacs magit-status-mode-map (kbd "\C-u") 'evil-scroll-up)

(evil-declare-key 'emacs magit-status-mode-map (kbd "\C-w h") 'evil-window-left)
(evil-declare-key 'emacs magit-status-mode-map (kbd "\C-w l") 'evil-window-right)
(evil-declare-key 'emacs magit-status-mode-map (kbd "\C-w k") 'evil-window-up)
(evil-declare-key 'emacs magit-status-mode-map (kbd "\C-w j") 'evil-window-down)

;; unset key \ for 'evil-execute-in-emacs-state
(define-key evil-motion-state-map "\\" nil)
;; (define-key evil-motion-state-map "\\\\" 'evil-execute-in-emacs-state)

(evil-leader/set-key
  "b" 'helm-mini
  "f" 'helm-projectile
  "p" 'helm-projectile-switch-project
  "r" 'helm-recentf
  "a" 'my-helm-projectile-ag
  "k" 'kill-this-buffer
  "m" 'bookmark-set
  "l" 'helm-bookmarks
  "d" 'bookmark-delete
  "w" 'wg-switch-to-workgroup
  "s" 'kid-star-dict
  "c" 'my-create-scratch-buffer
  "e" 'evil-execute-in-emacs-state
  "\\" 'er/expand-region
  "g" 'window-configuration-to-register
  "j" 'jump-to-register
  "y" 'prelude-copy-file-name-to-clipboard
  "n" 'my-search-note-md
  "h" 'helm-swoop
  ;; "m" 'maximize-window ;; use winner-redo/ winner-undo  default C-c <-/->
  ;; "gs" 'magit-status)
  )
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

;; (require 'cycbuf)
;; (define-key prelude-mode-map (kbd "C-x n") 'cycbuf-switch-to-next-buffer)
;; (define-key prelude-mode-map (kbd "C-x p") 'cycbuf-switch-to-previous-buffer)

(define-key prelude-mode-map (kbd "M-n") 'next-buffer)
(define-key prelude-mode-map (kbd "M-p") 'previous-buffer)

(when (display-graphic-p)
  (setq fonts
        (cond ((eq system-type 'darwin)     '("Monaco"     "STHeiti"))
              ((eq system-type 'gnu/linux)  '("Menlo"     "WenQuanYi Zen Hei"))
              ((eq system-type 'windows-nt) '("Consolas"  "Microsoft Yahei"))))

  (setq face-font-rescale-alist '(("STHeiti" . 1.2) ("Microsoft Yahei" . 1.2) ("WenQuanYi Zen Hei" . 1.2)))
  (set-face-attribute 'default nil :font
                      (format "%s:pixelsize=%d" (car fonts) 15))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family (car (cdr fonts))))))

;; (set-frame-parameter nil 'font "Monaco-15")
;; (set-face-attribute 'default nil :font "Consolas-18")
;; (set-frame-font "Monaco 15" nil t)
;; (set-face-attribute 'default nil :font "Monaco 15")
;; (set-default-font "Monaco 15")

;; add thrift-mode
;; (add-to-list 'load-path "~/.emacs.d/personal/extra")
;; (require 'thrift-mode)

;; smooth scroll
(require 'smooth-scrolling)
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; minimap
;; (require 'minimap)
;; * Use 'M-x minimap-toggle' to toggle the minimap.
;; * Use 'M-x minimap-create' to create the minimap.
;; * Use 'M-x minimap-kill' to kill the minimap.
;; * Use 'M-x customize-group RET minimap RET' to adapt minimap to your needs.

;; powerline
(require 'powerline-evil)
;; (add-hook 'after-init-hook (lambda ()(powerline-evil-center-color-theme)))
;; (add-hook 'after-init-hook 'powerline-evil-vim-color-theme)
;; run later
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Standard-Hooks.html
(add-hook 'window-setup-hook 'powerline-evil-vim-color-theme)

;; indent-guide
(require 'indent-guide)
(indent-guide-global-mode)
;; you can use C-h M-k for special keymap variale
(require 'help-fns+)

;; had merge to prelude-ui 2015-08-14
;; (require 'smart-mode-line)
(require 'smart-mode-line)

(require 'powerline)
(setq powerline-default-separator 'curve)

(setq powerline-default-separator-dir '(right . left))
;; (sml/apply-theme 'automatic)
(setq sml/theme 'powerline)
;; (sml/setup)

;; (setq browse-url-browser-function 'w3m-browse-url)
;; (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; (setq w3m-use-cookies t)

(require 'evil-matchit)
(global-evil-matchit-mode 1)

;; fix (evilnc-default-hotkeys)
;; delete global-key-binding and ,ll binding
;; https://github.com/redguardtoo/evil-nerd-commenter/issues/47
;; (require 'evil-nerd-commenter)
(require 'evil-commentary)
(evil-commentary-mode 1)

(require 'helm-dash)
(setq helm-dash-browser-func 'eww-browse-url)
;; (setq helm-dash-browser-func 'w3m-browse-url)

;;; http://nflycheck.readthedocs.org/en/0.17/flycheck-versus-flymake.html
(add-hook 'after-init-hook #'global-flycheck-mode)
;; use apsell as ispell backend
(setq-default ispell-program-name "aspell")
;; use American English as ispell default dictionary
(ispell-change-dictionary "american" t)

(require 'evil-exchange)
(evil-exchange-install)

(add-to-list 'load-path "~/.emacs.d/personal/freemind")
(require 'ox-freemind)

;; speedbar
;; (require 'projectile-speedbar)
;; (global-set-key (kbd "<f2>") 'projectile-speedbar-open-current-buffer-in-tree)

;; vim-snipe
(require 'evil-snipe)
(setq evil-snipe-repeat-keys t)
(setq evil-snipe-scope 'visible)
(setq evil-snipe-repeat-scope 'whole-visible)
(setq evil-snipe-enable-highlight t)
(setq evil-snipe-enable-incremental-highlight t)
(evil-snipe-mode 1)
(evil-snipe-override-mode 1)

;; close menu bar
(menu-bar-mode -1)
;; http://endlessparentheses.com/old-packages-and-new-packages-in-24-4.html
(global-prettify-symbols-mode t)

;; ;; http://workgroups2.readthedocs.org/en/latest/guide/usage.html
;; (require 'workgroups2)
;; ;; Change prefix key (before activating WG)
;; (setq wg-prefix-key (kbd "C-c z"))
;; ;; Change workgroups session file
;; (setq wg-session-file "~/.emacs.d/.emacs_workgroups")
;; (setq wg-mode-line-display-on t)
;; (setq wg-mode-line-decor-left-brace "["
;;       wg-mode-line-decor-right-brace "]"  ; how to surround it
;;       wg-mode-line-decor-divider ":")
;; (workgroups-mode 1)

;; (setq prelude-clean-whitespace-on-save nil)


;; etags

(require 'ctags-update)
(autoload 'turn-on-ctags-auto-update-mode "ctags-update" "turn on 'ctags-auto-update-mode'." t)
(add-hook 'c-mode-common-hook  'turn-on-ctags-auto-update-mode)
(add-hook 'java-mode-common-hook  'turn-on-ctags-auto-update-mode)
(autoload 'ctags-update "ctags-update" "update TAGS using ctags" t)


(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(add-hook 'web-mode-hook
          (lambda () ((setq web-mode-markup-indent-offset 2)
                  (setq web-mode-css-indent-offset 2)
                  (setq web-mode-code-indent-offset 2))))

(require 'fcitx)
(fcitx-default-setup)

(desktop-save-mode 1)
(if (file-exists-p
     (concat default-directory ".emacs.desktop"))
    (desktop-read default-directory))

(add-hook 'kill-emacs-hook
          `(lambda ()
             (desktop-save default-directory t)))
(provide 'my-custom)
;;; my-custom.el ends here
