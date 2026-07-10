;; ================
;; Package center
;; ================
(require 'package)
(setq package-archives '(("gnu"    . "http://elpa.gnu.org/packages/")
                         ("nongnu" . "http://elpa.nongnu.org/nongnu/")
                         ("melpa"  . "http://melpa.org/packages/")))
(package-initialize)

 
;; ================
;; BASIC 
;; ================
;; custom-file to host garbages
(setq custom-file "~/.config/emacs/custom.el")
(load-file custom-file)

;; don't show startup secreen
(setq inhibit-startup-message t)

;; Disable lockfiles (.# files)
(setq create-lockfiles nil)

;; Disable backup files (~ files)
(setq make-backup-files nil)

;; Disable auto-save (# files)
(setq auto-save-default nil)

;; delete files to trash
(setq delete-by-moving-to-trash t)

;; Disable auto-save-list folder
(setq auto-save-list-file-prefix nil)

;; Revert dired and other buffers when there are changes on disk
(setq global-auto-revert-non-file-buffers t)

;; general options
(setq global-auto-revert-non-file-buffers t)
(setq history-length 25)
(setq pixel-scroll-precision-mode t)
(setq tab-width 4)
(setq use-dialog-box nil)
(setq use-short-answers t)

;; for performance
(setq file-name-shadow-mode nil)
(setq gc-cons-threshold #x40000000)
(setq read-process-output-max (* 1024 1024 4))

;; Smooter screen nav
(setq scroll-margin 10)
(setq scroll-conservatively 100)
(setq scroll-preserve-screen-position t)


;; UI / Modes
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(delete-selection-mode 1)
(global-auto-revert-mode 1) 
(recentf-mode 1)
(save-place-mode 1)

;; Persian fonts
(set-fontset-font t 'arabic (font-spec :family "Vazir"))


;; lsp
(add-hook 'go-mode-hook 'eglot-ensure)

;; =======================
;; Vertical selection
;; =======================
(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t) 
  :init
  (vertico-mode 1))

;; =======================
;; Context/Annotations
;; =======================
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))

;; =======================
;; The Search Engine
;; =======================
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; =======================
;; Fuzzy finder
;; =======================
(use-package consult					        
  :ensure t
  :bind (
         ("C-c f b" . consult-buffer)
         ("C-c f s" . consult-line)
         ("C-c f g" . consult-ripgrep)
         ("C-c f f" . consult-find)
         ("C-c f i" . consult-imenu)
	 ("C-c f o" . consult-outline)))
;; =======================
;; Auto complation
;; =======================
(use-package corfu
  :ensure t
  :custom
    (corfu-auto nil)
    (corfu-cycle t) 
  :init
  (global-corfu-mode 1))

(use-package move-text
  :ensure t
  :bind (("M-<up>" . move-text-up)
         ("M-<down>" . move-text-down)))


;; =======================
;; Go Lang
;; =======================
(use-package go-mode
  :ensure t)

;; =======================
;; KEYBINDINGS
;; =======================
(defun mark-current-line()
  "highlight current line"
  (interactive)
  (beginning-of-line)
  (set-mark-command nil)
  (end-of-line))

(defun delete-current-line()
  "delete current current line"
  (interactive)
  (beginning-of-line)
  (kill-line)
  (kill-line))

;; mark current line
(global-set-key(kbd "C-;") 'mark-current-line) 
;; copy line down
(global-set-key(kbd "C-.") 'duplicate-dwim)

;; delete current line
(global-set-key(kbd "C-c k") 'delete-current-line)
;;current buffer
(global-set-key (kbd "C-c x") 'eval-buffer)


(message "init.el loaded successfully")
