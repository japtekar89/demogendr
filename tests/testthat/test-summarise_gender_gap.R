test_data <- tibble::tibble(
  decade = c(2000, 2000, 2000, 2010, 2010),
  gender = c("female", "male", "female", "male", "male"),
  age    = c(50, 60, 55, 65, 70)
)

test_that("helper returns the expected column structure", {
  result <- demogendr:::summarise_gender_gap(
    test_data,
    group_var  = "decade",
    gender_var = "gender",
    age_var    = "age"
  )

  expect_named(
    result,
    c(
      "decade",
      "prop_female_leaders",
      "prop_male_leaders",
      "mean_female_accession_age",
      "mean_male_accession_age"
    )
  )
})

test_that("helper computes correct proportions and means", {
  result <- demogendr:::summarise_gender_gap(
    test_data,
    group_var  = "decade",
    gender_var = "gender",
    age_var    = "age"
  )

  # decade 2000: 2 female / 3 total
  expect_equal(result$prop_female_leaders[result$decade == 2000], 2/3)
  expect_equal(result$prop_male_leaders[result$decade == 2000],   1/3)

  # mean female age in decade 2000: mean(50, 55) = 52.5
  expect_equal(result$mean_female_accession_age[result$decade == 2000], 52.5)

  # mean male age in decade 2010: mean(65, 70) = 67.5
  expect_equal(result$mean_male_accession_age[result$decade == 2010], 67.5)
})
