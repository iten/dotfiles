(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(global-set-key "\M- " 'hippie-expand)
(global-set-key "\M-/" 'hippie-expand)
(setq scheme-program-name "scheme")

(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)
(setq ack-executable (executable-find "ack-grep"))

(require 'color-theme)
(require 'ido)
(require 'ergo-movement-mode)
(ergo-movement-mode 1)

;; styles
(setq c-default-style "linux"
      c-basic-offset 4)

;; display

(set-default-font "Droid Sans Mono-10")

;; backup dir
(setq
   backup-by-copying t  
   backup-directory-alist
    '(("." . "~/.emacs.d/saves")) 
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 5
   version-control t
   auto-save-file-name-transforms
    '((".*" "~/.emacs.d/autosaves/\\1" t)))

(make-directory "~/.emacs.d/saves" t)
(make-directory "~/.emacs.d/autosaves" t)

;; Use ido with M-x
(global-set-key
 "\M-x"
 (lambda ()
   (interactive)
   (call-interactively
    (intern
     (ido-completing-read
      "M-x "
      (all-completions "" obarray 'commandp))))))

(color-theme-initialize)
(color-theme-charcoal-black)

(show-paren-mode t)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(ido-mode (quote both) nil (ido))
 '(inhibit-startup-screen t))
