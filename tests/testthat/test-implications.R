# Yes ---------------------------------------------------------------------

test_that("Implications: yes", {
    # expect_message(
    #     implications_answer_yes(),
    #     "Answering Yes implies the following:"
    # )
    expect_type(implications_input_yes(), "character")

    expect_type(implications_input_yes(
        addendum = "after doing X"),
        "character"
    )

    expect_type(
        implications_input_yes(implications = c("abc" , "def")),
        "character"
    )
})
