(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq delete-auto-save-file t)
(show-paren-mode 1)
(global-linum-mode t)
(add-to-list'default-frame-alist'(foreground-color . "white"))
(add-to-list'default-frame-alist'(background-color . "black"))
(setq scroll-conservatively 1)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
;;(setq-default tab-width 4)
(tool-bar-mode -1)
(menu-bar-mode -1)
(add-hook 'c++-mode-hook
          '(lambda ()
             (c-set-offset 'defun-open '0)
             (c-set-offset 'defun-close '0)
             (c-set-offset 'defun-block-intro '2)
             (c-set-offset 'statement-block-intro '2)
             (c-set-offset 'statement-case-intro '2)
             (c-set-offset 'substatement '2)
						 (c-set-offset 'substatement-open '0)
						 (c-set-offset 'substatement-close '0)
						 (c-set-offset 'inclass '2)
             ))
;;;python

(add-to-list 'load-path "~/.emacs.d/python-mode")
(require 'python-mode)
(setq auto-mode-alist (cons '("\\.py\\'" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))

(add-hook 'python-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq python-indent 4)
             (setq tab-width 4)))
(add-to-list 'load-path "~/.emacs.d/py-autopep8.el")
(require 'py-autopep8)
(define-key python-mode-map (kbd "C-c F") 'py-autopep8)
(define-key python-mode-map (kbd "C-c f") 'py-autopep8-region)
(add-hook 'before-save-hook 'py-autopep8-before-save)

(add-hook 'file-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/.pyenv/shims/pyflakes" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

(defun flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'hepl-echo)))
      (if help (message "%s" help)))))
(add-hook 'post-command-hook 'flymake-show-help)

(custom-set-faces
 '(flymake-errline ((((class color)) (:background "red")))))

(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/yasnippet/mysnippets"
        "~/.emacs.d/yasnippet/snippets"))

(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

(yas-global-mode 1)

