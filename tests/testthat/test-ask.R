# Create directory --------------------------------------------------------

test_that("Ask: create directory: exists = false", {
    skip("Interactive only due to user input")

    path <- test_path() %>% fs::path("data") %>%
        fs::dir_create(recurse = TRUE)

    if (path %>% fs::dir_exists()) {
        path %>% fs::dir_delete()
    }

    result <- ask_dir_create(dir = .path %>% fs::path("a/b/c"))
})

test_that("Ask: create directory: exists = true", {
    skip("Interactive only due to user input")

    path <- test_path() %>% fs::path("data") %>%
        fs::dir_create(recurse = TRUE)

    if (!(path %>% fs::dir_exists())) {
        path %>% fs::dir_create(recurse = TRUE)
    }

    result <- ask_dir_create(dir = .path %>% fs::path("a/b/c"))
})
