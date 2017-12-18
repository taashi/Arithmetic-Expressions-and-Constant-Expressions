# Arithmetic-Expressions-and-Constant-Expressions
Please clone both the files for the project to work at your end.
The extras file is required for the project file to work.
The specific data types mean the following in the code- 
A Literal represents a real number.
A Variable represents a name whose meaning will depend upon the context in which it appears.
An Operation represents an arithmetic operation such as addition or division.
A Call represents a function call.
A Block represents a variable definition and an expression within which that variable may be used.
An ArithmeticExpression is one of the following:
Literal
Variable
Operation
Call
Block
An operation expression is an arithmetic expression that is either
an Operation
or a Block whose body is an operation expression.
A constant expression is an arithmetic expression that is either
a Literal,
a Call whose operator is an operation expression and whose operands are all constant expressions,
or a Block whose body is a constant expression.
Several functions have been created using the above terms and computations are carried out on arithmetic and constant expressions in the code
