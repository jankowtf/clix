# Headers -----------------------------------------------------------------

#' Heading level 1 `r lifecycle::badge("experimental")`
#'
#' Mainly a "decoupling wrapper" around [cli::cli_h1()] with some additional
#' features.
#'
#' @param text ([character]) Text of the heading. It can contain inline markup.
#' @param step ([integer]) Denote which process step this is.
#' @param steps_max ([integer]) Denote how many process steps there are in total
#' @param .width ([integer]) Line width. Currently not compatible with.
#'   [cli::cli_h1()] but possibly usefule in the future.
#' @param .envir ([environment]) Environment to evaluate the glue expressions
#'   in.
#'
#' @return
#' @export
#'
#' @examples
#' h1("This is a title")
h1 <- function(
    text,
    step = 0,
    steps_max = 0,
    .width = 80,
    .envir = parent.frame()
) {
    text <- if (step == 0 && steps_max == 0) {
        text %>%
            stringr::str_wrap(width = .width) %>%
            # usethis::ui_info() %>%
            cli::cli_h1()
    } else {
        "{text} (step {step} of {steps_max})" %>%
            # rlang::eval_tidy() %>%
            stringr::str_wrap(width = .width) %>%
            cli::cli_h1()
    }

    # TODO-20220201-1655: Scoping clash when gluing
    # Basically the same problem/situation as for 'implications_answer_yes()'
}

# Lists -------------------------------------------------------------------

#' Unordered list `r lifecycle::badge("experimental")`
#'
#' Pure "decoupling wrapper" around [cli::cli_ul()]
#'
#' @param items ([character]) If not NULL, then a character vector. Each element
#'   of the vector will be one list item, and the list container will be closed
#'   by default (see the .close argument).
#' @param .envir ([environment]) Environment to evaluate the glue expressions
#'   in. It is also used to auto-close the container if .auto_close is TRUE.
#'
#' @return
#' @export
#'
#' @examples
#' ul(letters[1:3])
ul <- function(items, .envir = parent.frame()) {
    items %>% cli::cli_ul(.envir = .envir)
}

# Wrap lines --------------------------------------------------------------

#' Wrap lines `r lifecycle::badge("experimental")`
#'
#' @param .x
#' @param .width
#' @param .indent
#' @param .envir
#' @param .par
#'
#' @return
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

#' Wrap success `r lifecycle::badge("experimental")`
#'
#' @param .x
#' @param .width
#' @param .envir
#'
#' @return
wrap_success <- function(.x, .width = 80, .envir = parent.frame()) {
    .x %>%
        # stringr::str_glue() %>%
        stringr::str_wrap(width = .width) %>%
        cli::cli_alert_success(.envir = .envir)
}

# Handle mutli lines ------------------------------------------------------

#' Handle multiple lines `r lifecycle::badge("experimental")`
#'
#' @param x ([character]) Vector of input that should be transformed to multi
#'   lines in console output.
#' @param .envir ([environment]) Environment to evaluate the glue expressions
#'   in.
#'
#' @return
handle_multi_lines <- function(x, .envir = parent.frame()) {
    x %>% purrr::map(function(.x) {
        cli::cli_par()
        .x %>% cli::cli_text(.envir = .envir)
        cli::cli_end()
    })
}
