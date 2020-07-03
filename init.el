

;; Supress starting message
(setq inhibit-startup-message t)

(setq w3m-default-display-inline-images t)


;; dvorak swap C-x with C-u
(define-key key-translation-map [?\C-x] [?\C-u])
(define-key key-translation-map [?\C-u] [?\C-x])

;; dvorak help binding remap to map 
(global-set-key (kbd "C-x C-h") help-map)
(global-set-key (kbd "C-h") 'previous-line)

;; Hide toolbar, menu and scroll-bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; highlight point line
(global-hl-line-mode t)
;; show line numbers
(line-number-mode t)



;; load package
(require 'package)
(package-initialize)

;; to see package package-archive contents execute C-h v package-archives
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)


;; remember recently opened buffers
(recentf-mode 1)
(setq recentf-max-menu-items 50) ;; last n
(setq recentf-max-saved-items 50)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


;; match parentheses
(show-paren-mode 1)

;; make my life easier with IDO
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; C-c C-p to check available commands
(use-package which-key
  :ensure t
  :config (which-key-mode))



;; theme settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "f3ab34b145c3b2a0f3a570ddff8fabb92dafc7679ac19444c31058ac305275e1" default)))
 '(ein:output-area-inlined-images t)
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#3a81c3")
     ("OKAY" . "#3a81c3")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#42ae2c")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f"))))
 '(package-selected-packages
   (quote
    (projectile treemacs use-package w3m ein spacemacs-theme monokai-theme conda bbdb)))
 '(pdf-view-midnight-colors (quote ("#655370" . "#fbf8ef"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )






;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))



(add-to-list 'load-path "~/.emacs.d/lisp/")
(load "mu4e-config")


(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1)
  )
(use-package treemacs
  :ensure t
  :bind
  (:map global-map
	([f8] . treemacs)
	("C-<f8>" .  treemacs-select-window)
	)
  :config
  (setq treemacs-is-never-other-window t))



