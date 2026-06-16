type t = {
  (** The lexer position in the content. *)
  line    : int;
  column  : int;
  offset  : int;
}

(** It takes the lexer back to the start. *)
let start =
  {
    line = 0;
    column = 0;
    offset = 0;
  }

(**
It takes the lexer to the next character just ahead.

@param current_pos the current lexer position to be moved.
*)
let next_char current_pos =
  {
    line = current_pos.line;
    column = current_pos.column + 1;
    offset = current_pos.offset;
  }

(**
It takes the lexer to the next line.

@param current_pos the current lexer position to be moved.
@param from_start tells the function to reset the column position. It's [true] by default.
*)
let next_line current_pos ?(from_start = true) () =
  {
    line = current_pos.line + 1;
    column = if from_start then 0 else current_pos.column;
    offset = if from_start then 0 else current_pos.offset;
  }

let ( ++ ) (pos1 : t) (pos2 : t) =
  {
    line = pos1.line + pos2.line;
    column = pos2.column;
    offset = pos2.offset;
  }