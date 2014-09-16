;;; package ---- my-helper.el
;;; Commentary:
;;; code:

(defun print-current-major-mode (&optional buffer-or-name)
"Return the major mode associated with a buffer.
If BUFFER-OR-NAME is nil return current buffer's mode."
  (interactive)
  (message "%s" (buffer-local-value 'major-mode
   (if buffer-or-name (get-buffer buffer-or-name) (current-buffer)))))

(defun open-my-note()
  (interactive)
  (find-file-other-window "~/Projects/note/README.md"))

(defun open-finder-1 (dir file)
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


(defun open-finder ()
  (interactive)
  (let ((path (buffer-file-name))
		dir file)
	(when path
	  (setq dir (file-name-directory path))
	  (setq file (file-name-nondirectory path)))
	(open-finder-1 dir file)))

(provide 'my-helper)
;;; my-helper.el ends here
