#' A output_Rmd Function
#'
#' This function can export the contents of the list to the Rmarkdown document.
#' @param input_values Data of type list.
#' @param file_name file name
#' @param filename_extension filename extension
#' @export
#' @examples
#' output_rmd()
output_rmd <-  function(input_values, file_name, filename_extension) {
  
  input_values$code_chunk <- "for(i in input_values){
  cat('\n')
  print(i)
  }"
  render_dir <- fs::path_temp(round(runif(1, 100000, 1000000), 0))
  rmd_path <- file.path(render_dir, "input.Rmd")
  output_path <- file.path(render_dir, "outputs.Rdata")
  fs::dir_create(render_dir, recurse = TRUE)
  save(input_values, file = output_path)
  
  if (!fs::file_exists(rmd_path)) {
    fs::file_copy("input.Rmd", rmd_path)
  }
  
  out <- rmarkdown::render(rmd_path, output_format = paste0(filename_extension,"_document"))
  file.copy(out, paste0(file_name,".",filename_extension))
}

