;;; package ---- my-helper.el
;;; Commentary:
;;; code:

(defun my-print-current-major-mode (&optional buffer-or-name)
"Return the major mode associated with a buffer.
If BUFFER-OR-NAME is nil return current buffer's mode."
  (interactive)
  (message "%s" (buffer-local-value 'major-mode
   (if buffer-or-name (get-buffer buffer-or-name) (current-buffer)))))

(defun my-setq-debug()
  (interactive)
  (setq debug-on-error t)
)

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

(provide 'my-helper)
;;; my-helper.el ends here
