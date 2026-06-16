type t = {
  rules : Rule.t list;
}

let create () = { rules = [] }

let add_rule builder rule = { rules = rule :: builder.rules }

let literal ?(priority = 0) ?kind ?(skip = false) name value builder =
  let matcher input index =
    let len = String.length value in
    if String.length input - index < len then None
    else
      let slice = String.sub input index len in
      if slice = value then Some len else None
  in
  add_rule builder { Rule.name = name; priority; matcher; kind; skip }

let predicate ?(priority = 0) ?kind ?(skip = false) name matcher builder =
  add_rule builder { Rule.name = name; priority; matcher; kind; skip }

let build builder =
  List.sort
    (fun lhs rhs ->
      match compare lhs.Rule.priority rhs.Rule.priority with
      | 0 -> 0
      | compare_result -> -compare_result)
    builder.rules
