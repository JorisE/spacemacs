;;; packages.el --- mu4e Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq mu4e-packages
      '(
        (mu4e :location site)
        mu4e-alert
        mu4e-maildirs-extension
        evil-mu4e
        ))

(defun mu4e/init-mu4e ()
  (use-package mu4e
    :commands (mu4e mu4e-compose-new)
    :init
    (progn
      (spacemacs/set-leader-keys "a M" 'mu4e)
      (global-set-key (kbd "C-x m") 'mu4e-compose-new))
    :config
    (progn
      (setq mu4e-completing-read-function 'completing-read)

      (add-to-list 'mu4e-view-actions
                   '("View in browser" . mu4e-action-view-in-browser) t)

      (when mu4e-account-alist
        (add-hook 'mu4e-compose-pre-hook 'mu4e/set-account)
        (add-hook 'message-sent-hook 'mu4e/mail-account-reset)))))

(defun mu4e/init-mu4e-alert ()
  (use-package mu4e-alert
    :defer t
    :init (with-eval-after-load 'mu4e
            (when mu4e-enable-notifications
              (mu4e-alert-enable-notifications))
            (when mu4e-enable-mode-line
              (mu4e-alert-enable-mode-line-display)))))

(defun mu4e/init-mu4e-maildirs-extension ()
  (use-package mu4e-maildirs-extension
    :defer t
    :init (with-eval-after-load 'mu4e (mu4e-maildirs-extension-load))))

(defun mu4e/post-init-org ()
  ;; load org-mu4e when org is actually loaded
  (with-eval-after-load 'org (require 'org-mu4e nil 'noerror)))


(defun mu4e/init-evil-mu4e()
  (use-package evil-mu4e))
