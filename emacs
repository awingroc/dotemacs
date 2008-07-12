;; Fonts and cursor
(set-default-font "-apple-profont-medium-r-normal--10-100-72-72-m-100-mac-roman")
(set-background-color "black")
(set-foreground-color "white")
(set-cursor-color     "red")

;; Set encoding to UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Useful key strokes
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-d" 'delete-region)
(global-set-key "\M-p" 'emacs-wiki-change-project)

;; Anti Aliasing
;; (setq mac-allow-anti-aliasing t)
(setq mac-allow-anti-aliasing nil)

;; Frame title : set to buffer name
(setq frame-title-format "Emacs - %f ")
(setq icon-title-format  "Emacs - %b")

;; Editor Preferences
(column-number-mode t) ;; Show column numbers
(tool-bar-mode nil) ;; Disable tool bar
(menu-bar-mode nil) ;; Disable menu bar
(scroll-bar-mode nil) ;; Disable scrollbar
(transient-mark-mode t) ;; Selection highlighting
(setq-default truncate-lines t)
(setq scroll-step 1
      scroll-margin 3
      scroll-conservatively 10000) ;; Scrolling 
(show-paren-mode t) ;; Highlight parens 
(setq show-paren-style 'parentheses) ;; Shor parens
(blink-cursor-mode nil) ;; Disable blinking of cursor
(fset 'yes-or-no-p 'y-or-n-p) ;; Alias Y and N
(setq message-log-max 100) ;; Set log buffer size
;; (resize-minibuffer-mode 1) ;; Resize buffer depending on text
(follow-mode t) ;; Easier editing of longs files
(setq inhibit-startup-message t) ;; Disable start up message
(setq search-highlight t) ;; Highlight search results
(setq kill-whole-line t) ;; Kill whole line
(setq backup-inhibited t) ;; Never backup
(setq column-number-mode t) ;; Show column numbers
(setq line-number-mode 1) ;; Show line numbers
(setq-default indent-tabs-mode nil) ;; Use spaces for tabs
(setq visible-bell t) ;; Visable bells
;; (kill-buffer "*scratch*") ;; Kill default scratch buffer
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; Extras
(add-to-list 'load-path "~/.site-lisp/lisp")
(require 'pabbrev)

;; Twitter
(require 'twittering-mode)
(setq twittering-username "wnoronha")
(setq twittering-password "oiu987")

;; Cursor Preferences
(cond (window-system
       (progn
         (setq default-frame-alist
               (append default-frame-alist
                       '((cursor-type . bar)
                         )))
         (setq initial-frame-alist
               '( (cursor-type . bar)
                  )))))

;; Edit .emacs shortcut
(defun dot-emacs ()
  "Visit .emacs"
  (interactive)
  (find-file "~/.emacs"))

;; ASpell And FlySpell
(setq ispell-program-name "/opt/local/bin/aspell")
(add-hook 'text-mode-hook
          '(lambda()
             (flyspell-mode)
             ))

;; Text Mode
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'text-mode-hook 'longlines-mode)

;; Kill without confirmation
(global-set-key "\C-xk" 'kill-current-buffer)
(defun kill-current-buffer ()
  "Kill the current buffer, without confirmation."
  (interactive)
  (kill-buffer (current-buffer)))

;; Google Search
(defun search-google ()
  "Prompt for a query in the minibuffer, launch the web browser and query google."
  (interactive)
  (let ((search (read-from-minibuffer "Google Search: ")))
    (browse-url (concat "http://www.google.com/search?q=" search))))

;; Remove hard wrapped endings
(defun remove-hard-wrap-paragraph () 
  "Replace newline chars in current paragraph by single spaces."
  (interactive) 
  (let ((fill-column 90002000)) 
    (fill-paragraph nil)))

(defun remove-hard-wrap-region (start end)
  "Replace newline chars in region by single spaces." 
  (interactive "r")
  (let ((fill-column 90002000)) 
    (fill-region start end)))

(global-set-key (kbd "M-Q") 'remove-hard-wrap-paragraph)

(defun toggle-truncate-lines ()
"Toggle the variable truncate-lines between true and false"
(interactive) 
   (if (eq truncate-lines 't) 
     (set-variable 'truncate-lines nil)
     (set-variable 'truncate-lines 't)
    )
  )
(global-set-key (kbd "<f7>") 'toggle-truncate-lines)

;; Ruby Mode
(add-to-list 'load-path "~/.site-lisp/ruby-mode")
(require 'ruby-mode)
(require 'ruby-electric)

(defun ruby-eval-buffer () (interactive)
    "Evaluate the buffer with ruby."
    (shell-command-on-region (point-min) (point-max) "ruby"))

(defun my-ruby-mode-hook ()
  (setq standard-indent 2)
  (pabbrev-mode t)
  (ruby-electric-mode t)
  (define-key ruby-mode-map "\C-c\C-a" 'ruby-eval-buffer))
(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)

(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

;; Rinari Mode (Rails)
(add-to-list 'load-path "~/.site-lisp/rinari")
(add-to-list 'load-path "~/.site-lisp/rinari/rhtml")

(defun my-rhtml-mode-hook ()
  (auto-fill-mode -1)
  (flyspell-mode -1)
  (longlines-mode -1))
(add-hook 'rhtml-mode-hook 'my-rhtml-mode-hook)

(require 'rinari)
(setq auto-mode-alist (cons '("\\.rhtml\\'" . rhtml-mode) auto-mode-alist))

;; PHP Mode
(add-to-list 'load-path "~/.site-lisp/php-mode")
(require 'php-mode)

;; HTML Mode 

;; Javascript Mode

;; Erlang Mode
;; This is needed for Erlang mode setup
(setq erlang-root-dir "/usr/local/lib/erlang")
(setq load-path (cons "/usr/local/lib/erlang/lib/tools-2.6.1/emacs" load-path))
(setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
(require 'erlang-start)

;; This is needed for Distel setup
(let ((distel-dir "/Users/warren/.site-lisp/distel/elisp"))
  (unless (member distel-dir load-path)
    ;; Add distel-dir to the end of load-path
    (setq load-path (append load-path (list distel-dir)))))

(require 'distel)
(distel-setup)

;; Erlang customizations
(add-hook 'erlang-mode-hook
	  (lambda ()
	    ;; when starting an Erlang shell in Emacs, default in the node name
	    (setq inferior-erlang-machine-options '("-sname" "emacs"))
	    ;; add Erlang functions to an imenu menu
	    (imenu-add-to-menubar "imenu")))

;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(("\C-\M-i"   erl-complete)
    ("\M-?"      erl-complete)	
    ("\M-."      erl-find-source-under-point)
    ("\M-,"      erl-find-source-unwind) 
    ("\M-*"      erl-find-source-unwind) 
    )
  "Additional keys to bind when in Erlang shell.")

(add-hook 'erlang-shell-mode-hook
	  (lambda ()
	    ;; add some Distel bindings to the Erlang shell
	    (dolist (spec distel-shell-keys)
	      (define-key erlang-shell-mode-map (car spec) (cadr spec)))))


;; Slime
(setq inferior-lisp-program "/opt/local/bin/sbcl")
(add-to-list 'load-path "~/.site-lisp/slime")
(require 'slime)
(slime-setup)

