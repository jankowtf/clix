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

# Implications ------------------------------------------------------------

test_that("Implications: yes", {
    # expect_message(
    #     answering_yes_implies(),
    #     "Answering Yes implies the following:"
    # )
    expect_type(answering_yes_implies(), "character")

    expect_type(answering_yes_implies("after doing X"), "character")
})

test_that("Lists: unordered", {
    expect_message(
        ul(letters[1:3])
    )
})

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

# Ask ---------------------------------------------------------------------

test_that("ask: yes/no", {
    expect_message(
        ask_yes_no(
            title = "Test test",
            preamble = "Test test test",
            implications_yes_preamble = "after running 'foo()'",
            implications_yes = c(
                "Package {.field {'roxygen2'}} will be installed if necessary",
                "Package {.field {'roxygen2'}} will be added to {.field {'Suggests'}} section of your {.field {'DESCRIPTION'}} file",
                "Line {.field {'RoxygenNote: {x.y.z}'}} will be added to your {.field {'DESCRIPTION'}} file",
                "[NOT ENSURED YET] RStudio settings are modified to put {.code {quote(roxygen2)}} in charge of documenting and vignette building"
            )
        )
    )
})
