;;; package ---- my-helper.el
;;; Commentary:
;;; code:

(defvar current-date-time-format "%A, %B %e, %Y"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-time-format "%-I:%M %p"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun my-insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
  (interactive)
  (insert (format-time-string current-date-time-format (current-time))))

(defun my-insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
  (interactive)
  (insert (format-time-string current-time-format (current-time))))

(defun my-print-current-major-mode (&optional buffer-or-name)
  "Return the major mode associated with a buffer.
If BUFFER-OR-NAME is nil return current buffer's mode."
  (interactive)
  (message "%s" (buffer-local-value 'major-mode
                                    (if buffer-or-name (get-buffer buffer-or-name) (current-buffer)))))

(defun my-setq-debug()
  (interactive)
  (setq debug-on-error t))

(defun my-open-note()
  (interactive)
  (find-file-other-window "~/Projects/note/emacs/mode.org"))

(defun my-create-scratch-buffer nil
  "create a scratch buffer"
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode))

(defun my-defind-font()
  (interactive)
  ;; (set-frame-font "Monaco-15")
  ;; (set-frame-font "Consolas-18")
  ;; (set-face-attribute 'default nil :font "Consolas-18")
  (set-fontset-font
   (frame-parameter nil 'font)
   'han
   (font-spec :family "STHeiti" :size 15))
  ;;(font-spec :name "WenQuanYi Micro Hei Mono"))
  ;;(font-spec :family "DejaVu Sans Mono" :size 12))
  ;;(font-spec :family "Hiragino Sans GB" ))
  )

(defun my-open-in-browser()
  (interactive)
  (let ((filename (buffer-file-name)))
    (browse-url (concat "file://" filename))))

(defun my-socks-proxy()
  (interactive)
  (setq socks-noproxy '("127.0.0.1"))
  (setq socks-server '("Default server" "127.0.0.1" 1080 5))
  (setq url-gateway-method 'socks))
(defun my-http-proxy()
  (interactive)
  (setq url-proxy-services
        '(("no_proxy" . "^\\(localhost\\|10.*\\)")
          ("http" . "121.199.35.60:8087")
          ("https" . "121.199.35.60:8087")))

  (setq url-http-proxy-basic-auth-storage
        (list (list "proxy.com:8080"
                    (cons "Input your LDAP UID !"
                          (base64-encode-string "LOGIN:PASSWORD"))))))

(defun my-open-finder-1 (dir file)
  (let ((script
         (if file
             (concat
              "tell application \"Finder\"\n"
              "    set frontmost to true\n"
              "    make new Finder window to (POSIX file \"" dir "\")\n"
              "    select file \"" file "\"\n"
              "end tell\n")
           (concat
            "tell application \"Finder\"\n"
            "    set frontmost to true\n"
            "    make new Finder window to {path to desktop folder}\n"
            "end tell\n"))))
    (start-process "osascript-getinfo" nil "osascript" "-e" script)))


(defun my-open-finder ()
  (interactive)
  (let ((path (buffer-file-name))
        dir file)
    (when path
      (setq dir (file-name-directory path))
      (setq file (file-name-nondirectory path)))
    (my-open-finder-1 dir file)))

;; C-x C-e ;; current line
;; M-x eval-region ;; region
;; M-x eval-buffer ;; whole buffer
;; M-x load-file ~/.emacs.d/init.el
(defun copy-file-path (&optional dirPathOnly-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
If `universal-argument' is called, copy only the dir path."
  (interactive "P")
  (let ((fPath
         (if (equal major-mode 'dired-mode)
             default-directory
           (buffer-file-name)
           )))
    (kill-new
     (if (equal dirPathOnly-p nil)
         fPath
       (file-name-directory fPath)
       )))
  (message "File path copied.") )

(defun my-test-prefix(&optional tagName)
  (interactive (if current-prefix-arg (list (read-string "Tag (span):" nil nil "span"))))
  (print tagName))

(defun my-helm-projectile-ag()
  (interactive)
  (let ((current-prefix-arg 4)) ;; emulate C-u
    (call-interactively 'helm-projectile-ag) ;; invoke align-regexp interactively
    ))

(defun my-search-note-md()
  (interactive)
  (helm-do-ag "/Users/user/projects/note.md/" )
  )

(provide 'my-helper)
;;; my-helper.el ends here
