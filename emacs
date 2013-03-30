;------------------------------------------------------------
; Emacs startup file
;
; Custom specific for Andy Watson
;------------------------------------------------------------
;
; Set some constants derived from system/environemt
;

(defconst linux_b
  (or (eq system-type 'gnu/linux)
      (eq system-type 'linux))
  "Are we running on a GNU/Linux system?")

(defconst osx_b
  (eq system-type 'darwin)
  "Are we running on a Mac OS-X system?")

(defconst unix_b
  (or linux_b
      (eq system-type 'usg-unix-v)
      (eq system-type 'berkeley-unix))
  "Are we running unix")
;
; Window systems
;
(defconst X11_b
  (eq window-system 'x)
  "Are we running in X11 windowed environment?")

(defconst cocca_b
  (eq window-system 'ns)
  "Are we running in OS-X Cocca, or GNUstep windowed environment?")

(defconst console_b
  (eq window-system nil)
  "Are we running in in a text console environment?")
;
; Emacs variants
;
(defconst xemacs_b
  (featurep 'xemacs)
  "Are we running XEmacs?")


(defconst carbonemacs_b
  (featurep 'carbon-emacs-package)
  "Are we running Carbon Emacs on OS-X?")
;
;------------------------------------------------------------
; Set paths to include my local stuff. Note user-lisp comes first
; overriding any installation stuff, missing-lisp comes last
; this is so that we use installation version if available before
; falling through to stuff in here
;
(setq load-path (cons "~/.emacs.d/user-lisp/" load-path))

;;
;;------------------------------------------------------------
;; Standard non conditional configuration
;;
; Turn off backup file
; (setq make-backup-files nil)
; Paren matching
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)
; Turn on transient marking
(transient-mark-mode 1)
; Make C-k delete the trailing newline as well
(setq kill-whole-line t)
; Show the current line and column numbers
(setq column-number-mode t)
(setq line-number-mode t)
; Tab width is four characters, no tabs on indents
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
; When searching be case insensitive
(setq case-fold-search t)
; Turn off the annoying newbie messages
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-screen t)

; ESC-G is goto-line, not standard, but ingrained in memory cells
(global-set-key "\eg" 'goto-line)

;;------------------------------------------------------------
;;
;; Setup of new frames
;;
;; This is done as a hook so that emacsclient generated frames
;; get the customisations, see:
;;     http://stackoverflow.com/questions/9287815/how-to-check-if-emacs-in-frame-or-in-terminal
;;
(defun my-frame-config (frame)
  "Custom behaviours for new frames."
  (with-selected-frame frame
    (when (display-graphic-p)
      ;; If we've got graphics use them
      (global-font-lock-mode 1)
      ;; don't waste space with toolbar
      (tool-bar-mode -1)
      ;; Nice dark solarized colour scheme
      (require 'color-theme)
      (require 'color-theme-solarized)
      (color-theme-solarized-dark)
      (when (eq window-system 'x)
        ;; default font stuff
        (set-face-attribute 'default nil :family "Inconsolata" :height 140)
        ;; Scroll smoothly one line at a time rather than jumping in chunks
        (setq scroll-step 1)
        ;; No scrollbar ... never use it
        (scroll-bar-mode 0)
      )
      (when (eq window-system 'ns)
        ;; Extended keyboard delete key needs explicitly mapping
        ;; to give forward deletion
        (global-set-key '[(kp-delete)] 'delete-char)  ;;
        ;; Play with alt/cmd -> meta mappings so we can use alt key
        ;; to get at 'special' characters such as hash on a UK keyboard!
        ;;
        (setq mac-option-key-is-meta nil)
        (setq mac-command-key-is-meta t)
        (setq mac-command-modifier 'meta)
        (setq mac-option-modifier nil)
        ;; Set buffer size to 80x40 and a default font height
        (setq default-frame-alist '((width . 80)(height . 40)))
        (set-face-attribute 'default nil :height 160)
        (blink-cursor-mode -1)
      )
    )
    (when (eq window-system nil)
      ;; On consoles we don't want font-lock turned on, as it usually
      ;; maps some (wanted) colour onto the background....
      (global-font-lock-mode 0)
    )
  )
)
;; run now
(my-frame-config (selected-frame))
;; and later
(add-hook 'after-make-frame-functions 'my-frame-config)

;;
;;------------------------------------------------------------
;;
;; Mode specific stuff
;;

;; Most of my html editing is no jinja2 templates
(require 'jinja2-mode)
(add-to-list 'auto-mode-alist '("\\.html$" . jinja2-mode))

;; Enhanced Javascript Mode - http://code.google.com/p/js2-mode/
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; ESS
(setq ess-S-assign-key (kbd "C-="))
(add-hook 'ess-mode-hook
  (lambda ()
    (ess-toggle-underscore nil )))
;;
;;------------------------------------------------------------
;;
;; Load local settings, these are not in rev control and are specific
;; to the user account on a specific system. NB if file isn't there
;; don't sweat it.
;;
(load "~/.emacs.d/local-settings" 'missing-ok)
