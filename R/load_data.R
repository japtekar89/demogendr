#' Load the combined democracy and gender leadership dataset
#'
#' Reads the bundled `Combined_Democracy_Data.csv` file that ships with
#' `demogendr` and returns it as a tibble. The dataset is a country-year
#' panel built from the V-Dem / Democracy Tracker regime data, presidential
#' and monarchic leadership records, and World Bank women-in-parliament
#' indicators that were combined for the project.
#'
#' Each row represents one country in one year. Key columns include
#' `country_name`, `country` (ISO3), `year`, `is_democracy`,
#' `is_presidential`, `is_monarchy`, `is_female_president`,
#' `is_female_monarch`, and `prop_in_par` (percent of parliamentary seats
#' held by women).
#'
#' @return A [tibble][tibble::tibble-package] with one row per country-year.
#'
#' @importFrom readr read_csv
#' @export
#'
#' @examples
#' \dontrun{
#' dem <- load_data()
#' head(dem)
#' }
load_data <- function() {
  path <- system.file(
    "extdata", "Combined_Democracy_Data.csv",
    package = "demogendr"
  )

  if (!nzchar(path)) {
    stop(
      "Could not locate Combined_Democracy_Data.csv. ",
      "Was the package installed correctly?"
    )
  }

  readr::read_csv(path, show_col_types = FALSE)
}
