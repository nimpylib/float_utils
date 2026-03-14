
type
  ArithmeticError* = object of CatchableError
  ZeroDivisionError* = object of ArithmeticError
  OverflowError* = object of ArithmeticError

