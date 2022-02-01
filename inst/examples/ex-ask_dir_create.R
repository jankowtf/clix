\dontrun{
path <- ask_dir_create(dir = fs::path(tempdir(), "a/b/c"))
path %>% fs::dir_exists()

ask_dir_create(dir = fs::path(tempdir(), "a/b/c"))
# Answer with an input of 2 ("No")

ask_dir_create(dir = fs::path(tempdir(), "a/b/c"))
# Answer with an input of 3 ("Let me start over")

ask_dir_create(dir = fs::path(tempdir(), "a/b/c"))
# Answer with an input of 4 ("Exit")
}
