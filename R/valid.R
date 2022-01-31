valid_unit_test_packages <- function(package = character(), flip = FALSE) {
    packages <- c("testthat", "tinytest")
    names(packages) <- packages
    valid::valid(
        choice = package,
        choices = packages,
        flip = flip
    )
}

valid_unit_test_coverage_packages <- function(package = character(), flip = FALSE) {
    packages <- c("covr")
    names(packages) <- packages
    valid::valid(
        choice = package,
        choices = packages,
        flip = flip
    )
}

valid_dep_management_packages <- function(package = character(), flip = FALSE) {
    packages <- c("renv")
    names(packages) <- packages
    valid::valid(
        choice = package,
        choices = packages,
        flip = flip
    )
}

valid_ci_platforms <- function(platform = character(), flip = FALSE) {
    platforms <- c("github_actions", "travis_ci", "appveyor")
    names(platforms) <- platforms
    valid::valid(
        choice = platform,
        choices = platforms,
        flip = flip
    )
}

valid_ci_test_coverage_services <- function(platform = character(), flip = FALSE) {
    platforms <- c("codecov", "coveralls")
    names(platforms) <- platforms
    valid::valid(
        choice = platform,
        choices = platforms,
        flip = flip
    )
}

valid_readme_types <- function(type = character(), flip = FALSE) {
    types <- c("rmd", "md")
    names(types) <- types
    valid::valid(
        choice = type,
        choices = types,
        flip = flip
    )
}
