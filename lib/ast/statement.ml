type t =
  | Expression of Expression.t Node.t
  | Variable of string * Expression.t Node.t option
  | Return of Expression.t Node.t option
  | Conditional of (Expression.t Node.t * t Node.t list) list * t Node.t list option
  | Loop of Expression.t Node.t * t Node.t list
  | Block of t Node.t list