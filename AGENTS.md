# Agents Guide: Oli

Oli is a terminal UI (TUI) coding CLI built with OCaml and `bonsai_term`. It follows a functional reactive programming (FRP) pattern for managing its user interface.

## Tech Stack

- **Language:** OCaml
- **Build System:** [Dune](https://dune.ocaml.org/)
- **UI Framework:** [`bonsai_term`](https://github.com/janestreet/bonsai_term) (based on [`bonsai`](https://github.com/janestreet/bonsai))
- **Async Runtime:** [`async`](https://github.com/janestreet/async)
- **Standard Library:** [`core`](https://github.com/janestreet/core) / [`core_unix`](https://github.com/janestreet/core_unix)
- **Terminal Handling:** [`notty-community`](https://github.com/ocaml-community/notty-community)

## Project Structure

```text
.
├── bin/
│   └── oli.ml              # Entry point; initializes the Bonsai_term app
├── lib/
│   ├── app.ml              # Main application component and orchestration
│   ├── prompt.ml           # Core TUI view logic, input handling, and cursor management
│   ├── title_bar.ml        # Logic for the top title bar UI component
│   ├── username.ml         # Helpers for retrieving the current system username
│   ├── project_name.ml     # Logic for determining the current project name
│   ├── width.ml            # Helpers for terminal width and dimension calculations
│   ├── welcome.ml          # Welcome screen/message logic
│   ├── notty_view.ml       # Integration with notty for terminal views
│   └── input.ml            # Input event utilities (e.g., quit detection)
├── test/
│   └── test_oli.ml         # Suite of tests for the core library
├── dune-project             # Project-wide Dune configuration
├── oli.opam                # Opam package definition
└── README.org              # Project documentation
```

## Core Development Rules

### 1. UI Development (Bonsai)
- **Functional Reactive Style:** Use `Bonsai.state` for local state and `let%arr` (Bonsai.Let_syntax) for combining reactive values.
- **Components:** Break down UI elements into small, reusable functions in the `lib/` directory.
- **Effects:** Use `Bonsai.Edge` (e.g., `after_display`) for side effects like updating the cursor position.

### 2. Code Style & Standards
- **Standard Library:** Always prefer `Core` over the OCaml standard library.
- **Asynchronous Code:** Use `Async` for any I/O or long-running operations to avoid blocking the UI thread.
- **Type Safety:** Leverage OCaml's strong type system; avoid `obj` or overly generic types where specific ones are possible.

### 3. Build and Test
- **Build:** Use `dune build`.
- **Run:** Use `dune exec bin/oli.exe`.
- **Test:** Use `dune runtest`.

### 4. TUI Considerations
- **Dimensions:** Always consider terminal resizing. Use the `dimensions` reactive value provided by `bonsai_term` to calculate layouts.
- **Performance:** Minimize expensive calculations inside the `view` function, as it may be called frequently.
