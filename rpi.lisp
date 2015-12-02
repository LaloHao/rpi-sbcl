(cl:defpackage "RPI" (:use "CL" "SB-ALIEN" "SB-C-CALL"))
(cl:in-package "RPI")

(declaim (inline input_gpio))
(define-alien-routine input_gpio void
  (port int))
(defun set-input (port)
  (input_gpio port))

(declaim (inline output_gpio))
(define-alien-routine output_gpio void
  (port int))
(defun set-output (port)
  (output_gpio port))

(declaim (inline set_gpio))
(define-alien-routine set_gpio void
  (port int)
  (value int))
(defun set-gpio (port value)
  (set_gpio port value))

(declaim (inline set_gpio_low))
(define-alien-routine set_gpio_low void
  (port int))
(defun set-gpio-low (port)
  (set_gpio_low port))

(declaim (inline set_gpio_high))
(define-alien-routine set_gpio_high void
  (port int))
(defun set-gpio-high (port)
  (set_gpio_high port))

(declaim (inline read_gpio))
(define-alien-routine read_gpio int
  (port int))
(defun read-gpio (port)
  (ash (read_gpio port) (- port)))
