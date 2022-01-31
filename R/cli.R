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

# Handlers ----------------------------------------------------------------

#' Handle multiple lines
#'
#' @param x ([character]) Vector of input that should be transformed to multi
#'   lines in console output.
#' @param .envir Default: Parent frame
#'
#' @return
#' @export
handle_multi_lines <- function(x, .envir = parent.frame()) {
    x %>% purrr::map(function(.x) {
        cli::cli_par()
        .x %>% cli::cli_text(.envir = .envir)
        cli::cli_end()
    })
}

handle_answer <- function(
    answer,
    type = c("inner", "outer"),
    env = parent.frame()
) {
    type <- match.arg(type)
    answer <- if (type == "inner") {
        tmp <- switch(
            names(answer),
            yes = TRUE,
            no = FALSE,
            again = "again",
            exit = "exit"
        )
        if (!is.null(tmp)) {
            tmp
        } else {
            answer
        }
    } else if (type == "outer") {
        if (is.null(answer)) {
            # quote(return(usethis::ui_oops("Exited")))
            # withr::with_environment(
            #   env = env,
            #   return(usethis::ui_oops("Exited"))
            # )
            rlang::quo((rlang::eval_tidy(
                return(usethis::ui_oops("Exited")),
                env = env
            )))
        } else if (is.na(answer)) {
            rlang::eval_tidy(Recall(), env = env)
        }
    }
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

ask_dir_create <- function(
    title = "Directory check",
    preamble = c(
        "Directory {.field {.dir}} does not exist yet.",
        "Do you want to create it?"
    ),
    .dir = "/path/to/directory",
    implications_yes_preamble = character(),
    implications_yes = c(
        "Directory {.field {.dir}} will be created"
    ),
    step = 0,
    steps_max = 0
) {
    h1(title = title, step = step, steps_max = steps_max)

    preamble %>% handle_multi_lines()

    implications_yes_preamble %>% answering_yes_implies()

    implications_yes %>% ul()

    answer <- input_yes_no_again_exit(title = character())

    # Handle answer: exit when "exit" or "again", otherwise create dir
    answer <- answer %>% handle_answer()
    if (answer %in% valid::valid_again_exit(flip = TRUE)) {
        return(answer)
    }

    if (answer) {
        .dir %>% fs::dir_create()
    } else {
        log_and_throw_error("Directory is not created")
    }

}

# User input --------------------------------------------------------------

input_yes_no_again_exit <- function(
    title = character()
) {
    if (length(title)) {
        title %>% h1()
        # TODO-20220131-1821: Find more flexible ways to use "preamble" text that
        # does not necessarily needs to be an 'h1()'
    }

    select.list(
        choices = valid::valid_yes_no_again_exit(),
        preselect = valid::valid_yes_no_again_exit("yes")
        # title = {
        #     title %>% cli::cli_text()
        # }
    )
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

ul <- function(.x, .envir = parent.frame()) {
    cli::cli_ul(.x, .envir = .envir)
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
