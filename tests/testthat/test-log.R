test_that("Log and throw error", {
    x <- "hello"
    y <- "world"

    expect_error(
        "{x} {y}" %>% log_and_throw_error(x = x, y = y),
        regexp = "hello world")
})

test_that("Log and throw error (2)", {
    foo <- function(x = "hello", y = "world") {
        "{x} {y}" %>% log_and_throw_error(x = x, y = y)
    }

    expect_error(
        foo(),
        regexp = "hello world")
})
