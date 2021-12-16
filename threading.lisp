;;;; Value threading macros for Common Lisp
;;;;
;;;; Copyright (c) Jeffrey Massung
;;;;
;;;; This file is provided to you under the Apache License,
;;;; Version 2.0 (the "License"); you may not use this file
;;;; except in compliance with the License.  You may obtain
;;;; a copy of the License at
;;;;
;;;;    http://www.apache.org/licenses/LICENSE-2.0
;;;;
;;;; Unless required by applicable law or agreed to in writing,
;;;; software distributed under the License is distributed on an
;;;; "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
;;;; KIND, either express or implied.  See the License for the
;;;; specific language governing permissions and limitations
;;;; under the License.
;;;;

(defpackage :boost-threading
  (:use :cl)
  (:export
   #:~>
   #:~>>
   #:and~>
   #:and~>>))

(in-package :boost-threading)

;;; ----------------------------------------------------

(defmacro ~> (x &rest forms)
  "Thread a value (x) through forms as the first argument."
  (if (null forms)
      x
    (destructuring-bind (f &rest tail-args)
        (car forms)
      `(~> (,f ,x ,@tail-args) ,@(cdr forms)))))

;;; ----------------------------------------------------

(defmacro ~>> (x &rest forms)
  "Thread a value (x) through forms as the final argument."
  (if (null forms)
      x
    (destructuring-bind (f &rest head-args)
        (car forms)
      `(~>> (,f ,@head-args ,x) ,@(cdr forms)))))

;;; ----------------------------------------------------

(defmacro and~> (x &rest forms)
  "Like ~>, but if any intermediate expression returns nil stop."
  (if (null forms)
      x
    (destructuring-bind (f &rest tail-args)
        (car forms)
      (let ((value (gensym)))
        `(let ((,value (,f ,x ,@tail-args)))
           (when ,value
             (and~> ,value ,@(cdr forms))))))))

;;; ----------------------------------------------------

(defmacro and~>> (x &rest forms)
  "Like ~>>, but if any intermediate expression returns nil stop."
  (if (null forms)
      x
    (destructuring-bind (f &rest head-args)
        (car forms)
      (let ((value (gensym)))
        `(let ((,value (,f ,@head-args ,x)))
           (when ,value
             (and~>> ,value ,@(cdr forms))))))))
