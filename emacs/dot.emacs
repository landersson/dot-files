
;; laans .emacs configuration.

(setq load-path (append '("~/.emacs.d/") load-path))

(load "cmake-mode.el")
;;(load "lua-mode.el")


;;(add-to-list 'load-path "~/.emacs.d/scala-mode2/")
;;(require 'scala-mode2)

(defcustom mycustom-system-include-paths '("./include/" "/opt/local/include" "/usr/include" )
  "This is a list of include paths that are used by the clang auto completion."
  :group 'mycustom
  :type '(repeat directory)
  )
 
;(add-to-list 'load-path "~/build/auto-complete/")
;;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "~/build/auto-complete/ac-dict")
;;(ac-config-default)
;;(require 'auto-complete-clang)


(defun insert-tab () (interactive) (insert "\t"))

(defun kill-query ()
  (y-or-n-p "Really kill Emacs? "))
(add-hook 'kill-emacs-query-functions 'kill-query)

; Quickly save current position
(defun save-current-position ()
  "Saves current cursor position in register 0"
  (interactive)
  (point-to-register 0)
  (delete (assoc 1 register-alist) register-alist)
  (message "Position saved."))

;; Kills all them buffers except scratch
;; optained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun nuke-all-buffers ()
  "kill all buffers, leaving *scratch* only"
  (interactive)
  (mapcar (lambda (x) (kill-buffer x))
	  (buffer-list))
  (delete-other-windows))


; Jump to quickly saved position
(defun jump-last-position ()
  "Jump to position saved with previous `save-current-position´,
   OR if run two times with no `save-current-position´ in between,
   jump to the last position it was run from."
  (interactive)
  (if (get-register 0)
      (progn
        (point-to-register 1)
        (jump-to-register 0)
        (delete (assoc 0 register-alist) register-alist)
        (message "Jumped to last saved or last jump-position"))
    (if (get-register 1)
        (progn
          (point-to-register 0)
          (jump-to-register 1)
          (delete (assoc 1 register-alist) register-alist)
          (message "Jumped to last saved or last jump-position"))
      (message "No pos saved"))))


(defun uncomment-region (beg end &optional arg)
   (interactive "*r\np")
   (comment-region beg end (- arg)))

(defun automap-common-hook () 
  (c-set-style "stroustrup") 
  (setq tab-width 4 indent-tabs-mode nil)
  (setq c-tab-always-indent t)
  (c-set-offset 'inline-open '0)
  (c-set-offset 'inline-close '0)  
  (c-set-offset 'innamespace '0)  
  (c-set-offset 'namespace-open '0)
  (c-set-offset 'namespace-close '0))


(add-hook 'c-mode-common-hook 'automap-common-hook)
(add-hook 'c++-mode-common-hook 'automap-common-hook)

(add-hook 'python-mode-hook
          (function (lambda ()
                      (setq python-indent 4))))

(setq c-offsets-alist '((func-decl-cont . 0)))
(setq c-offsets-alist '((inline-open . --)))


; Custom keyboard shortcuts
;(global-set-key [C-return] 'save-current-position)
(global-set-key [C-\[] 'scroll-down)
(global-set-key [M-return] 'goto-line)
(global-set-key [C-tab] 'tab-to-tab-stop)
(global-set-key [C-backspace] 'other-window)
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)
(global-set-key [mouse-4] 'scroll-down)
(global-set-key [mouse-5] 'scroll-up)
(global-set-key "\C-c\C-u" 'uncomment-region)

;(when (fboundp 'next-buffer)            ; Emacs 21+.
;  (global-set-key [C-pause] 'previous-buffer)                                  ; `C-pause'
;  (global-set-key [M-pause] 'next-buffer))                                     ; `M-pause'


; Default font
;(set-default-font "-misc-fixed-medium-r-*-*-*-120-*-*-*-*-*-*")
(set-default-font "-unknown-Liberation Mono-normal-normal-semicondensed-*-12-*-*-*-c-0-iso10646-1")
;(set-default-font "-unknown-DejaVu Sans Mono-bold-normal-normal-10-12-10-10-100-m-0-iso10646-1")
(defconst my-fg "White")
(defconst my-bg "Black")
(defconst my-mg "CornflowerBlue")
;(defconst my-mg "SteelBlue4")

;(set-default-font "-*-Fixedsys-normal-r-*-*-17-102-*-*-c-*-*-ansi-") ;; 19.34.4
;(set-frame-width (selected-frame) 81) ; width not picked up on 1st frame
;(set-frame-height (selected-frame) 36) ; make it taller than default, too
;(set-face-background 'modeline my-mg)
;(set-face-foreground 'modeline my-fg)
(set-face-background 'region my-mg)
(set-face-background 'highlight my-fg)
(set-face-foreground 'highlight my-bg)

;(set-background-color "#F2ECE3")
;(set-face-background 'default "#F2ECE3")
;(set-face-background 'fringe "#E2DCD3")

;(set-background-color "#102030")
;(set-face-background 'default "#102030")
;(set-face-background 'fringe "#102030")


; Syntax highlighting options
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(border ((t (:background "black" :width expanded))))
 '(font-lock-builtin-face ((((class color) (background light)) (:foreground "DarkGreen"))))
 '(font-lock-comment-face ((((class color) (background light)) (:foreground "DarkRed"))))
 '(font-lock-constant-face ((((class color) (background light)) (:foreground "SeaGreen"))))
 '(font-lock-function-name-face ((((class color) (background light)) (:foreground "Red"))))
 '(font-lock-keyword-face ((((class color) (background light)) (:foreground "Blue"))))
 '(font-lock-preprocessor-face ((((class color) (background light)) (:foreground "DarkGreen"))))
 '(font-lock-reference-face ((((class color) (background light)) (:foreground "Red"))))
 '(font-lock-string-face ((((class color) (background light)) (:foreground "SteelBlue"))))
 '(font-lock-type-face ((((class color) (background light)) (:foreground "ForestGreen"))))
 '(font-lock-variable-name-face ((((class color) (background light)) (:foreground "Purple")))))

;; ;Syntax highdarking options
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(border ((t (:background "black" :width expanded))))
;;  '(font-lock-builtin-face ((((class color) (background dark)) (:foreground "DarkGreen"))))
;;  '(font-lock-comment-face ((((class color) (background dark)) (:foreground "DarkRed"))))
;;  '(font-lock-constant-face ((((class color) (background dark)) (:foreground "SeaGreen"))))
;;  '(font-lock-function-name-face ((((class color) (background dark)) (:foreground "Red"))))
;;  '(font-lock-keyword-face ((((class color) (background dark)) (:foreground "Blue"))))
;;  '(font-lock-preprocessor-face ((((class color) (background dark)) (:foreground "DarkGreen"))))
;;  '(font-lock-reference-face ((((class color) (background dark)) (:foreground "Red"))))
;;  '(font-lock-string-face ((((class color) (background dark)) (:foreground "SteelBlue"))))
;;  '(font-lock-type-face ((((class color) (background dark)) (:foreground "ForestGreen"))))
;;  '(font-lock-variable-name-face ((((class color) (background dark)) (:foreground "Purple")))))



; GUI options
(global-font-lock-mode t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(setq font-lock-maximum-decoration t)
(setq gdb-many-windows t)

; Misc options
(setq scroll-step 1)
(setq next-line-add-newlines nil)

;; enable/disable visual feedback on selections
(setq transient-mark-mode nil)

;; default to better frame titles
(setq frame-title-format (concat  "%b - emacs@" system-name))

(put 'upcase-region 'disabled nil)

(show-paren-mode 1)

;;(c-set-style stroustrup)

(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))
;;(add-to-list 'auto-mode-alist '("\.ltst" . sh-mode))

;; enable/disable visual feedback on selections
(setq lpr-command "cupsdoprint")
(setq printer-name "l2copier")
(setq ps-lpr-command "cupsdoprint")
(setq ps-printer-name "l2copier")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(tab-width 4))

(defun fullscreen ()
       (interactive)
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
(global-set-key [f11] 'fullscreen)


(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "/home/users/laan/dbn-clf/bin/epylint" (list local-file))))
  
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

(global-set-key [C-kp-subtract] 'flymake-display-err-menu-for-current-line)
