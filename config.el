;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "ddubl"
      user-mail-address "danwalterlink@gmail.com")
(add-to-list 'default-frame-alist
             '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist
             '(ns-appearance . light))

(global-auto-revert-mode t)

(add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode)
(add-hook! 'after-init-hook (lambda ()
    (when (fboundp 'auto-dim-other-buffers-mode)
        (auto-dim-other-buffers-mode t))))
(add-hook! 'org-mode-hook (company-mode -1))
(add-hook! 'org-capture-mode-hook (company-mode -1))

(setq
 display-line-numbers-type t
 doom-theme 'doom-one
 doom-font (font-spec :family "Cascadia Mono PL" :size 24 :weight 'light)
 doom-big-font (font-spec :family "Cascadia Mono PL" :size 36)
 doom-variable-pitch-font (font-spec :family "Fira Code Retina")
 default-directory "~"
 web-mode-markup-indent-offset 2
 web-mode-code-indent-offset 2
 web-mode-css-indent-offset 2
 mac-command-modifier 'meta
 js-indent-level 2
 typescript-indent-level 2
 json-reformat:indent-width 2
 prettier-js-args '("--single-quote")
 projectile-project-search-path '("~/code/" "~/Dropbox/writing")
 dired-dwim-target t
 org-directory "~/org/"
 org-agenda-files "~/org/todoist"
 org-archive-location "~/org/archive"
 org-ellipsis " ▾ "
 org-bullets-bullet-list '("·")
 org-tags-column -80
 org-agenda-files (ignore-errors (directory-files +org-dir t "\\.org$" t))
 org-log-done 'time
 css-indent-offset 2
 org-refile-targets (quote ((nil :maxlevel . 1)))
 org-capture-templates '(("x" "Note" entry
                          (file+olp+datetree "journal.org")
                          "**** [ ] %U %?" :prepend t :kill-buffer t)
                         ("t" "Task" entry
                          (file+headline "tasks.org" "Inbox")
                          "* [ ] %?\n%i" :prepend t :kill-buffer t))
 +org-capture-todo-file "tasks.org"
 org-super-agenda-groups '((:name "Today"
                                  :time-grid t
                                  :scheduled today)
                           (:name "Due today"
                                  :deadline today)
                           (:name "Important"
                                  :priority "A")
                           (:name "Overdue"
                                  :deadline past)
                           (:name "Due soon"
                                  :deadline future)
                           (:name "Big Outcomes"
                                  :tag "bo"))
 todoist-backing-buffer "~/org/todoist"
 TODOIST_TOKEN "b9d59658c38ee24c46854894e041b6ebf4686744")

(add-hook! reason-mode
  (add-hook 'before-save-hook #'refmt-before-save nil t))

(add-hook!
  js2-mode 'prettier-js-mode
  (add-hook 'before-save-hook #'refmt-before-save nil t))

(map! :ne "M-/" #'comment-or-uncomment-region)
(map! :ne "SPC / r" #'deadgrep)
(map! :ne "SPC n b" #'org-brain-visualize)

(after! org
  (set-face-attribute 'org-link nil
                      :weight 'normal
                      :background nil)
  (set-face-attribute 'org-code nil
                      :foreground "#a9a1e1"
                      :background nil)
  (set-face-attribute 'org-date nil
                      :foreground "#5B6268"
                      :background nil)
  (set-face-attribute 'org-level-1 nil
                      :foreground "steelblue2"
                      :background nil
                      :height 1.2
                      :weight 'normal)
  (set-face-attribute 'org-level-2 nil
                      :foreground "slategray2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      :foreground "SkyBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      :foreground "DodgerBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :weight 'normal)
  (set-face-attribute 'org-document-title nil
                      :foreground "SlateGray1"
                      :background nil
                      :height 1.75
                      :weight 'bold)
  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

(after! ruby
  (add-to-list 'hs-special-modes-alist
               `(ruby-mode
                 ,(rx (or "def" "class" "module" "do" "{" "[")) ; Block start
                 ,(rx (or "}" "]" "end"))                       ; Block end
                 ,(rx (or "#" "=begin"))                        ; Comment start
                 ruby-forward-sexp nil)))

(after! web-mode
  (add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode)))

(defun +data-hideshow-forward-sexp (arg)
  (let ((start (current-indentation)))
    (forward-line)
    (unless (= start (current-indentation))
      (require 'evil-indent-plus)
      (let ((range (evil-indent-plus--same-indent-range)))
        (goto-char (cadr range))
        (end-of-line)))))

(add-to-list 'hs-special-modes-alist '(yaml-mode "\\s-*\\_<\\(?:[^:]+\\)\\_>" "" "#" +data-hideshow-forward-sexp nil))

(remove-hook 'enh-ruby-mode-hook #'+ruby|init-robe)

(setq +magit-hub-features t)

(set-popup-rule! "^\\*Org Agenda" :side 'bottom :size 0.90 :select t :ttl nil)
(set-popup-rule! "^CAPTURE.*\\.org$" :side 'bottom :size 0.90 :select t :ttl nil)
(set-popup-rule! "^\\*org-brain" :side 'right :size 1.00 :select t :ttl nil)

(setq org-directory "~/org/")
