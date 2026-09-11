(in-package #:nyxt-user)

(defun nyxt-guard-data-root ()
  (merge-pathnames
   "nyxt-guard/"
   (uiop:ensure-directory-pathname
    (or (uiop:getenv "XDG_DATA_HOME")
        (merge-pathnames ".local/share/" (user-homedir-pathname))))))

(defun nyxt-guard-modules-root ()
  (merge-pathnames "modules/" (nyxt-guard-data-root)))

(defun nyxt-guard-load-module (name)
  (let ((path (merge-pathnames
               (format nil "~a.lisp" (string-downcase (string name)))
               (nyxt-guard-modules-root))))
    (unless (probe-file path)
      (error "nyxt-guard module not found: ~a" path))
    (nyxt::load-lisp path)))

(defun nyxt-guard-load-all-modules ()
  (dolist (path (sort (copy-list (directory (merge-pathnames "*.lisp" (nyxt-guard-modules-root))))
                      #'string<
                      :key #'namestring))
    (nyxt::load-lisp path)))

(nyxt-guard-load-all-modules)
