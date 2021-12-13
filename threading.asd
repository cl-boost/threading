(defpackage :cl-batteries/threading-asd
  (:use :cl :asdf))

(in-package :cl-batteries/threading-asd)

(defsystem :cl-batteries/threading
  :name "cl-batteries/threading"
  :version "1.0"
  :author "Jeffrey Massung"
  :license "Apache 2.0"
  :description "Value threading macros for Common Lisp."
  :serial t
  :components ((:file "threading")))
