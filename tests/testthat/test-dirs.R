test_that("Dir reset", {
    dir <- fs::path(tempdir(), "maindir") %>% fs::dir_create()
    subdir <- fs::path(dir, "subdir") %>% fs::dir_create()
    expect_true(subdir %>% fs::dir_exists())

    dir_reset(dir)

    expect_true(dir %>% fs::dir_exists())
    expect_false(subdir %>% fs::dir_exists())
})
