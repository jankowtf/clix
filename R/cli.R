# Headers -----------------------------------------------------------------

h1 <- function(title, step = 0, steps_max = 0, .width = 80) {
    if (step == 0 && steps_max == 0) {
        title %>%
            stringr::str_wrap(width = .width) %>%
            # usethis::ui_info()
            cli::cli_h1()
    } else {
        "{title} (step {step} of {steps_max})" %>%
            # rlang::eval_tidy() %>%
            stringr::str_wrap(width = .width) %>%
            cli::cli_h1()
    }
}

# Wrap lines --------------------------------------------------------------

wrap_line <- function(
    .x,
    .width = 80,
    .indent = 0,
    .envir = parent.frame(),
    .par = TRUE
) {
    # .x %>%
    #     stringr::str_wrap(width = .width, indent = .indent) %>%
    #     cli::cli_text(.envir = .envir)

    if (.par) {
        cli::cli_par()
        .x %>%
            stringr::str_wrap(width = .width, indent = .indent) %>%
            cli::cli_text(.envir = .envir)
        cli::cli_end()
    } else {
        .x %>%
            stringr::str_wrap(width = .width, indent = .indent) %>%
            cli::cli_text(.envir = .envir)
    }
}

wrap_success <- function(.x, .width = 80, .envir = parent.frame()) {
    .x %>%
        # stringr::str_glue() %>%
        stringr::str_wrap(width = .width) %>%
        cli::cli_alert_success(.envir = .envir)
}

# Ask ---------------------------------------------------------------------

ask_yes_no <- function(
    title = "Title here",
    preamble = "Preamble text here",
    implications_yes_preamble = character(),
    implications_yes = character(),
    step = 0,
    steps_max = 0
) {
    h1(title = title, step = step, steps_max = steps_max)

    preamble %>%
        wrap_line()

    implications_yes_preamble %>%
        answering_yes_implies()

    implications_yes %>%
        ul()
}

# Answering ---------------------------------------------------------------

answering_yes_implies <- function(.x = character(), .envir = parent.frame()) {
    # .x <- rlang::quo(.x)
    name <- "Yes"
    msg <- if (!length(.x)) {
        "Answering {.field {name}} implies the following:"
    } else {
        "Answering {.field {name}} implies the following {.x}:"
    }

    cli::cli_par()
    msg %>%
        cli::cli_text()
    cli::cli_end()
}

ul <- function(.x) {
    cli::cli_ul(.x)
}

# Logging -----------------------------------------------------------------

log_and_throw_error <- function(
  msg = "Error code: 1234",
  ...,
  envir = parent.frame()
) {
  # Put the message together
  msg <- msg %>%
    stringr::str_glue(.envir = envir)

  # Output to console
  msg %>%
    cli::cli_alert_danger()

  # output to log
  msg %>%
    logger::log_error()

  # Throw actual error
  stop(msg)
}

# Ask ---------------------------------------------------------------------
