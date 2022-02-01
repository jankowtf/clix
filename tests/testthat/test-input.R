
# Yes/no/again/exit -------------------------------------------------------

test_that("User input: yes/no/again/exit", {
    skip("Interactive only")

    expect_message(
        input_yes_no_again_exit()
    )
    expect_message(
        input_yes_no_again_exit(title = "Test")
    )
})
