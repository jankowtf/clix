#' Throw error `r lifecycle::badge("experimental")`
#'
#' @param msg ([character]) Error message. See [stringr::str_glue()].
#' @param .console ([logical]) Output to console
#' @param .log ([logical]) Output to log (console or file depending on logging
#'   settings)
#'   TODO-20220201-1627: flesh out logging details
#' @param .envir ([environment]) Environment in which to evaluate msg expression
#'
#' @return
#' @export
#'
#' @example inst/examples/ex-throw_error.R
throw_error <- function(
    msg = "Error code: 1234",
    # ...,
    # TODO-20220201-1632:
    # Not sure what makes more sense here: to "rely" on objects in upstream
    # scopes or being able to explicitly specify args that are contained in the
    # message string
    .console = FALSE,
    .log = FALSE,
    .envir = parent.frame()
) {
    # Put the message together
    msg <- msg %>%
        stringr::str_glue(.envir = .envir)

    # Output to console
    if (.console) {
        msg %>%
            cli::cli_alert_danger(.envir = .envir)
    }

    # output to log
    if (.log) {
        msg %>%
            logger::log_error()
    }

    # Throw actual error
    stop(msg)
}

#' Throw warning `r lifecycle::badge("experimental")`
#'
#' @param msg ([character]) Warning message. See [stringr::str_glue()].
#' @param .console ([logical]) Output to console
#' @param .log ([logical]) Output to log (console or file depending on logging
#'   settings)
#'   TODO-20220201-1627: flesh out logging details
#' @param .envir ([environment]) Environment in which to evaluate msg expression
#'
#' @return
#' @export
#'
#' @example inst/examples/ex-throw_warning.R
throw_warning <- function(
    msg = "Warning code: 1234",
    .console = FALSE,
    .log = FALSE,
    .envir = parent.frame()
) {
    # Put the message together
    msg <- msg %>%
        stringr::str_glue(.envir = .envir)

    # Output to console
    if (.console) {
        msg %>%
            cli::cli_alert_warning(.envir = .envir)
    }

    # output to log
    if (.log) {
        msg %>%
            logger::log_warn()
    }

    # Throw actual error
    warning(msg)
}
