(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")

(require 'mu4e)


(global-set-key  (kbd "C-c m") 'mu4e)
  

;; Dummy to be overriden by context
(setq
 send-mail-function 'smtpmail-send-it
 message-send-mail-function 'smtpmail-send-it)


(require 'cl)
(defun my-make-mu4e-context (name address server port ssltype signature)
  "Return a mu4e context named NAME with :match-func matching
  its ADDRESS in From or CC fields of the parent message. The
  context's `user-mail-address' is set to ADDRESS and its
  `mu4e-compose-signature' to SIGNATURE."
  (lexical-let ((addr-lex address))
    (make-mu4e-context :name name
		       :vars `((user-mail-address . ,address)
			       ( user-full-name       . "Nikos Patikas" )
			       ( mu4e-compose-signature . ,signature)
			       ( smtpmail-smtp-server   . ,server)
			       ( smtpmail-smtp-service  . ,port)
			       ( smtpmail-stream-type   . ,ssltype)
			       )
		       :match-func
		       (lambda (msg)
			 (when msg
			   (or (mu4e-message-contact-field-matches msg :to addr-lex)
			       (mu4e-message-contact-field-matches msg :cc addr-lex)))))))

(setq professional-signature "--------------------------------\n Nikolaos Patikas\n PhD student/Bioinformatician \n Metzakopian lab\n UK Dementia Research Institute\n University of Cambridge\n\n Web: https://ukdri.ac.uk")
;; Add my contexts

(setq mu4e-contexts
      `( , (my-make-mu4e-context
	    "medschl"
	    "np504@medschl.cam.ac.uk"
	    "127.0.0.1"
	    1025
	    'plain
	    professional-signature)
	   
           , (my-make-mu4e-context
	      "sanger"
	      "np13@sanger.ac.uk"
	      "127.0.0.1"
	      1026
	      'plain
	      professional-signature)
	   
	   , (my-make-mu4e-context
	      "cambridge"
	      "np504@cam.ac.uk"
	      "127.0.0.1"
	      1027
	      'plain
	      professional-signature)
	   ))




(setq
 mu4e-context-policy 'pick-first ;; start with the first (default) context; 
 mu4e-compose-context-policy nil ;; compose with the current context if no context matches;
)




;; Make html messages view properly in a dark background
(setq shr-color-visible-luminance-min 80)


(setq
 message-kill-buffer-on-exit t
 mu4e-view-show-images t
 mu4e-image-max-width 1920
 ;;mu4e-html2text-command "w3m -dump -T text/html"
 ;;w3m-command "/usr/bin/w3m"
 mu4e-view-prefer-html t
 )




;; (defun mu4e-action-view-in-w3m ()
;;   "View the body of the message in emacs w3m."
;;   (interactive)
;;   (w3m-browse-url (concat "file://"
;;               (mu4e-write-body-to-html (mu4e-message-at-point t)))))


(setq
       mu4e-get-mail-command "/usr/bin/mbsync -aV"   ;; or fetchmail, or ...
       mu4e-update-interval nil)


(defun mu4e-action-view-in-w3m (msg)
  "View the body of the message in emacs w3m."
  (interactive)
  (w3m-browse-url (concat "file://"
			  (mu4e~write-body-to-html msg))))


(defun mu4e-action-view-in-w3m (msg)
  "View the body of MSG in a w3m."
  (w3m-browse-url (concat "file://"
                      (mu4e~write-body-to-html msg))))


(add-to-list 'mu4e-view-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t)
(add-to-list 'mu4e-view-actions '("W3M-view" . mu4e-action-view-in-w3m) t)


(setq
       mu4e-sent-folder   "/folders/sent"       ;; folder for sent messages
       mu4e-drafts-folder "/folders/drafts"     ;; unfinished messages
       mu4e-trash-folder  "/folders/trash"      ;; trashed messages
       mu4e-refile-folder "/folders/archive")




;;(setq mu4e-html2text-command "w3m -dump -T text/html")


(add-hook 'mu4e-view-mode-hook
  (lambda()
    ;; try to emulate some of the eww key-bindings
    (local-set-key (kbd "<tab>") 'shr-next-link)
    (local-set-key (kbd "<backtab>") 'shr-previous-link)
    ))


(setq work-inbox "maildir:/cambridge/Inbox OR maildir:/medschl/Inbox OR maildir:/sanger/Inbox")

(setq personal-inbox "maildir:gmail/Inbox ")


(add-to-list 'mu4e-bookmarks
  '( :name  "Work today's inbox"
     :query (concat work-inbox " AND (date:today..now OR flag:flagged)")
     :key   ?w))


(add-to-list 'mu4e-bookmarks
  '( :name  "Work current inbox"
     :query work-inbox
     :key   ?l))




(add-to-list 'mu4e-bookmarks
  '( :name  "Personal inbox"
     :query personal-inbox
     :key   ?p))

(add-to-list 'mu4e-bookmarks
  '( :name  "Attachments"
     :query "flag:attach"
     :key   ?a))



(setq mu4e-attachment-dir
  (lambda (fname mtype)
    (cond
      ((and fname (string-match "\\.pdf$" fname))  "~/docs/pdf")
      ;; ... other cases  ...
      (t "~/Downloads"))))




