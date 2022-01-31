test_that("Replacing old code with {cli} code", {
    ask_roxygen_preamble()
    ask_roxygen_preamble_2()

    cli::cli_ul(c("alskdj", "alskdjf", "alskdj"))

    cli::cli_h1("Test")
})
