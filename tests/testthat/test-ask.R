# Globals -----------------------------------------------------------------

path <- test_path() %>% fs::path("data") %>%
    fs::dir_create(recurse = TRUE)

# Create directory --------------------------------------------------------

test_that("Ask: create directory: exists = false", {
    if (path %>% fs::dir_exists()) {
        path %>% fs::dir_delete()
    }

    result <- ask_dir_create(dir = path %>% fs::path("a/b/c"))
    expect_true(path %>% fs::dir_exists())
})

test_that("Ask: create directory: exists = false (pipe)", {
    if (path %>% fs::dir_exists()) {
        path %>% fs::dir_delete()
    }

    result <- path %>% fs::path("a/b/c") %>% ask_dir_create()
    expect_true(path %>% fs::dir_exists())
})

test_that("Ask: create directory: exists = true", {
    if (!(path %>% fs::dir_exists())) {
        path %>% fs::dir_create(recurse = TRUE)
    }

    result <- ask_dir_create(dir = path %>% fs::path("a/b/c"))
    result <- ask_dir_create(dir = path %>% fs::path("a"))
    expect_true(path %>% fs::dir_exists())
})
