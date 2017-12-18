;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname q2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require rackunit)
(require "extras.rkt")
(provide
 lit
 literal-value
 var
 variable-name
 op
 operation-name
 call
 call-operator
 call-operands
 block
 block-var
 block-rhs
 block-body
 literal?
 variable?
 operation?
 call?
 block?
 variables-defined-by
 variables-used-by
 constant-expression?
 constant-expression-value)


          
;;; An ArithmeticExpression is one of
;;;     -- a Literal
;;;     -- a Variable
;;;     -- an Operation
;;;     -- a Call
;;;     -- a Block
;;;
;;; OBSERVER TEMPLATE:
;;; arithmetic-expression-fn : ArithmeticExpression -> ??
#;
(define (arithmetic-expression-fn exp)
  (cond ((literal? exp) ...)
        ((variable? exp) ...)
        ((operation? exp) ...)
        ((call? exp) ...)
        ((block? exp) ...)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;REPRESENTATION : A Literal struct can be represented as
;;(make-literal value)
;; with the following fields-
;;value : Real number

;;IMPLEMENTATION:
(define-struct literal (value))

;;CONSTRUCTOR TEMPLATE:
;;(make-literal real)

;;OBSERVER TEMPLATE :
;;;; literal-fn : Literal -> ?
;;(define (literal-fn l)
;; (...
;;  (literal-value l)))
 

;;; lit : Real -> Literal
;;; GIVEN: a real number
;;; RETURNS: a literal that represents that number
;;; EXAMPLE: (lit 4)->(make-literal 4)
;;;STRATEGY: Use the constructor template for Literal

(define(lit x)
  (make-literal x))

;;TESTS:
(begin-for-test
  (check-equal? (lit 5)(make-literal 5)"(make-literal 5)should be returned")
  (check-equal? (lit 16.2)(make-literal 16.2 )
                "(make-literal 16.2)should be returned"))

;;; literal-value : Literal -> Real
;;; GIVEN: a literal
;;; RETURNS: the number it represents
;;; EXAMPLE: (literal-value (lit 17.4)) => 17.4
;;STRATEGY : Function is made when the struct is defined
;;TESTS:
(begin-for-test
  (check-equal?(literal-value (lit 14))14 "14 should be returned")
  (check-equal?(literal-value (lit 14.5))14.5 "14.5 should be returned"))

;;REPRESENTATION : A Variable struct can be represented as
;;(make-variable name)
;; with the following fields-
;;name : String represents name of the variable ( Any string will do)

;;IMPLEMENTATION:
(define-struct variable (name))

;;CONSTRUCTOR TEMPLATE:
;;(make-variable string)

;;OBSERVER TEMPLATE :
;;;; variable-fn : Variable -> ?
;;(define (variable-fn l)
;; (...
;;  (variable-name l)))
 
;;; var : String -> Variable
;;; GIVEN: a string
;;; WHERE: the string begins with a letter and contains
;;;     nothing but letters and digits
;;; RETURNS: a variable whose name is the given string
;;; EXAMPLE:(var "fgf")->(make-variable "fgf")
;;;STRATEGY: Use the constructor template for Variable

(define(var s)
  (make-variable s))
;;TESTS:
(begin-for-test
  (check-equal? (var "x5")(make-variable "x5"))
  (check-equal? (var "tpk")(make-variable "tpk")))
          
;;; variable-name : Variable -> String
;;; GIVEN: a variable
;;; RETURNS: the name of that variable
;;; EXAMPLE: (variable-name (var "x15")) => "x15"
;;STRATEGY : Function is made when the struct is defined
;;TESTS:
(begin-for-test
  (check-equal?(variable-name (var "x5"))"x5" "x5 should be returned")
  (check-equal?(variable-name (var "tpk"))"tpk" "tpk should be returned"))

;;REPRESENTATION : An Operation struct can be represented as
;;(make-operation name)
;; with the following fields-
;;name : String represents name of operation.
;;; An OperationName is represented as one of the following strings:
;;;     -- "+"      (indicating addition)
;;;     -- "-"      (indicating subtraction)
;;;     -- "*"      (indicating multiplication)
;;;     -- "/"      (indicating division)
;;;
;;; OBSERVER TEMPLATE:
;;; operation-name-fn : OperationName -> ??
#;
(define (operation-name-fn op)
  (cond ((string=? op "+") ...)
      ((string=? op "-") ...)
        ((string=? op "*") ...)
        ((string=? op "/") ...))) 


;;IMPLEMENTATION:
(define-struct operation (name))

;;CONSTRUCTOR TEMPLATE:
;;(make-operation string)

;;OBSERVER TEMPLATE :
;;;; operation-fn : Operation -> ?
;;(define (operation-fn l)
;; (...
;;  (operation-string l)))
          
;;; op : OperationName -> Operation
;;; GIVEN: the name of an operation
;;; RETURNS: the operation with that name
;;; EXAMPLES: (op "*")->(make-operation "*")
;;;STRATEGY: Use the constructor template for Operation
(define(op o)
  (make-operation o))
;;TESTS:
(begin-for-test
  (check-equal? (op "+")(make-operation "+"))
  (check-equal? (op "/")(make-operation "/")))

          
;;; operation-name : Operation -> OperationName
;;; GIVEN: an operation
;;; RETURNS: the name of that operation
;;; EXAMPLES:
;;;     (operation-name (op "+")) => "+"
;;;     (operation-name (op "/")) => "/"

;;STRATEGY : Function is made when the struct is defined
;;TESTS:
(begin-for-test
  (check-equal?(operation-name (op "+"))"+" "x5 should be returned")
  (check-equal?(operation-name (op "*"))"*" "tpk should be returned"))

;;;;REPRESENTATION : A Caller struct can be represented as
;;(make-caller x lst)
;; with the following fields-
;;x : ArithmeticExpression 
;;lst : ArithmeticExpressionList

;;IMPLEMENTATION:
(define-struct caller(x lst))

;;CONSTRUCTOR TEMPLATE:
;;(make-caller ArithmeticExpression ArithmeticExpressionList)

;;OBSERVER TEMPLATE :
;;;; caller-fn :Caller -> ?
;;(define (caller-fn l)
;; (...
;;  (caller-x l)
;;(caller-lst l)))
          
;;; call : ArithmeticExpression ArithmeticExpressionList -> Call
;;; GIVEN: an operator expression and a list of operand expressions
;;; RETURNS: a call expression whose operator and operands are as
;;;     given
;;; EXAMPLES: (call (op "-")(list (lit 7) (lit 2.5)))->
;;(make-caller (make-operation "-") (list (make-literal 7) (make-literal 2.5)))
;;;STRATEGY: Use the constructor template for Caller
(define(call oprtr lst1)
  (make-caller oprtr lst1))
;;TESTS:
 (begin-for-test
  (check-equal? (call (op "+")(list (lit 17)))
(make-caller (make-operation "+") (list (make-literal 17))))
  (check-equal? (call (op "/")(list (lit 17)(lit 4)))
(make-caller (make-operation "/") (list (make-literal 17)(make-literal 4)))))
;;; call-operator : Call -> ArithmeticExpression
;;; GIVEN: a call
;;; RETURNS: the operator expression of that call
;;; EXAMPLE: (call-operator (call (op "-")
;;;                          (list (lit 7) (lit 2.5))))
;;;

;;;         => (op "-")
 ;;;STRATEGY : Use the constructor template for Caller
(define(call-operator cal)
  (caller-x cal))
;;TESTS:
  (begin-for-test
  (check-equal? (call-operator(call (op "+")(list (lit 17))))
(make-operation "+"))
  (check-equal? (call-operator(call (op "/")(list (lit 17)(lit 4))))
 (make-operation "/") ))        
;;; call-operands : Call -> ArithmeticExpressionList
;;; GIVEN: a call
;;; RETURNS: the operand expressions of that call
;;; EXAMPLE:
;;;     (call-operands (call (op "-")
;;;                          (list (lit 7) (lit 2.5))))
;;;         => (list (lit 7) (lit 2.5))
 ;;;STRATEGY : Use the constructor template for Caller

(define(call-operands cal)
  (caller-lst cal))
;;TESTS:
(begin-for-test
  (check-equal? (call-operands(call (op "+")(list (lit 17))))
(list (lit 17) ))
  (check-equal? (call-operands(call (op "/")(list (lit 17)(lit 4))))
(list (lit 17) (lit 4)) ))

;;;;REPRESENTATION : A Bloc struct can be represented as
;;(make-bloc v ae ae1)
;; with the following fields-
;;v : Variable which represents the variable of the block
;;ae : ArithmeticExpression which represents the expression of the block
;;ae1 : ArithmeticExpression which represents the expression of the block

;;IMPLEMENTATION:
(define-struct bloc(v ae ae1))

;;CONSTRUCTOR TEMPLATE:
;;(make-block variable Arithmeticexpression Arithmeticexpression)

;;OBSERVER TEMPLATE :
;;;; bloc-fn :Bloc -> ?
;;(define (bloc-fn l)
;; (...
;;  (bloc-v l)
;;(bloc-ae l)
;;(bloc-ae1 l)))
          
;;; block : Variable ArithmeticExpression ArithmeticExpression
;;;             -> ArithmeticExpression
;;; GIVEN: a variable, an expression e0, and an expression e1
;;; RETURNS: a block that defines the variable's value as the
;;;     value of e0; the block's value will be the value of e1
;;; EXAMPLES: (block (var "x5")
;;                       (lit 5)
 ;;                      (call (op "*")
 ;;                           (list (var "x6") (var "x7"))))
;;(make-bloc (make-variable "x5") (make-literal 5)
;;(make-caller (make-operation "*") (list (make-variable "x6")
;;(make-variable "x7"))))
;;;STRATEGY: Use the constructor template for Bloc

(define (block v e0 e1)
  (make-bloc v e0 e1))
;;TESTS:
(begin-for-test
  (check-equal? (block (var "x5")
                       (lit 5)
                       (call (op "*")
                            (list (var "x6") (var "x7"))))
(make-bloc (make-variable "x5") (make-literal 5)
(make-caller (make-operation "*") (list (make-variable "x6")
                                (make-variable "x7")))) )
 (check-equal? (block (var "x5")
                       (block (var "x7")(lit 4)(call (op "*")
                            (list (var "x6") (var "x7"))))
                       (call (op "*")
                            (list (var "x6") (var "x7"))))
(make-bloc
 (make-variable "x5")
 (make-bloc (make-variable "x7") (make-literal 4)
 (make-caller (make-operation "*") (list (make-variable "x6") (make-variable "x7"))))
 (make-caller (make-operation "*") (list (make-variable "x6") (make-variable "x7"))))))

  
;;; block-var : Block -> Variable
;;; GIVEN: a block
;;; RETURNS: the variable defined by that block
;;; EXAMPLE:
;;;     (block-var (block (var "x5")
;;;                       (lit 5)
;;;                       (call (op "*")
;;;                             (list (var "x6") (var "x7")))))
;;;         => (var "x5")
;;;STRATEGY: Use the constructor template for Bloc
(define(block-var b)
  (bloc-v b))
;;TESTS:
(begin-for-test
  (check-equal? (block-var (block(var "x5")
                       (lit 5)
                       (call (op "*")
                            (list (var "x6") (var "x7")))))
(make-variable "x5") )
 (check-equal? (block-var(block (var "x0")
                       (block (var "x7")(lit 4)(call (op "*")
                            (list (var "x6") (var "x7"))))
                       (call (op "*")
                            (list (var "x6") (var "x7")))))
(make-variable "x0")))

          
;;; block-rhs : Block -> ArithmeticExpression
;;; GIVEN: a block
;;; RETURNS: the expression whose value will become the value of
;;;     the variable defined by that block
;;; EXAMPLE:
;;;     (block-rhs (block (var "x5")
;;;                       (lit 5)
;;;                       (call (op "*")
;;;                             (list (var "x6") (var "x7")))))
;;;         => (lit 5)
;;;STRATEGY: Use the constructor template for Bloc
(define(block-rhs b)
  (bloc-ae b))
;;TESTS
(begin-for-test
  (check-equal? (block-rhs (block(var "x5")
                       (lit 5)
                       (call (op "*")
                            (list (var "x6") (var "x7")))))
 (make-literal 5))
 (check-equal? (block-rhs(block (var "x0")
                       (block (var "x7")(lit 4)(call (op "*")
                            (list (var "x6") (var "x7"))))
                       (call (op "*")
                            (list (var "x6") (var "x7")))))
(make-bloc (make-variable "x7") (make-literal 4)
(make-caller (make-operation "*") (list (make-variable "x6") (make-variable "x7"))))))
          
;;; block-body : Block -> ArithmeticExpression
;;; GIVEN: a block
;;; RETURNS: the expression whose value will become the value of
;;;     the block expression
;;; EXAMPLE:
;;;     (block-body (block (var "x5")
;;;                        (lit 5)
;;;                        (call (op "*")
;;;                              (list (var "x6") (var "x7")))))
;;;         => (call (op "*") (list (var "x6") (var "x7")))
;;;STRATEGY: Use the constructor template for Bloc
(define(block-body b)
  (bloc-ae1 b))

;;TESTS
(begin-for-test
  (check-equal? (block-body (block(var "x5")
                       (lit 5)
                       (call (op "*")
                            (list (var "x6") (var "x7")))))
(make-caller (make-operation "*") (list (make-variable "x6") (make-variable "x7"))))
 (check-equal? (block-body(block (var "x0")
                       (block (var "x7")(lit 4)(call (op "*")
                            (list (var "x6") (var "x7"))))
                       (call (op "-")
                            (list (var "x9") (var "x1")))))
 (make-caller (make-operation "-") (list (make-variable "x9") (make-variable "x1")))))

;;; literal?   : ArithmeticExpression -> Boolean
;;; GIVEN: an arithmetic expression
;;; RETURNS: true if and only the expression is literal
;;STRATEGY: Use the constructor template for Literal
;;; EXAMPLES:
;;;   (literal?  (lit 4))->true
;;TESTS
(begin-for-test
  (check-equal? (literal? (lit 7)) true)
  (check-equal? (literal? (var 7)) false) )

;;; variable?  : ArithmeticExpression -> Boolean
;;; GIVEN: an arithmetic expression
;;; RETURNS: true if and only the expression is variable
;;STRATEGY: Use the constructor template for Variable
;;; EXAMPLES:
;;;   (variable?  (var "4"))->true
;;TESTS
(begin-for-test
  (check-equal? (variable? (var "7")) true)
  (check-equal? (variable? (lit 7)) false))
;;; operation? : ArithmeticExpression -> Boolean
;;; GIVEN: an arithmetic expression
;;; RETURNS: true if and only the expression is operation
;;STRATEGY: Use the constructor template for Operation
;;; EXAMPLES:
;;;   (operation?  (op "+"))-> true
;;TESTS
(begin-for-test
  (check-equal? (operation? (op "-")) true)
   (check-equal? (operation? (var "bcvbcv")) false))

;;; call?      : ArithmeticExpression -> Boolean
;;; GIVEN: an arithmetic expression
;;; RETURNS: true if and only the expression is call
;;; EXAMPLES:
;;;   (call?  (call (op "-")
 ;;                           (list (var "x9") (var "x1")))->true
;;STRATEGY: Use the constructor template for Call
(define (call? e)
  (caller? e))

;;TESTS:
(begin-for-test
  (check-equal?(call?(call (op "*")
 (list (var "x6") (var "x7"))))true))

;;; block?     : ArithmeticExpression -> Boolean
;;; GIVEN: an arithmetic expression
;;; RETURNS: true if and only the expression is block
;;; EXAMPLES:
;;;   (block? (block (var "x5")
     ;;                  (lit 5)
       ;;                (call (op "*")
         ;;                   (list (var "x6") (var "x7")))))->true
;;STRATEGY: Use the constructor template for Block
(define (block? bl)
  (bloc? bl))
;;TESTS
(begin-for-test
  (check-equal?(block? (block-body (block(var "x5")
                       (lit 5)
                       (call (op "*")
                            (list (var "x6") (var "x7"))))))false"false should
be returned")

  (check-equal?(block? (block (var "x5")
                       (lit 5)
                       (call (op "*")
                            (list (var "x6") (var "x7")))))true"true should be
returned"))



  

;; A StringList is represented as a list of String.

;; CONSTRUCTOR TEMPLATE AND INTERPRETATION
;; empty                  -- the empty sequence
;; (cons n ns)
;;   WHERE:
;;    n  is a String     -- the first string
;;                           in the sequence
;;    ns is a StringList  -- the rest of the 
;;                           strings in the sequence
;; OBSERVER TEMPLATE:
;; nl-fn : StringList -> ??
;;(define (nl-fn lst)
  ;;(cond
   ;; [(empty? lst) ...]
    ;;[else (... (first lst)
      ;;         (nl-fn (rest lst)))]))
;; An ArithmeticExpressionList is represented as a list of Arithmeticexpressions

;; CONSTRUCTOR TEMPLATE AND INTERPRETATION
;; empty                  -- the empty sequence
;; (cons n ns)
;;   WHERE:
;;    n  is an Arithmeticexpression     -- the first Arithmeticexpression
;;                           in the sequence
;;    ns is a ArithmeticexpressionList -- the rest of the 
;;                           arithmeticexpressions in the sequence

;; OBSERVER TEMPLATE:
;; nl-fn : ArithmeticExpressionList -> ??
;;(define (nl-fn lst)
  ;;(cond
    ;;[(empty? lst) ...]
    ;;[else (... (first lst)
      ;;         (nl-fn (rest lst)))]))

  
 ;;; variables-defined-by : ArithmeticExpression -> StringList
          ;;; GIVEN: an arithmetic expression
          ;;; RETURNS: a list of the names of all variables defined by
          ;;;     all blocks that occur within the expression, without
          ;;;     repetitions, in any order
          ;;; EXAMPLE:
          ;;;     (variables-defined-by
          ;;;      (block (var "x")
          ;;;             (var "y")
          ;;;             (call (block (var "z")
          ;;;                          (var "x")
          ;;;                          (op "+"))
          ;;;                   (list (block (var "x")
          ;;;                                (lit 5)
          ;;;                                (var "x"))
          ;;;                         (var "x")))))
          ;;;  => (list "x" "z") or (list "z" "x")
;;;STRATEGY : Use simpler functions

(define(variables-defined-by  exp)
  (cond
[(literal? exp) null]
[(variable? exp) null]
[(operation? exp) null]
[(call? exp)(check-call exp)]
[(block? exp) (check-block exp)]))

;;check-call:Call->List
;;GIVEN: Call
;;RETURNS:  List of variables  defined by blocks in call
;;STRATEGY : Use the observer template of the ArithmeticExpressionList
;;EXAMPLES: (check-call
   ;;                    (call (block (var "z")
    ;;                                (var "x")
     ;;                               (op "+"))
       ;;                     (list (block (var "x")
         ;;                                 (lit 5)
           ;;                               (var "x"))
             ;;                     (var "x"))))->(list "z" "x")

(define(check-call ex)
 (append
(variables-defined-by(call-operator ex))
        (variables-lst(call-operands ex))empty))
;;TESTS:

(begin-for-test
  (check-equal?(check-call
                       (call (block (var "y")
                                    (var "a")
                                    (op "+"))
                            (list (block (var "b")
                                          (lit 5)
                                          (var "c"))
                                 (var "d"))))
(list "y" "b")"the list with y and b strings should be returned"))

;;variables-lst:ArithmeticExpressionList->List
;;GIVEN: ArithmeticExpressionList of the operation
;;RETURNS:  List of variables  defined by blocks 
;;STRATEGY : Use  the observer template of ArithmeticExpressionList
;;EXAMPLES: (variables-lst
  
       ;;                     (list (block (var "x")
         ;;                                 (lit 5)
           ;;                               (var "x"))
             ;;                     (var "x")))->(list "x")

(define(variables-lst l)
  (cond
 [ (empty? l )null]
[else(append (variables-defined-by(first l))
   (variables-lst(rest l)))]))
;;TESTS:
(begin-for-test
  (check-equal?(variables-lst
                            (list (block (var "b")
                                          (lit 5)
                                          (var "c"))
                                 (var "d")))
(list  "b")"the list with  b string should be returned"))
  
;;check-block:Block->List
;;GIVEN: Block
;;RETURNS: List of variables  defined by blocks 
;;STRATEGY : Use constructor template of the ArithmeticExpressionList
;;EXAMPLES: (check-block
  
       ;;                     (list (block (var "x")
         ;;                                 (lit 5)
           ;;                               (var "x"))
             ;;                     ->(list "x")
(define(check-block ex)
(remove-duplicates (append 
(cons (variable-name (block-var ex))empty)
(variables-defined-by(block-body ex))           
(variables-defined-by(block-rhs ex))empty)))
;;TESTS:
(begin-for-test
  (check-equal?(check-block(block (var "x")
                                      (lit 5)
                                        (block (var "y")
                                      (lit 5)
                                      (block(var"z")
                                      (op"*")
                                      (var "b")))))(list "x" "y" "z")
              "the list with x, y and z strings should be returned"))

;;remove-duplicates lst :  List->List
;;GIVEN: List which has the duplicates
;;RETURNS : List without the duplicates
;;STRATEGY: Use the constructor template of the ArithmeticExpressionlist
;;EXAMPLES:(remove-duplicates (list "x" "y" "x" "z"))->
;;(list "y" "x" "z")
(define(remove-duplicates lst)
(cond
[(empty? lst)empty]
[(member? (first lst)(rest lst))
(remove-duplicates(rest lst))]
[else(cons(first lst)(remove-duplicates(rest lst)))]))
;;TESTS:
(begin-for-test
  (check-equal?(remove-duplicates (list "a" "a" "a" "z"))(list "a" "z")"list
without the duplicates should be returned"))
;;TESTS:
(begin-for-test
  (check-equal?(variables-defined-by
               (block (var "x")
                      (var "y")
                      (call (block (var "z")
                                    (var "x")
                                    (op "+"))
                            (list (block (var "x")
                                          (lit 5)
                                          (var "x"))
                                   (var "x")))))(list "z" "x")
                        "the list with z and x strings should be returned"))


          ;;; variables-used-by : ArithmeticExpression -> StringList
          ;;; GIVEN: an arithmetic expression
          ;;; RETURNS: a list of the names of all variables used in
          ;;;     the expression, including variables used in a block
          ;;;     on the right hand side of its definition or in its body,
          ;;;     but not including variables defined by a block unless
          ;;;     they are also used
          ;;; EXAMPLE:
          ;;;     (variables-used-by
          ;;;      (block (var "x")
          ;;;             (var "y")
          ;;;             (call (block (var "z")
          ;;;                          (var "x")
          ;;;                          (op "+"))
          ;;;                   (list (block (var "x")
          ;;;                                (lit 5)
          ;;;                                (var "x"))
          ;;;                         (var "x")))))
          ;;;  => (list "x" "y") or (list "y" "x")
;;;STRATEGY : Use simpler functions

(define(variables-used-by  exp)
  (cond
[(literal? exp) null]
[(variable? exp)(check-variable exp)]
[(operation? exp) null]
[(call? exp)(check-call-variables-used exp)]
[(block? exp) (check-block-variables-used exp)]))

;;check-call-variables-used:Call->List
;;GIVEN: Call
;;RETURNS: List of the variables
;;STRATEGY : Use simpler functions
;;EXAMPLES: (check-call-variables-used
                      ;; (call (block (var "z")
                      ;;             (var "x")
                       ;;             (op "+"))
                      ;;      (list (block (var "x")
                         ;;                (lit 5)
                        ;;                 (var "x")))))
             ;;                     ->(list  "x")
(define(check-call-variables-used ex)
 (remove-duplicates (append
(variables-used-by(call-operator ex))
        (variables-lst2(call-operands ex))empty)))
;;TESTS
(begin-for-test
 (check-equal?(check-call-variables-used
                       (call  (var "z")
                                   
                            (list (block (var "x")
                                         (lit 5)
                                         (var "x")))))
(list "z" "x")"the list with z and x strings should be returned"))
;;variables-lst2:ArithmeticexpressoinList->List
;;GIVEN: An ArithmeticExpressionlist 
;;RETURNS: list of variables
;;STRATEGY : Use observer template of ArithmeticExpressionList
;;EXAMPLES: (variables-lst2
  
       ;;                     (list (block (var "x")
         ;;                                 (lit 5)
           ;;                               (var "x"))
             ;;                     (var "y")))->(list "x","y")


(define(variables-lst2 l)
  (cond
 [ (empty? l )null]
[else(append (variables-used-by(first l))
   (variables-lst2(rest l)))]))
;;TESTS:
  
(begin-for-test
 (check-equal?(variables-lst2(list(var"x")
                      (var "y")(block(var"z")
                                     (op"*")(var "b"))))
(list "x" "y" "b")))

;;check-block:Block->List
;;GIVEN: Block
;;RETURNS: list of the variables available for the block except the block-
;;variable
;;STRATEGY : Use observer template of ArithmeticExpressionList
;;EXAMPLES: (check-block
  
       ;;                      (block (var "y")
         ;;                                 (lit 5)
           ;;                               (var "x"))
             ;;                     ->(list "x")
(define(check-block-variables-used ex)
(remove-duplicates (append 
(variables-used-by(block-body ex))           
(variables-used-by(block-rhs ex))empty)))
;;TESTS:
(begin-for-test
 (check-equal?(check-block-variables-used
  
                            (block (var "y")
                                         (lit 5)
                                        (block(var "x")
                                              (lit 6)
                                              (call(op "*")
                                                   (list( var "f" )(var "g"))))))
(list "f" "g")))

;;check-variable:Variable->List
;;GIVEN: Variable
;;RETURNS:List of all variable-names  in the block-body and
;;block-rhs except block-variable
;;STRATEGY : Use constructor template of ArithmeticExpressionList
;;EXAMPLES: (check-variable (var "y")) ->(list  "y")
(define (check-variable ex)
(remove-duplicates(cons (variable-name(variable-name (var ex)))empty)))
;;TESTS:

(begin-for-test
 (check-equal?(check-variable (var"z"))(list "z")))

;;TESTS
           (begin-for-test
 (check-equal? (variables-used-by
                (block (var "x")
                       (var "y")
                       (call (block (var "z")
                                    (var "x")
                                    (op "+"))
                             (list (block (var "x")
                                          (lit 5)
                                          (var "x"))
                                   (var "x")))))
              (list "x" "y")))


          ;;; constant-expression? : ArithmeticExpression -> Boolean
          ;;; GIVEN: an arithmetic expression
          ;;; RETURNS: true if and only if the expression is a constant
          ;;;     expression
          ;;; EXAMPLES:
          ;;;     (constant-expression?
          ;;;      (call (var "f") (list (lit -3) (lit 44))))
          ;;;         => false
          ;;;     (constant-expression?
          ;;;      (call (op "+") (list (var "x") (lit 44))))
          ;;;         => false
          ;;;     (constant-expression?
          ;;;      (block (var "x")
          ;;;             (var "y")
          ;;;             (call (block (var "z")
          ;;;                          (call (op "*")
          ;;;                                (list (var "x") (var "y")))
          ;;;                          (op "+"))
          ;;;                   (list (lit 3)
          ;;;                         (call (op "*")
          ;;;                               (list (lit 4) (lit 5)))))))
          ;;;         => true
;;;STRATEGY : Use simpler functions
  
(define(constant-expression? exp)
  (cond
[(literal? exp) true]
[(variable? exp)false]
[(call? exp)(check-call-ce exp)]
[(block? exp) (check-block-ce exp)]))

  ;;; operation-expression? : ArithmeticExpression -> Boolean
          ;;; GIVEN: an arithmetic expression
          ;;; RETURNS: true if and only if the expression is an operation
          ;;;     expression
;;;STRATEGY : Conditions on operation-expression
;;;EXAMPLES: (operation-expression? (op "+"))->
;#true

(define(operation-expression? oe)
  (cond
    [(operation?  oe) true]
    [(block? oe) ( operation-expression?(block-body oe) )]
    [else false]))
;;TESTS:
(begin-for-test
 (check-equal?
(operation-expression? (var "+"))
#false)
 (check-equal?(operation-expression? (op "*"))
#true))
 (check-equal?(operation-expression? 
               (block (var "x")
                     (var "y")
                    (op "+")))
#true)

 ;;check-call-ce:Call->Boolean
;;GIVEN: Call
;;RETURNS: True if the operator of the call is an operation-expression
 ;; and the operand of the call is a constant expression
;;STRATEGY : Use simpler functions
;;EXAMPLES: (check-call-ce
                      ;; (call (op "+") (list(var "z")
                      ;;             (var "x")))
                      ;;      
             ;;                     ->false
(define(check-call-ce ex)
  
    (and
      (operation-expression? (call-operator ex))
 (variables-list(call-operands ex))))

;;TESTS:
(begin-for-test
 (check-equal?(check-call-ce
                       (call 
                                   (op "+")
                            (list (block (lit 4)
                                         (lit 5)
                                        (lit 6)))))
#true)
 (check-equal?(check-call-ce
                       (call 
                                   (op "+")
                            (list (block (var "x")
                                         (var "y")
                                        (var "x")))))
#false))
;;variables-list:ArithmeticexpressionList->Boolean
;;GIVEN: An ArithmeticExpressionList
;;RETURNS: TRue if the operand of the call is a constant expression
;;STRATEGY : Use observer template of ArithmeticExpressionList
;;EXAMPLES: (variables-lst2
  
       ;;                     (list (block (var "x")
         ;;                                 (lit 5)
           ;;                               (var "x"))
             ;;                     (var "y")))->(list "x","y"
(define(variables-list l)
  (cond
 [ (empty? l )true]
[else
 (and
  (constant-expression? (first l))
   (variables-list(rest l)))]))
;;TESTS
(begin-for-test
 (check-equal?(variables-list (list (lit 3)
     (call (op "*")
           (list(lit 4) (lit 5)))))true))

;;check-block-ce:Block->Boolean
;;GIVEN: Block
;;RETURNS: True if the the block-body is a constant expression
;;STRATEGY : Use simpler functions
;;EXAMPLES: (check-block-ce
  
       ;;                      (block (var "y")
         ;;                                 (lit 5)
           ;;                               (var "x"))
             ;;                     false
(define(check-block-ce ex)
(constant-expression? (block-body ex)))
;;TESTS:
(begin-for-test
 (check-equal?(check-block-ce (block (var "z")
                                   (call (op "*")
                                          (list (lit 9) (lit 7)))
                                    
                           
                                  (call (op "*")
                                        (list (lit 4) (lit 5)))))
#true))

  ;;; constant-expression-value : ArithmeticExpression -> Real
  ;;; GIVEN: an arithmetic expression
  ;;; WHERE: the expression is a constant expression
  ;;; RETURNS: the numerical value of the expression
  ;;; EXAMPLES:
  ;;;     (constant-expression-value
  ;;;      (call (op "/") (list (lit 15) (lit 3))))
 ;;;         => 5
 ;;;     (constant-expression-value
 ;;;      (block (var "x")
 ;;;             (var "y")
 ;;;             (call (block (var "z")
 ;;;                          (call (op "*")
 ;;;                                (list (var "x") (var "y")))
 ;;;                          (op "+"))
 ;;;                   (list (lit 3)
 ;;;                         (call (op "*")
 ;;;                               (list (lit 4) (lit 5)))))))
   ;;;         => 23
;;;STRATEGY : Use simpler functions
  (define(constant-expression-value ev)
  (cond
[(literal? ev) (literal-value ev)]
[(operation? ev)(check-operation-value ev) ]
[(call? ev)(check-call-value ev)]
[(block? ev) (constant-expression-value(block-body ev))]))
  
    
  ;;check-call-value:Call->Real
;;GIVEN: Call
;;RETURNS: the numerical value of the expression
;;STRATEGY : Use simpler functions
;;EXAMPLES: (check-call-value
 ;; (call (op "/") (list (lit 15) (lit 3))))->5
(define(check-call-value ex)
(variables-list-val(constant-expression-value (call-operator ex))
   (call-operands ex)))
;;TESTS:
(begin-for-test (check-equal?(check-call-value
(call (op "+") (list (lit 5) (lit 6)(lit 3))))
14"14 should be returned")
                
(check-equal? (check-call-value
 (call (block (var "z")
  (call (op "*")
 (list (var "x") (var "y")))
 (op "-"))
 (list (lit 3)
 (call (op "*")
 (list (lit 5) (lit 5))))))
-22 "-22 should be returned"))

;;variables-list-val : Operator ArithmeticexpressionList->Real
;;GIVEN: Operator ArithmeticexpressionList
;;RETURNS: Numerical value of expression
;;STRATEGY: Use constructor template of ArithmeticexpressionList

 (define(variables-list-val op l)
  (cond
 [(and
   (empty? l) (or
       (equal? op /)(equal? op *))) 1]
  [(and
     (empty? l)(or
       (equal? op +)(equal? op -)))0]
[else
  (op (constant-expression-value (first l))
   (variables-list-val op (rest l)))]))
  
;;check-operation-value:Operation->Operator
 ;;GIVEN: Operation
 ;;RETURNS:OPerator
 ;;EXAMPLES:(check-operation-value (op "+"))-> +
 ;;STRATEGY: Use constructor template of operation-name
 (define(check-operation-value ev)
 (remove-quotes(operation-name ev)))
  
  ;;TESTS:
(begin-for-test
 (check-equal?(check-operation-value (op "+"))+))
;;remove-quotes : Operation-name->Operator
 ;;GIVEN: Operation-name
 ;;RETURNS: The corresponding operation with the qoutes removed
 ;;EXAMPLES:(check-equal? (remove-quotes "-")->  -
 ;;STRATEGY: USe conditions on the operation-name
 (define(remove-quotes s)
   [cond
  [(equal? s "+") +]
  [(equal? s "-") -]
  [(equal? s "*") *]
  [(equal? s "/") /]])
 ;;TESTS:
(begin-for-test
 (check-equal? (remove-quotes "+")+))
  
 ;;TESTS
(begin-for-test
 (check-equal?(constant-expression-value
 (block (var "x")
 (var "y")
(call (block (var "z")
  (call (op "*")
 (list (var "x") (var "y")))
 (op "/"))
 (list (lit 3)
 (call (op "+")
  (list (lit 4) (lit 20)))))))1/8)
 
 (check-equal?(constant-expression-value
  (block (var "x")
  (var "y")
 (call (block (var "z")
 (call (op "*")
 (list (var "x") (var "y")))
(op "/"))
   (list (lit 24)
 (call (op "*")
(list (lit 8) (lit 3)))))))1))

    
   
