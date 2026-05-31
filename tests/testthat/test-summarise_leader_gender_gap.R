test_data <- tibble::tibble(
  decade = c(2000, 2000, 2000, 2010, 2010),
  president_gender = c("female", "male", "female", "male", "male"),
  president_accession_age = c(50, 60, 55, 65, 70),
  monarch_gender = c("female", "female", "male", "male", "male"),
  monarch_accession_age = c(25, 30, 35, 40, 45)
)

test_that("returns expected columns", {
  result <- summarise_leader_gender_gap(test_data)
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

test_that("president summary returns correct values for synthetic data", {
  result <- summarise_leader_gender_gap(test_data, leader = "president")

  # decade 2000: 2 female / 1 male of 3 → 2/3 female, 1/3 male
  expect_equal(result$prop_female_leaders[result$decade == 2000], 2/3)
  expect_equal(result$prop_male_leaders[result$decade == 2000],   1/3)

  # decade 2010: 0 female / 2 male
  expect_equal(result$prop_female_leaders[result$decade == 2010], 0)
  expect_equal(result$prop_male_leaders[result$decade == 2010],   1)

  # mean female accession age in decade 2000: mean(50, 55) = 52.5
  expect_equal(result$mean_female_accession_age[result$decade == 2000], 52.5)

  # mean male accession age in decade 2000: 60
  expect_equal(result$mean_male_accession_age[result$decade == 2000], 60)
})

test_that("monarch leader works", {
  result <- summarise_leader_gender_gap(test_data, leader = "monarch")

  # decade 2000: 2 female / 1 male of 3
  expect_equal(result$prop_female_leaders[result$decade == 2000], 2/3)

  # mean female monarch accession age in decade 2000: mean(25, 30) = 27.5
  expect_equal(result$mean_female_accession_age[result$decade == 2000], 27.5)
})

test_that("invalid leader type throws an error", {
  expect_error(
    summarise_leader_gender_gap(test_data, leader = "prime_minister")
  )
})

test_that("non-data-frame input throws an error", {
  expect_error(
    summarise_leader_gender_gap("not a data frame")
  )
})
