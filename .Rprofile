if (interactive()) {
  suppressMessages(require(devtools))
  suppressMessages(require(testthat))
}

if (interactive() && Sys.getenv("RSTUDIO") == "") {
  init_path <- file.path(Sys.getenv(if (.Platform$OS.type == "windows") "USERPROFILE" else "HOME"), ".vscode-R", "init.R")
  source(init_path)
  # Workaround .vsc.attach()
  .First.sys()
}

lint_it <- function(path = ".") {
  linters <- c(
    lintr::assignment_linter(),
    lintr::commas_linter(),
    lintr::infix_spaces_linter(),
    lintr::line_length_linter(120),
    lintr::object_name_linter(styles = "snake_case"),
    lintr::spaces_left_parentheses_linter(),
    lintr::trailing_blank_lines_linter(),
    lintr::trailing_whitespace_linter()
  )
  lintr::lint_package(path = path, linters = linters)
}
