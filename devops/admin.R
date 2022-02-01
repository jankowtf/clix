
# Dev dependencies -------------------------------------------------------

renv::install("devtools")
renv::install("testthat")
renv::install("roxygen2")
renv::install("rmarkdown")
renv::install("hadley/emo")

# "Add the pipe"
usethis::use_pipe()

# Add package description
usethis::use_package_doc()

# Use {thestthat}
# usethis::use_testthat()

usethis::use_package("testthat", type = "Suggests")

# Prod dependencies -------------------------------------------------------

renv::install("logger")
usethis::use_package("logger")

renv::install("cli")
usethis::use_package("cli")

renv::install("rappster/valid", rebuild = TRUE)
usethis::use_dev_package("valid", type = "Imports", remote = "rappster/valid")

# Development notebook ----------------------------------------------------

usethis::use_roxygen_md()
roxygen2md::roxygen2md()

usethis::use_test("scratch")
usethis::use_test("cli")
usethis::use_test("ask")
usethis::use_test("log")
usethis::use_test("format")
usethis::use_test("implications")
usethis::use_test("input")

usethis::use_mit_license()
usethis::use_lifecycle()
usethis::use_lifecycle_badge("experimental")
usethis::use_readme_rmd()

usethis::use_build_ignore(
    c(
        "devops",
        "inst/examples",
        "tests"
    )
)

usethis::use_news_md()
usethis::use_version("dev")
