List Columns
================
2026-11-05

``` r
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.2.1     ✔ readr     2.2.0
    ## ✔ forcats   1.0.1     ✔ stringr   1.6.0
    ## ✔ ggplot2   4.0.3     ✔ tibble    3.3.1
    ## ✔ lubridate 1.9.5     ✔ tidyr     1.3.2
    ## ✔ purrr     1.2.2     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library(rvest)
```

    ## 
    ## Attaching package: 'rvest'
    ## 
    ## The following object is masked from 'package:readr':
    ## 
    ##     guess_encoding

``` r
library(p8105.datasets)

source("source/mean_and_sd.R")
source("source/nsduh_process.R")

set.seed(127)
```

## lists

``` r
l = list(
  vec_numeric = 5:8,
  mat         = matrix(1:8, 2, 4),
  vec_logical = c(TRUE, FALSE),
  summary     = summary(rnorm(1000)))
l
```

    ## $vec_numeric
    ## [1] 5 6 7 8
    ## 
    ## $mat
    ##      [,1] [,2] [,3] [,4]
    ## [1,]    1    3    5    7
    ## [2,]    2    4    6    8
    ## 
    ## $vec_logical
    ## [1]  TRUE FALSE
    ## 
    ## $summary
    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ## -2.93578 -0.67747 -0.02370 -0.01393  0.66968  3.00090

## `for` loops

``` r
list_norm = list(
  a = rnorm(20, 3, 4),
  b = rnorm(20, -14, 20),
  c = rnorm(20, 1000, 1000),
  d = rnorm(20, 0, 1)
)

list_norm
```

    ## $a
    ##  [1]  0.49794171  0.03510022 11.86349866  6.98921881  7.77702270  0.17018141
    ##  [7]  3.72683987  1.01907613  2.25703873  6.15029751  3.23910968  1.78239756
    ## [13] -0.82894252  8.88523188 -2.78389030  0.64289190  7.83379417  3.56246260
    ## [19] -3.03808961 -5.58077114
    ## 
    ## $b
    ##  [1] -21.128029   2.202968   5.359215 -35.382610 -14.156111 -30.734262
    ##  [7] -52.760305 -27.273630 -49.813028 -19.991561  13.058897 -16.356994
    ## [13] -31.380476 -23.203013 -26.217260   9.698452 -35.597319  -6.178445
    ## [19]  25.656690  -2.961472
    ## 
    ## $c
    ##  [1]   261.83049  1256.54891  1473.33848 -1044.44829  -803.09027    33.85241
    ##  [7]  1375.47646    42.11859  1904.01844   299.00640   791.33792  2596.57078
    ## [13]   266.56363 -1195.85970  2519.33964   283.18236  1024.74492   597.83255
    ## [19]  1677.03107  2204.24121
    ## 
    ## $d
    ##  [1] -0.08719072  1.13493055 -0.45368603 -0.19679847  0.10147687 -0.54607660
    ##  [7] -0.35143941 -0.67495087 -0.52368252 -1.11732225  1.71088104 -0.93517801
    ## [13]  0.36230905  1.27063006  0.04060574  0.95554327  0.65021959 -0.72317447
    ## [19] -1.05382457 -1.06132537

can i get mean and sd for each sample

``` r
mean_and_sd(list_norm[[1]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  2.71  4.46

``` r
mean_and_sd(list_norm[[2]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1 -16.9  20.9

``` r
mean_and_sd(list_norm[[3]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  778. 1110.

``` r
mean_and_sd(list_norm[[4]])
```

    ## # A tibble: 1 × 2
    ##      mean    sd
    ##     <dbl> <dbl>
    ## 1 -0.0749 0.842

can i do better?…yes

``` r
output = vector("list", length = 4)

for (i in 1:4){
  output[[i]] = mean_and_sd(list_norm[[i]])
}

output
```

    ## [[1]]
    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  2.71  4.46
    ## 
    ## [[2]]
    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1 -16.9  20.9
    ## 
    ## [[3]]
    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  778. 1110.
    ## 
    ## [[4]]
    ## # A tibble: 1 × 2
    ##      mean    sd
    ##     <dbl> <dbl>
    ## 1 -0.0749 0.842

## `map` instead

this is better!

``` r
output = map(list_norm, mean_and_sd)

output = map(list_norm, IQR)

output = map(list_norm, median)
```

what about map variants

``` r
output = map_df(list_norm, mean_and_sd)
output = map_dbl(list_norm, median)
```
