# clix 0.0.1.9007 (2022-08-13)

Propagate non-interactive functionality

- Modified `ask_dir_create()` and `handle_input()`: added argument `is_interactive`

---------

# clix 0.0.1.9006 (2022-08-13)

Fixed starting over behavior

- Fixed `handle_input()`

---------

# clix 0.0.1.9005 (2022-08-13)

Non-interactive cases

- Modified input functions (additional arguments `value` and `force`)
- Bugfix for exiting when `selection = 0`

---------

# clix 0.0.1.9004 (2022-08-09)

Reset

- Added `dir_reset()`
- Modified `ask_dir_create()`

---------

# clix 0.0.1.9003

Pipe-friendy

- Modified arg order in `ask_dir_create()` to make it more pipe-friendly

---------

# clix 0.0.1.9002

Finalized first bundle: 'ask_dir_create()'

Main changes
- Added `ask_dir_create()`
- Added `README.Rmd`
- Added unit tests in `tests/testthat`
- Added first batch of examples

---------

# clix 0.0.1.9001

* Initial version
