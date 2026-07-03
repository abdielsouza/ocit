type parameter = {
  name : string;
}

type function_decl = {
  name    : string;
  params  : parameter list;
  body    : Statement.t Node.t list;
}

type t =
  | Function of function_decl