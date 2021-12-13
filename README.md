# Value Threading for Common Lisp

The `threading` package is a set of threading macros for Common Lisp. While the implementation differs, this code took heavy inspiration from Racket's threading library: [https://docs.racket-lang.org/threading/index.html](https://docs.racket-lang.org/threading/index.html).

## Quickstart

Threading is the process of passing return values from one function to the next. For example:

    CL-USER > (~> 10 (- 20) (+ 3))
    -7

The initial value was passed as the head parameter to the expanded forms of `(- 20)` and `(+ 3)`. The above would be equivalent to:

    CL-USER > (+ (- 10 20) 3)
    -7

If you'd like the value to be threaded as the tail parameter, use `~>>` instead:

    CL-USER > (~>> 10 (- 20) (+ 3))
    13

The above would be equivalent to:

    CL-USER > (+ 3 (- 20 10))
    13

## Macros

The following macros are defined by the `threading` package:

    (~> x &rest forms)
    (~>> x &rest forms)

Additionally, there are two more macros:

    (and~> x &rest forms)
    (and~>> x &rest forms)

These are identical except that - if at any time one of the forms returns `nil` - threading ceases and `nil` is returned.

That's it!
