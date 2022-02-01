
<!-- README.md is generated from README.Rmd. Please edit that file -->

# clix

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## Installation

You can install the development version of clix from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("rappster/clix")
```

## What?

A custom CLI implementation that bundles

-   messages (in the broader sense)
-   querying for user input
-   executing the implications of a given user input

## Why?

When developing a new package I often find myself developing the “same
little CLI helpers” (a mix of messages, user input and implications of
that input) over and over again.

So this is primarily just a means of “DRY” for my own work.

But of course I also hope it’s useful for someone else out there.

## How?

The main functions all start with `ask_*()`.

These bundle

-   messages (in the broader sense)
-   querying for user input
-   executing the implications of a given user input

I felt like even with superb CLI tooling such as
[{cli}](https://cli.r-lib.org/index.html) those out-of-the-box bundles
are typically still missing - or I just didn’t find them yet 😉

Currently, there’s only on of these implemented yet: `ask_dir_create()`

## Simple example

I often run into situations where I might **expect** a directory to
already exist (because I might have created it while developing
something). However, in “clean start” scenarios (which might be the case
when using your package in production context) this might not be the
case.

So here’s a CLI-based way to handle such situations.

Let’s create a temporary directory first.

``` r
path <- fs::path(tempdir(), "a/b/c")
```

Then we’ll load the package

``` r
library(clix)
```

### Directory does not exist yet

``` r
path <- ask_dir_create(dir = path)
# ── Directory check ──────────────────────────────────────────
# Directory
# /var/folders/r1/_3hsv89s6rq2vl9nm31jjk700000gn/T/Rtmpyl8rUK/a/b/c
# does not exist yet.
# 
# Do you want to create it?
# 
# Answering Yes implies the following:
# • Directory
# /var/folders/r1/_3hsv89s6rq2vl9nm31jjk700000gn/T/Rtmpyl8rUK/a/b/c
# will be created
# 
# 
# 1: Yes
# 2: No
# 3: Let me start over
# 4: Exit
```

Answer with an input of 1 (“Yes”)

``` r
# Selection: 1
# ✓ Directory /var/folders/r1/_3hsv89s6rq2vl9nm31jjk700000gn/T/Rtmpyl8rUK/a/b/c created.

path %>% fs::dir_exists()
```

### Directory already not exist yet

``` r
ask_dir_create(dir = path)
# ── Directory check ──────────────────────────────────────────
# Directory
# /var/folders/r1/_3hsv89s6rq2vl9nm31jjk700000gn/T/Rtmpyl8rUK/a/b/c
# already exists.
# 
# There is nothing to do.
```

### Directory does not exist yet and you want to keep it that way

Let’s make sure the temp dir is deleted again before moving on

``` r
path %>% fs::dir_delete()
```

Answer with “No” (input = 2)

``` r
ask_dir_create(dir = path)
# ── Directory check ──────────────────────────────────────────
# Directory
# /var/folders/r1/_3hsv89s6rq2vl9nm31jjk700000gn/T/Rtmpyl8rUK/a/b/c
# does not exist yet.
# 
# Do you want to create it?
# 
# Answering Yes implies the following:
# • Directory
# /var/folders/r1/_3hsv89s6rq2vl9nm31jjk700000gn/T/Rtmpyl8rUK/a/b/c
# will be created
# 
# 
# 1: Yes
# 2: No
# 3: Let me start over
# 4: Exit
```

``` r
# Selection: 2
# ! Directory '/var/folders/r1/_3hsv89s6rq2vl9nm31jjk700000gn/T/Rtmpyl8rUK/a/b/c' was not created
# Warning message:
# In throw_warning(., .console = TRUE) :
#   Directory '/var/folders/r1/_3hsv89s6rq2vl9nm31jjk700000gn/T/Rtmpyl8rUK/a/b/c' was not created
```

Answer with “Let me start over” (input = 3)

``` r
ask_dir_create(dir = path)
# ── Directory check ──────────────────────────────────────────
# Directory
# /var/folders/r1/_3hsv89s6rq2vl9nm31jjk700000gn/T/Rtmpyl8rUK/a/b/c
# does not exist yet.
# 
# Do you want to create it?
# 
# Answering Yes implies the following:
# • Directory
# /var/folders/r1/_3hsv89s6rq2vl9nm31jjk700000gn/T/Rtmpyl8rUK/a/b/c
# will be created
# 
# 
# 1: Yes
# 2: No
# 3: Let me start over
# 4: Exit
```

``` r
# Selection: 3
# Starting over...
#  
# 1: Yes
# 2: No
# 3: Let me start over
# 4: Exit
```

Answer with “Exit” (input = 4)

``` r
ask_dir_create(dir = path)
# ── Directory check ──────────────────────────────────────────
# Directory
# /var/folders/r1/_3hsv89s6rq2vl9nm31jjk700000gn/T/Rtmpyl8rUK/a/b/c
# does not exist yet.
# 
# Do you want to create it?
# 
# Answering Yes implies the following:
# • Directory
# /var/folders/r1/_3hsv89s6rq2vl9nm31jjk700000gn/T/Rtmpyl8rUK/a/b/c
# will be created
# 
# 
# 1: Yes
# 2: No
# 3: Let me start over
# 4: Exit
```

``` r
# Selection: 4
# Exiting
```
