type t = {
  state : State.t;
  rules : Rule.t list;
  diagnostics : Diagnostic.t list;
}

let create ?(rules = []) ?(diagnostics = []) content =
  {
    state = State.create content;
    rules;
    diagnostics;
  }

let of_builder builder content =
  create ~rules:(Builder.build builder) content

let add_rule ctx rule = { ctx with rules = rule :: ctx.rules }
let add_diagnostic ctx diagnostic = { ctx with diagnostics = diagnostic :: ctx.diagnostics }
let with_state ctx state = { ctx with state }
let state ctx = ctx.state
let rules ctx = ctx.rules
let diagnostics ctx = ctx.diagnostics
