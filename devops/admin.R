
# Dev dependencies -------------------------------------------------------

renv::install("devtools")
renv::install("testthat")

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

usethis::use_test("scratch")
usethis::use_test("cli")
usethis::use_test("demo")
