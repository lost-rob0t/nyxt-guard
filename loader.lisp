(in-package #:nyxt-user)

(let* ((data-home
         (uiop:ensure-directory-pathname
          (or (uiop:getenv "XDG_DATA_HOME")
              (merge-pathnames ".local/share/" (user-homedir-pathname)))))
       (source
         (merge-pathnames "nyxt-guard/src/nyxt-guard.lisp" data-home)))
  (unless (probe-file source)
    (error "nyxt-guard source not found at ~a" source))
  (nyxt::load-lisp source))
