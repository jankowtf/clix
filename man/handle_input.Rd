% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/input.R
\name{handle_input}
\alias{handle_input}
\title{Handler user input \ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}}
\usage{
handle_input(
  input_fn = input_yes_no_again_exit,
  implications_fn = function(answer) { },
  type = c("inner", "outer"),
  envir = parent.frame(),
  is_interactive = interactive()
)
}
\arguments{
\item{input_fn}{(\link{function}) Function to capture user input}

\item{implications_fn}{(\link{function}) Function to execute implications. Should
semantically "match" the input function}

\item{type}{(\link{character}) See \link[clix:::handle_input_]{clix::::handle_input_}

TODO-20220201-1620: check what 'inner' and 'outer' actually does - too long
ago ;-)}

\item{envir}{(\link{environment}) The environment in which to evaluate expression.}

\item{is_interactive}{[\link{logical}] Interactive mode yes/no}
}
\value{

}
\description{
Handler user input \ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}
}
\examples{
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
}
