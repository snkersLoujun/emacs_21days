(require 'org-tempo)  ;开启easy template


(use-package org
  :ensure t)

(use-package org-contrib
  :pin nongnu
  )

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
	      (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)" "MEETING(m)" "PHONE(p)"))))

(require 'org-checklist)

(setq org-log-done t)
(setq org-log-into-drawer t)

(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-files '("~/gtd.org"))
(setq org-agenda-span 'day)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/gtd.org" "Workspace")
	 "* TODO [#B] %?\n  %i\n %U"
	 :empty-lines 1)))

(global-set-key (kbd "C-c r") 'org-capture)

(setq org-agenda-custom-commands
      '(("c" "重要且紧急的事"
	 ((tags-todo "+PRIORITY=\"A\"")))
	;; ...other commands here
	))

(provide 'init-org)
