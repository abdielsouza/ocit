type token_kind = {
  id    : int;
  name  : string;
}

type t = {
  kind    : token_kind;
  lexeme  : string;
  span    : Span.t;
}

let make kind lexeme span =
  {
    kind = kind;
    lexeme = lexeme;
    span = span;
  }

let to_string tok =
  tok.lexeme