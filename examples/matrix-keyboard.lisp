(load-shared-object "/home/otserv/dev/rpi-sbcl/rpi.so")
(load "/home/otserv/dev/rpi-sbcl/rpi.fasl")

(defvar keyboard-outputs '(4 17 27 22))
(mapc 'rpi::set-output keyboard-outputs)

(defvar keyboard-inputs '(18 23 24 25))
(mapc 'rpi::set-input keyboard-inputs)

(defvar keyboard-keys '((1 2 3 A)
                   (4 5 6 B)
                   (7 8 9 C)
                   (T 0 S D)))

(defun next-key ()
  (let ((i 0)
        (j 0))
    (mapc 'rpi::set-gpio-low keyboard-outputs)
    (rpi::set-gpio-high (nth 0 keyboard-outputs))
    (loop (if (= 1 (rpi::read-gpio (nth j keyboard-inputs)))
              (return (nth j (nth i keyboard-keys))))
       (incf j)
       (when (= j 4)
         (setf j 0)
         (rpi::set-gpio-low (nth i keyboard-outputs))
         (incf i)
         (when (= i 4)
           (setf i 0))
         (rpi::set-gpio-high (nth i keyboard-outputs))
         ;; (sleep 0.1)
         )
       (sleep 0.05))))

(defun pressed-keys ()
  (loop for i in keyboard-outputs
     do (rpi::set-gpio-high i)
     collect (loop for j in keyboard-inputs
                collect (rpi::read-gpio j))
     do (rpi::set-gpio-low i)))

(defun parse-keys (keys)
  (let ((keys (loop for i from 0 to 3
               collect (loop for j from 0 to 3
                          when (eq (nth j (nth i keys)) 1)
                          collect (nth j (nth i keyboard-keys))))))
    (reduce #'append (remove-if #'null `(,@keys)))))


(if (eq (next-key) 'A)
   (print "You got lucky this time.")
   (print "Bomb exploded."))

(parse-keys (pressed-keys))
