#' Reset directory
#'
#' @param dir [[character]] Directory to reet
#'
#' @return
#' @export
#'
#' @examples
#' dir <- fs::path(tempdir(), "maindir") %>% fs::dir_create()
#' subdir <- fs::path(dir, "subdir") %>% fs::dir_create()
#' dir_reset(dir)
dir_reset <- function(dir) {
    subdirs <- dir %>% fs::dir_ls()

    if (!(subdirs %>% length())) {
        "Directory {dir} does not contain subdirectories" %>%
            stringr::str_glue() %>%
            cli::cli_alert_warning()
        return(FALSE)
    }

    "Removing existing subdirectories of {dir}" %>%
        stringr::str_glue() %>%
        cli::cli_alert_success()
    command <- "rm -r {subdirs}" %>% stringr::str_glue()
    command %>% purrr::walk(cli::cli_alert_success)
    command %>% purrr::walk(system)

    TRUE
}
