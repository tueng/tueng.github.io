servr_dir <- 'D:/github/tueng.github.io/'
servr_command <- 'jekyll build'
servr_input_dir <- c(
  #'_rmd/statistics'
  '_rmd/r-tutorials'
  #'_rdm/data-analysis'
  )

servr_output_dir <- c(
  #'_posts/statistics'
  '_posts/r-tutorials'
  #'_posts/data-analysis'
  )

servr::jekyll(
  dir = servr_dir,
  input = servr_input_dir,
  output = servr_output_dir,
  serve = FALSE,
  command = servr_command
)

rm(servr_dir, servr_command, servr_input_dir, servr_output_dir)