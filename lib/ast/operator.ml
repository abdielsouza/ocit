type unary =
  | Negative
  | Not

type binary =
  | Add
  | Subtract
  | Multiply
  | Divide
  | Modulo
  | Equal
  | NotEqual
  | Less
  | LessEqual
  | Greater
  | GreaterEqual
  | And
  | Or

type t = Unary of unary | Binary of binary