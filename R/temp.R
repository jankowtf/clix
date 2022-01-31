ask_roxygen_preamble <- function(
  title = "Roxygen",
  step = 1,
  steps_max = 1
) {
  ui_header(title = title, step = step, steps_max = steps_max)

  "Great documentation makes a huge difference - not just for others, but also for \"future you\"." %>%
    ui_glue_wrap_field() %>%
    ui_glue_wrap_line()
  message()
  "Using package {usethis::ui_code(quote(roxygen2))} (https://roxygen2.r-lib.org/) makes documenting your package easy and fun.
  It offers you a straightforward syntax (optionally including markdown), provides you with a number of convenient helpers and takes care of managing your {usethis::ui_field('NAMESPACE')} file." %>%
    ui_glue_wrap_line()
  message()

  ui_answering_yes_implies() %>%
    usethis::ui_line()
  message()
  "Package {usethis::ui_code('roxygen2')} will be installed if necessary" %>%
    ui_glue_wrap_done()
  "Package {usethis::ui_code(quote(roxygen2))} will be added to {usethis::ui_field('Suggests')} section of your {usethis::ui_field('DESCRIPTION')} file" %>%
    ui_glue_wrap_done()
  "Line {usethis::ui_field('RoxygenNote: {{x.y.z}}')} will be added to your {usethis::ui_field('DESCRIPTION')} file" %>%
    ui_glue_wrap_done()
  "[NOT ENSURED YET] RStudio settings are modified to put {usethis::ui_code(quote(roxygen2))} in charge of documenting and vignette building" %>%
    ui_glue_wrap_done()
  message()
}

ask_roxygen_preamble_2 <- function(
    title = "Roxygen",
    step = 1,
    steps_max = 1
) {
    h1(title = title, step = step, steps_max = steps_max)

    "Great documentation makes a huge difference - not just for others, but also for \"future you\"." %>%
        wrap_line()

    "Using package {usethis::ui_code(quote(roxygen2))} (https://roxygen2.r-lib.org/) makes documenting your package easy and fun.
  It offers you a straightforward syntax (optionally including markdown), provides you with a number of convenient helpers and takes care of managing your {usethis::ui_field('NAMESPACE')} file." %>%
        wrap_line()

    # ui_answering_yes_implies() %>%
    #     usethis::ui_line()
    answering_yes_implies("when subsequently calling {.code ensure_good_start()}")

    ul(
        c(
            "Package {.field {'roxygen2'}} will be installed if necessary",
            "Package {.field {'roxygen2'}} will be added to {.field {'Suggests'}} section of your {.field {'DESCRIPTION'}} file",
            "Line {.field {'RoxygenNote: {x.y.z}'}} will be added to your {.field {'DESCRIPTION'}} file",
            "[NOT ENSURED YET] RStudio settings are modified to put {.code {quote(roxygen2)}} in charge of documenting and vignette building"
        )
    )
}

ui_glue_wrap_field <- function(x) {
    x %>%
        stringr::str_glue() %>%
        stringr::str_wrap() %>%
        usethis::ui_field()
}

ui_glue_wrap_line <- function(x, indent = 0) {
    x %>%
        stringr::str_glue() %>%
        stringr::str_wrap(indent = indent) %>%
        usethis::ui_line()
}

ui_glue_wrap_done <- function(x) {
    x %>%
        stringr::str_glue() %>%
        stringr::str_wrap() %>%
        usethis::ui_done()
}

ui_answering_yes_implies <- function() {
    "Answering {usethis::ui_field('Yes')} implies the following when subsequently calling {usethis::ui_code('ensure_good_start()')}:"
}

ui_header <- function(title, step, steps_max) {
    "{title} (step {step} of {steps_max})" %>%
        rlang::eval_tidy() %>%
        stringr::str_glue() %>%
        stringr::str_wrap() %>%
        usethis::ui_info()
    message()
}

foo <- function() {

answer <-
    select.list(
        choices = valid_yes_no_again_exit(),
        preselect = valid_yes_no_again_exit("yes"),
        title = {
            "Do you want to use package {usethis::ui_code(quote(roxygen2))} for documenting tasks?" %>%
                ui_glue_wrap_field()
        }
    )

}

