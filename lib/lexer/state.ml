type t = {
  content  : string;
  index    : int;
  position : Position.t;
}

let create content =
  {
    content = content;
    index = 0;
    position = Position.start;
  }

let is_eof state =
  state.index >= String.length state.content

let current_char state =
  if is_eof state then None else Some (String.get state.content state.index)

let peek state len =
  let available = String.length state.content - state.index in
  if len <= 0 || len > available then None
  else Some (String.sub state.content state.index len)

let advance state =
  if is_eof state then state
  else
    let next_position =
      match current_char state with
      | Some '\n' -> Position.next_line state.position ()
      | Some _ -> Position.next_char state.position
      | None -> state.position
    in
    { state with index = state.index + 1; position = next_position }

let rec advance_n state n =
  if n <= 0 || is_eof state then state
  else advance_n (advance state) (n - 1)

let position state = state.position
let input state = state.content
let index state = state.index
