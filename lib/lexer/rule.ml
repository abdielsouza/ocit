type rule_kind = Regex | Literal | Predicate

type t = {
  name      : string;
  priority  : int;
  matcher   : string -> int -> int option;
  kind      : Token.token_kind option;
  skip      : bool;
}