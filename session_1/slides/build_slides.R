# Render all the xaringan Rmd files to HTML
rmd_files <- list.files(here::here("session_1", "slides"), pattern = "\\.Rmd", full.names = TRUE)

purrr::map(rmd_files, ~{
  withr::local_options(list(crayon.enabled = NULL))
  rmarkdown::render(.x, quiet = TRUE)
})

# Convert all the HTML slide files to PDFs
html_files <- list.files(here::here("session_1", "slides"), pattern = "\\.html", full.names = TRUE)

slides <- purrr::map(html_files, ~ list(html = .x, pdf = paste0(tools::file_path_sans_ext(.x), ".pdf")))

purrr::map(slides, ~{
  renderthis::to_pdf(
    .x$html,
    to = .x$pdf
  )
})
