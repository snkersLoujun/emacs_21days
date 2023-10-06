(require 'package)
(setq package-archives '(("gnu"   . "http://1.15.88.122/gnu/")
("nongnu" . "http://1.15.88.122/nongnu/")

			 ("melpa" . "http://1.15.88.122/melpa/")))
(package-initialize) ;; You might already have this line


;;防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))

;;(package-install 'use-package) 

(assq-delete-all 'org package--builtins)
(assq-delete-all 'org package--builtin-versions)

;; Setup `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (use-package use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package restart-emacs
  :ensure t)

(use-package quelpa)

(unless (package-installed-p 'quelpa-use-package)
  (quelpa
   '(quelpa-use-package
     :fetcher git
     :url "https://github.com/quelpa/quelpa-use-package.git")))

(use-package quelpa-use-package
  :init
  (setq quelpa-use-package-inhibit-loading-quelpa t)
  :demand t)

(provide 'init-packages)
