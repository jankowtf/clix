\dontrun{
throw_error(msg = "This is an error")

error_code <- 1234
throw_error(msg = "This is an error (error code: {error_code})", )

throw_error(msg = "This is an error", .console = TRUE)
throw_error(msg = "This is an error", .log = TRUE)
}
