# Headings ----------------------------------------------------------------

test_that("Headings: h1", {
    expect_message(h1("Test"), "Test")

    expect_message(h1("Test", step = 1, steps_max = 3), "Test")

    expect_message(
        "This is a very long text that is longer than 80 characters in width and thus needs to be broken down into multiple lines" %>%
            h1(),
        "This"
    )

    expect_message(
        "This is a very long text that is longer than 80 characters in width and thus needs to be broken down into multiple lines" %>%
            h1(step = 1, steps_max = 3),
        "This"
    )

})

# Lists -------------------------------------------------------------------

test_that("Lists: unordered", {
    expect_message(
        ul(letters[1:3])
    )
})

# Wrapping lines ----------------------------------------------------------

test_that("Wrapped line", {
    x <- 80

    expect_message(
        "This is a very long text that is longer than {.field {x}} characters in width and thus needs to be broken down into multiple lines" %>%
            wrap_line(),
        "This is a very long text that"
    )

    expect_message(
        "This is a very long text that is longer than {.field {x}} characters in width and thus needs to be broken down into multiple lines" %>%
            wrap_line(.width = 100),
        "This is a very long text that"
    )

    expect_message(
        "This is a very long text that is longer than {.field {x}} characters in width and thus needs to be broken down into multiple lines" %>%
            wrap_line(.indent = 10),
        "This is a very long text that"
    )
})

test_that("Wrapped success", {
    x <- 80

    expect_message(
        "This is a very long text that is longer than {x} characters in width and thus needs to be broken down into multiple lines" %>%
            wrap_success(),
        "This is a very long text that"
    )

    expect_message(
        "This is a very long text that is longer than {x} characters in width and thus needs to be broken down into multiple lines" %>%
            wrap_success(.width = 100),
        "This is a very long text that"
    )
})
