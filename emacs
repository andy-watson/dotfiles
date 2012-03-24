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
; Set paths to include my local stuff
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

;;
;;------------------------------------------------------------
;; Variant specific config
;;
;
;------------------------------------------------------------
; Window system specific setup
;
(when X11_b
  ;; X11 window system
  (global-font-lock-mode 1)
  (setq x-pointer-foreground-color "white")
  (setq x-pointer-background-color "black")
  ;; TODO font stuff
  )

(when cocca_b
  ;; Mac OS-X
  (global-font-lock-mode 1)
  (setq tool-bar-mode nil)
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
  ;; Nice dark solarized colour scheme
  (require 'color-theme)
  (require 'color-theme-solarized)
  (color-theme-solarized-dark)
  (blink-cursor-mode -1))

(when console_b
  ;; On consoles we don't want font-lock turned on, as it usually
  ;; maps some (wanted) colour onto the background....
  (global-font-lock-mode 0))

;;
;;------------------------------------------------------------
;;
;; Mode specific stuff
;;

;; Enhanced Javascript Mode - http://code.google.com/p/js2-mode/
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;
;;------------------------------------------------------------
;;
;; Load local settings, these are not in rev control and are specific
;; to the user account on a specific system. NB if file isn't there
;; don't sweat it.
;;
(load "~/.emacs.d/local-settings" 'missing-ok)
