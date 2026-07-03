module Span = Span
module Position = Position

type result = {
  tokens : Token.t list;
  diagnostics : Diagnostic.t list;
}

let compare_match (rule_a, len_a) (rule_b, len_b) =
  if len_a <> len_b then compare len_a len_b
  else compare rule_a.Rule.priority rule_b.Rule.priority

let best_match rules input index =
  let update best rule =
    match rule.Rule.matcher input index with
    | Some len when len > 0 ->
        begin
          match best with
          | None -> Some (rule, len)
          | Some best_rule when compare_match (rule, len) best_rule > 0 -> Some (rule, len)
          | _ -> best
        end
    | _ -> best
  in
  List.fold_left update None rules

let make_span state len =
  let start_pos = State.position state in
  let end_position = State.position (State.advance_n state len) in
  Span.make start_pos end_position

let make_token rule lexeme span =
  match rule.Rule.kind with
  | Some kind -> Some (Token.make kind lexeme span)
  | None -> None

let rec scan rules state diagnostics tokens =
  if State.is_eof state then
    { tokens = List.rev tokens; diagnostics = List.rev diagnostics }
  else
    let input = State.input state in
    let index = State.index state in
    match best_match rules input index with
    | Some (rule, len) ->
        let lexeme =
          match State.peek state len with
          | Some str -> str
          | None -> ""
        in
        let span = make_span state len in
        let tokens =
          if rule.Rule.skip then tokens
          else begin
            match make_token rule lexeme span with
            | Some token -> token :: tokens
            | None -> tokens
          end
        in
        scan rules (State.advance_n state len) diagnostics tokens
    | None ->
        let current_char =
          match State.current_char state with
          | Some c -> c
          | None -> '\000'
        in
        let diagnostic =
          Diagnostic.make
            Diagnostic.Error
            (State.position state)
            (Printf.sprintf "Unexpected character '%c'" current_char)
        in
        scan rules (State.advance state) (diagnostic :: diagnostics) tokens

let run ctx =
  let result = scan ctx.Context.rules ctx.Context.state [] [] in
  { tokens = result.tokens; diagnostics = List.rev_append (List.rev ctx.Context.diagnostics) result.diagnostics }

let lex ?(rules = []) input =
  run (Context.create ~rules input)
