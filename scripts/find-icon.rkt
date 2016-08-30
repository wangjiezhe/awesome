#! /usr/bin/env racket
#lang racket

(require my-cond)

(define home-dir (find-system-path 'home-dir))

(define xdg-data-dirs
  (cond
    [(getenv "XDG_DATA_DIRS") => (curryr string-split ":")]
    [else '("/usr/local/share" "/usr/share")]))

(define categories
  (list "apps" "places" "devices" "actions" "animations"
        "categories" "emblems" "emotes" "filesystems" "intl"
        "mimetypes" "status" "stock"))

(define sizes
  (list 16 20 22 24 26 32 36 40 48 64 72 96
        128 192 256 384 512 1024))

(define themes
  (list "hicolor" "gnome"))

(define icon-search-path
  (let* ([res (list (build-path home-dir ".icons"))]
         [res (for*/fold ([l res])
                         ([d (in-list xdg-data-dirs)]
                          [t (in-list themes)]
                          [s (in-list sizes)]
                          [c (in-list categories)])
                (cons (build-path d "icons" t (format "~ax~a" s s) c) l))]
         [res (for*/fold ([l res])
                         ([d (in-list xdg-data-dirs)]
                          [t (in-list themes)]
                          [c (in-list categories)])
                (cons (build-path d "icons" t "scalable" c) l))]
         [res (for*/fold ([l res])
                         ([d (in-list xdg-data-dirs)])
                (cons (build-path d "icons") l))]
         [res (for*/fold ([l res])
                         ([d (in-list xdg-data-dirs)]
                          [s (in-list '("mini" "large"))])
                (cons (build-path d "icons" s) l))]
         [res (cons (string->path "/usr/share/pixmaps") res)])
    (for/fold ([l '()])
              ([p (sequence-filter directory-exists? res)])
      (cons p l))))

(define (find-icon name)
  (my-cond
   (for*/cond-clause ([dir (in-list icon-search-path)]
                      [ext (in-list '("" ".png" ".xpm" ".svg"))])
     #:let ([file-path (build-path dir (string-append name ext))])
     [(file-exists? file-path) (path->string file-path)])
   [else #f]))

(module+ main
  (command-line
   #:usage-help "Get icon file name for programs" "Proted from xdg_menu"
   #:args programs
   (for-each displayln (map find-icon programs))))
