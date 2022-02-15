# Create directory --------------------------------------------------------

#' Ask: create directory if missing
#'
#' `r lifecycle::badge("experimental")`
#'
#' @param dir ([character] or [fs_path]) Directory in question.
#' @param title ([character]) Title for this "input block".
#' @param preamble_exists_no ([character]) Preamble text.
#' @param preamble_exists_yes ([character]) Preamble text.
#' @param implications_yes_addendum ([character]) Additional text for the
#'   implications preamble text
#' @param implications_yes ([character]) Vector with implications
#' @param implications_no_addendum ([character]) Additional text for the
#'   implications preamble text
#' @param implications_no ([character]) Vector with implications
#' @param step ([integer]) Denote which process step this is. See [cli::h1()].
#' @param steps_max ([integer]) Denote how many process steps there are in
#'   total. See [cli::h1()].
#'
#' @return
#' @export
#' @example inst/examples/ex-ask_dir_create.R
ask_dir_create <- function(
    dir = "/path/to/directory",
    title = "Directory check",
    preamble_exists_no = c(
        "Directory {.field {dir}} does not exist yet.",
        "Do you want to create it?"
    ),
    preamble_exists_yes = c(
        "Directory {.field {dir}} already exists.",
        "There is nothing to do."
    ),
    implications_yes_addendum = character(),
    implications_yes = c(
        "Directory {.field {dir}} will be created"
    ),
    implications_no_addendum = character(),
    implications_no = c(
        "Nothing ;-)"
    ),
    # TODO-20220201-1815: Turn this into an actual emoji
    step = 0,
    steps_max = 0
) {
    # Heading
    h1(text = title, step = step, steps_max = steps_max)

    # Preamble

    if (!dir %>% fs::dir_exists()) {
        preamble_exists_no %>% handle_multi_lines()

        implications_input_yes(
            addendum = implications_yes_addendum,
            implications = implications_yes
        )
        # TODO-20220201-1716: This doesn't seem completely "done" yet
        # Think about better naming and/or more generalizable code

        # Handle input
        # - exit when "exit" or "again"
        # - otherwise "create dir" or "error"
        handle_input(
            input_fn = input_yes_no_again_exit,
            implications_fn = purrr::partial(
                .f = function(input, dir) {
                    if (input) {
                        dir %>% fs::dir_create()
                        if (dir %>% fs::dir_exists()) {
                            cli::cli_alert_success("Directory {.field {dir}} created.")
                        } else {
                            "Directory '{dir}' could not be created" %>%
                                throw_error(.console = TRUE)
                        }
                    } else {
                        "Directory '{dir}' was not created" %>%
                            throw_warning(.console = TRUE)
                    }
                },
                dir = dir
            )
        )
    } else {
        preamble_exists_yes %>% handle_multi_lines()
    }

    invisible(NULL)
}
