packages <- c(
  "fabricatr",
  "uuid",
  "readr",
  "fs"
)

new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]

if(length(new_packages)) install.packages(new_packages)


library(fabricatr)
# library(ggplot2)
library(uuid)


heart_rate <- fabricate(
  N = 100000,
  ID = NULL,
  Age = round(rnorm(N, mean = 35, sd = 7)),
  Gender = draw_binary(N, prob = 0.51, link = "identity"),
  HR_Resting = round(rnorm(N, mean = 70, sd = 15)),
  HR_Excercise = round(rnorm(N, mean = 140, sd = 20)),
)

write.csv(heart_rate, file = sprintf("data/%s.csv", UUIDgenerate()), row.names = FALSE)
