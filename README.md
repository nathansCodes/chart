# Prerequisites

A running Postgres installation

- Create a new database called "german-military" in PGAdmin and run the `schema.sql` to create the tables and insert data
- Update `.env` accordingly

# How to build

1. Install Rust: [https://rust-lang.org/tools/install/]
   - `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
2. Build: Run `cargo build`

# How to run

Run with `cargo run -- generate`

The output file and file type can be set with `-o <filename>`, defaults to `chart.svg`
