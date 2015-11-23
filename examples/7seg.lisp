(load-shared-object "/home/otserv/dev/rpi-sbcl/rpi.so")
(load "/home/otserv/dev/rpi-sbcl/rpi.fasl")

(defvar pines-del-display '(4 17 27 22 18 23 24))
(mapc 'rpi::set-output pines-del-display)
(mapc 'rpi::set-gpio-low pines-del-display)

(defvar segmentos-del-display '((a . 4)
                           (b . 17)
                           (c . 27)
                           (d . 22)
                           (e . 18)
                           (f . 23)
                           (g . 24)))

(defun encender-segmentos (segmentos)
  (loop for segmento in segmentos
     when (cdr (assoc segmento segmentos-del-display))
     do
       (rpi::set-gpio (cdr (assoc segmento segmentos-del-display)) 1)))

(defun mostrar-en-display (numero)
  (mapc (lambda (port) (rpi::set-gpio port 0)) pines-del-display)
  (encender-segmentos (cond ((= numero 0) '(a b c d e f))
                         ((= numero 1) '(b c))
                         ((= numero 2) '(a b d e g))
                         ((= numero 3) '(a b c d g))
                         ((= numero 4) '(b c f g))
                         ((= numero 5) '(a c d f g))
                         ((= numero 6) '(a c d e f g))
                         ((= numero 7) '(a b c))
                         ((= numero 8) '(a b c d e f g))
                         ((= numero 9) '(a b c d f g)))))

(loop for i from 0 to 9 do
     (mostrar-en-display i)
     (sleep 1))
