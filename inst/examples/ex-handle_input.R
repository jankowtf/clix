handle_input(
    input_fn = input_yes_no_again_exit,
    implications_fn = purrr::partial(
        .f = function(input) {
            if (input) {
                message("Yes")
            } else {
                message("No")
            }
        }
    )
)
