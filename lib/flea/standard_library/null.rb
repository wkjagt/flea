Flea::StandardLibrary.add <<-SOURCE
(define null?
  (lambda (l_arg)
    (equal? l_arg '())))
SOURCE
