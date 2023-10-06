(add-to-list 'load-path (expand-file-name "~/.emacs.d/awesome-tab"))

(require 'awesome-tab)

(awesome-tab-mode t)

(defun awesome-tab-buffer-groups ()
"`awesome-tab-buffer-groups' control buffers' group rules.
Group awesome-tab with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
All buffer name start with * will group to \"Emacs\".
Other buffer group by `awesome-tab-get-group-name' with project name."
(list
(cond
    ((or (string-equal "*" (substring (buffer-name) 0 1))
	(memq major-mode '(magit-process-mode
			    magit-status-mode
			    magit-diff-mode
			    magit-log-mode
			    magit-file-mode
			    magit-blob-mode
			    magit-blame-mode)))
    "Emacs")
    ((derived-mode-p 'eshell-mode)
    "EShell")
    ((derived-mode-p 'dired-mode)
    "Dired")
    ((memq major-mode '(org-mode org-agenda-mode diary-mode))
    "OrgMode")
    ((derived-mode-p 'eaf-mode)
    "EAF")
    (t
     (awesome-tab-get-group-name (current-buffer))))))


(use-package pyim)

(defun eh-orderless-regexp (orig_func component)
    (let ((result (funcall orig_func component)))
      (pyim-cregexp-build result)))


  (defun toggle-chinese-search ()
    (interactive)
    (if (not (advice-member-p #'eh-orderless-regexp 'orderless-regexp))
        (advice-add 'orderless-regexp :around #'eh-orderless-regexp)
      (advice-remove 'orderless-regexp #'eh-orderless-regexp)))

  (defun disable-py-search (&optional args)
    (if (advice-member-p #'eh-orderless-regexp 'orderless-regexp)
        (advice-remove 'orderless-regexp #'eh-orderless-regexp)))

  ;; (advice-add 'exit-minibuffer :after #'disable-py-search)
(add-hook 'minibuffer-exit-hook 'disable-py-search)

;;modeline上显示我的所有的按键和执行的命令
(use-package keycast
  :ensure t)
(require 'keycast)
(add-to-list 'global-mode-string '("" keycast-mode-line))
(keycast-mode t)

(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)

(use-package quickrun
  :ensure t
  :commands (quickrun)
  :init
  (quickrun-add-command "c++/c1z"
    '((:command . "g++")
      (:exec . ("%c -std=c++1z %o -o %e %s"
		"%e %a"))
      (:remove . ("%e")))
    :default "c++"))

(global-set-key (kbd "<f5>") 'quickrun)

(defun my/search-project-for-symbol-at-point ()
  (interactive)
  (if (use-region-p)
      (progn
	(consult-ripgrep (project-root (project-current))
			 (buffer-substring (region-beginning) (region-end))))))

; do what i mean   dwim
(defun zilongshanren/highlight-dwim ()
  (interactive)
  (if (use-region-p)
      (progn
        (highlight-frame-toggle)
        (deactivate-mark))
    (symbol-overlay-put)))

(use-package expand-region
  :config
  (defadvice er/prepare-for-more-expansions-internal
      (around helm-ag/prepare-for-more-expansions-internal activate)
    ad-do-it
    (let ((new-msg (concat (car ad-return-value)
			   ", H to highlight in buffers"
			   ", / to search in project, "
			   "e iedit mode in functions"
			   "f to search in files, "
			   "b to search in opened buffers"))
	  (new-bindings (cdr ad-return-value)))
      (cl-pushnew
       '("H" (lambda ()
	       (interactive)
	       (call-interactively
		'zilongshanren/highlight-dwim)))
       new-bindings)
      (cl-pushnew
       '("/" (lambda ()
	       (interactive)
	       (call-interactively
		'my/search-project-for-symbol-at-point)))
       new-bindings)
      (cl-pushnew
       '("e" (lambda ()
	       (interactive)
	       (call-interactively
		'evil-multiedit-match-all)))
       new-bindings)
      (cl-pushnew
       '("f" (lambda ()
	       (interactive)
	       (call-interactively
		'find-file)))
       new-bindings)
      (cl-pushnew
       '("b" (lambda ()
	       (interactive)
	       (call-interactively
		'consult-line)))
       new-bindings)
      (setq ad-return-value (cons new-msg new-bindings)))))

(defun zilongshanren/evil-quick-replace (beg end )
    (interactive "r")
    (when (evil-visual-state-p)
      (evil-exit-visual-state)
      (let ((selection (regexp-quote (buffer-substring-no-properties beg end))))
	(setq command-string (format "%%s /%s//g" selection))
	(minibuffer-with-setup-hook
	    (lambda () (backward-char 2))
	  (evil-ex command-string)))))


(defun zilongshanren/clearn-highlight ()
  (interactive)
  (clear-highlight-frame)
  (symbol-overlay-remove-all))

(use-package symbol-overlay
  :config
  (define-key symbol-overlay-map (kbd "h") 'nil))


(provide 'init-tools)


