type t =
  | Literal of Literal.t
  | Identifier of string
  | UnaryOperation of Operator.unary * t Node.t
  | Binary of Operator.binary * t Node.t * t Node.t
  | Call of t Node.t * t Node.t list
  | Grouping of t Node.t