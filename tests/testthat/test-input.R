
# Yes/no/again/exit -------------------------------------------------------

test_that("User input: yes/no/again/exit", {
    result <- input_yes_no_again_exit()
    expected <- c(yes = "Yes")
    expect_identical(result, expected)

    result <- input_yes_no_again_exit(title = "Test")
    expected <- c(yes = "Yes")
    expect_identical(result, expected)
})

test_that("User input: yes/no/again/exit: non-interactive", {
    # Caution: test is written for non-interactive execution!
    result <- input_yes_no_again_exit(value = "No")
    expected <- c(no = "No")
    expect_identical(result, expected)

    result <- input_yes_no_again_exit(value = "No", force = TRUE)
    expected <- c(no = "No")
    expect_identical(result, expected)

    expect_error(
        input_yes_no_again_exit(value = "Invalid", force = TRUE)
    )
})

# Keep/reset/again/exit -------------------------------------------------------

test_that("User input: keep/reset/again/exit", {
    result <- input_keep_reset_again_exit()
    expected <- c(reset = "Reset")
    expect_identical(result, expected)
})

test_that("User input: keep/reset/again/exit: non-interactive", {
    # Caution: test is written for non-interactive execution!
    result <- input_keep_reset_again_exit(value = "keep")
    expected <- c(keep = "Keep")
    expect_identical(result, expected)

    result <- input_keep_reset_again_exit(value = "keep", force = TRUE)
    expected <- c(keep = "Keep")
    expect_identical(result, expected)

    expect_error(
        input_keep_reset_again_exit(value = "Invalid", force = TRUE)
    )
})
