(use srfi-19)

(set-default-bar-length! 1)
(set-default-bar-characters! 'horizontal)

(define (my-line)
  (i3-make-status
   (i3-make-segment
    (as-bar (get-cpu))
    color: 'red)
   (i3-make-segment
    (as-bar (get-mem-used))
    color: 'yellow)
   (if (battery-exists?)
       (i3-make-segment
        (list
         (as-bar (get-battery-charge))
         (get-battery-status)
         (as-time (get-battery-time)))
        color: 'blue)
       #f)
   (i3-make-segment (format-date "~1 ~T" (current-date)))))

(set-make-line! my-line)
