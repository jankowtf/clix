test_that("Throw error", {
    x <- "hello"
    y <- "world"

    expect_error(
        # "{x} {y}" %>% throw_error(x = x, y = y),
        "{x} {y}" %>% throw_error(),
        regexp = "hello world"
    )

    # Don't really know how to test the actual console output
    expect_error(
        expect_message("{x} {y}" %>% throw_error(.console = TRUE)),
        regexp = "hello world"
    )

    # Don't really know how to test the actual log output
    expect_error(
        expect_message("{x} {y}" %>% throw_error(.log = TRUE)),
        regexp = "hello world"
    )

    expect_error(
        expect_message("{x} {y}" %>% throw_error(.console = TRUE, .log = TRUE)),
        regexp = "hello world"
    )
})

test_that("Throw error: subscope", {
    foo <- function(x = "hello", y = "world") {
        # "{xx} {yy}" %>% throw_error(xx = x, yy = y) # Keep as reference
        "{x} {y}" %>% throw_error()
    }

    expect_error(
        foo(),
        regexp = "hello world")
})
