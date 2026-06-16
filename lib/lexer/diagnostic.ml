type severity = Error | Warning | Info

type t = {
  severity : severity;
  position : Position.t;
  message  : string;
}

let make severity position message =
  { severity; position; message }

let string_of_severity = function
  | Error -> "error"
  | Warning -> "warning"
  | Info -> "info"

let to_string diagnostic =
  Printf.sprintf "%s: line %d, column %d: %s"
    (string_of_severity diagnostic.severity)
    diagnostic.position.line
    diagnostic.position.column
    diagnostic.message
