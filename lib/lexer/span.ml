type t = {
  start_pos : Position.t;
  end_pos   : Position.t;
}

let make start_pos end_pos =
  {
    start_pos = start_pos;
    end_pos = end_pos;
  }

let ( ++ ) (span1 : t) (span2 : t) =
  {
    start_pos = span1.start_pos;
    end_pos = Position.(++) span1.start_pos span2.end_pos;
  }