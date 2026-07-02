(lang dune 3.22)

(name oli)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name <author@example.com>")

(maintainers "Maintainer Name <maintainer@example.com>")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name oli)
 (synopsis "Oli - coding CLI")
 (description "A terminal UI coding CLI built with bonsai_term")
 (depends
  ocaml
  dune
  async
  bonsai
  bonsai_term
  core
  core_unix
  notty-community
  ppx_jane
  (odoc :with-doc))
 (tags
  (cli tui)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
