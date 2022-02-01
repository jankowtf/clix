# Implications: input yes ---------------------------------------------

#' Implications: input yes `r lifecycle::badge("experimental")`
#'
#' @param addendum ([character]) Addendum for preamble text
#' @param implications ([character]) Vector with implications. Will be turned
#'   into a bullet list. See [clix::ul()].
#' @param envir ([environment]) The environment in which to evaluate expression.
#'
#' @return
#' @export
#' @example inst/examples/ex-implications_input_yes.R
implications_input_yes <- function(
    addendum = character(),
    implications = character(),
    .envir = parent.frame()
) {
    name <- "Yes"
    msg <- if (!length(addendum)) {
        "Answering {.field {name}} implies the following:"
    } else {
        "Answering {.field {name}} implies the following {addendum}:"
    }

    cli::cli_par()
    msg %>%
        cli::cli_text()
    # cli::cli_end()

    # cli::cli_par()
    if (length(implications)) {
        implications %>% ul(.envir = .envir)
    }
    cli::cli_end()
}


