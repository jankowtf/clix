# Input yes/no/again/exit -------------------------------------------------

#' User input: yes/no/again/exit `r lifecycle::badge("experimental")`
#'
#' @param title ([character]) Optional title before presenting the input
#'   choices. Currently not "compatible as desired" between {[cli]} and
#'   [select.list] and thus set to `character()` by default.
#' @param value [[character]] Value for non-interactive situations
#' @param force [[logical]] Force usage of value yes/no
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#' input_yes_no_again_exit()
#' input_yes_no_again_exit(force = TRUE)
#' }
input_yes_no_again_exit <- function(
    title = character(),
    value = valid::valid_yes_no_again_exit("yes"),
    force = FALSE
) {
    if (!interactive() || force) {
        return(value %>% valid::valid_yes_no_again_exit())
    }

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

# Input keep/reset/again/exit ---------------------------------------------

#' User input: yes/no/again/exit `r lifecycle::badge("experimental")`
#'
#' @param title ([character]) Optional title before presenting the input
#'   choices. Currently not "compatible as desired" between {[cli]} and
#'   [select.list] and thus set to `character()` by default.
#' @param value [[character]] Value for non-interactive situations
#' @param force [[logical]] Force usage of value yes/no
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#' input_keep_reset_again_exit()
#' input_keep_reset_again_exit(force = TRUE)
#' }
input_keep_reset_again_exit <- function(
    title = character(),
    value = valid::valid_keep_reset_again_exit("reset"),
    force = FALSE
) {
    if (!interactive() || force) {
        return(value %>% valid::valid_keep_reset_again_exit())
    }

    if (length(title)) {
        title %>% h1()
        # TODO-20220131-1821: Find more flexible ways to use "preamble" text that
        # does not necessarily needs to be an 'h1()'
    }

    select.list(
        choices = valid::valid_keep_reset_again_exit(),
        preselect = valid::valid_keep_reset_again_exit("keep")
        # title = {
        #     title %>% cli::cli_text()
        # }
    )
}

# Handle input ------------------------------------------------------------

#' Handle input (internal part) `r lifecycle::badge("experimental")`
#'
#' @param answer
#' @param type
#' @param envir
#'
#' @return
handle_input_ <- function(
    answer,
    type = c("inner", "outer"),
    envir = parent.frame()
) {
    type <- match.arg(type)

    if (answer == "") {
        return("exit")
    }

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
                env = envir
            )))
        } else if (is.na(answer)) {
            rlang::eval_tidy(Recall(), env = envir)
        }
    }

    answer
}

#' Handler user input `r lifecycle::badge("experimental")`
#'
#' @param input_fn ([function]) Function to capture user input
#' @param implications_fn ([function]) Function to execute implications. Should
#'   semantically "match" the input function
#' @param type ([character]) See [clix:::handle_input_]
#'
#' TODO-20220201-1620: check what 'inner' and 'outer' actually does - too long
#' ago ;-)
#' @param envir ([environment]) The environment in which to evaluate expression.
#' @param is_interactive [[logical]] Interactive mode yes/no
#'
#' @return
#' @export
#'
#' @example inst/examples/ex-handle_input.R
handle_input <- function(
    input_fn = input_yes_no_again_exit,
    implications_fn = function(answer) {},
    type = c("inner", "outer"),
    envir = parent.frame(),
    is_interactive = interactive()
) {
    # Get user input
    input <- input_fn(force = !is_interactive)

    # Main handling
    input <- input %>% handle_input_(type = type, envir = envir)

    # Interpret input
    if (input %in% valid::valid_again_exit(flip = TRUE)) {
        if (input == "again") {
            cli::cli_inform("Starting over...")
            input <- Recall(input_fn = input_fn)
            # input <- input_fn()
        } else if (input == "exit") {
            cli::cli_inform("Exiting")
            return(input)
        }
    }

    # Safety due to scoping details of 'Recall()?
    if (input == "exit") {
        return(input)
    }

    # Call implications function
    input %>% implications_fn()
}
