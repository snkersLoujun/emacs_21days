(global-linum-mode 1)

(setq inhibit-startup-screen t)


(toggle-frame-maximized)


;; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 160)

;;让鼠标滚动更好用
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)



(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq-default cursor-type '(bar . 5))


(global-hl-line-mode 1)

;;(use-package monokai-theme)
;;(load-theme 'monokai 1)
(use-package doom-themes)
(load-theme 'doom-one 1)


(provide 'init-ui)
