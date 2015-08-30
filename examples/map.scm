(define double
  (lambda (n) (* n 2)))

(define map
  (lambda (fn lst)
    (if (null? lst)
        lst
        (cons (fn (car lst)) (map fn (cdr lst))))))

(map double '(1 2 3))
