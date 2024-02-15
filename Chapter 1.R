
R version 4.3.2 (2023-10-31 ucrt) -- "Eye Holes"
Copyright (C) 2023 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> 1 + 1
[1] 2
> 100:130
[1] 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119
[21] 120 121 122 123 124 125 126 127 128 129 130
> 5 -
  + 
  + 1
[1] 4
> 3 % 5
Error: unexpected input in "3 % 5"
> 2 * 3
[1] 6
> 4 - 1
[1] 3
> 2 * 3
[1] 6
> ## 6
  > 7 + 2
[1] 9
> 9 * 3
[1] 27
> 27 - 6
[1] 21
> 21 / 3
[1] 7
> 1:6
[1] 1 2 3 4 5 6
> a <- 1
> a
[1] 1
> a + 2
[1] 3
> die <- 1:6
> die
[1] 1 2 3 4 5 6
> my_number <- 1
> my_number
[1] 1
> my_number <- 999
> my_number
[1] 999
> ls()
[1] "a"         "die"       "my_number"
> die - 1
[1] 0 1 2 3 4 5
> die / 2
[1] 0.5 1.0 1.5 2.0 2.5 3.0
> die * die
[1]  1  4  9 16 25 36
> 1:2
[1] 1 2
> 1:4
[1] 1 2 3 4
> die
[1] 1 2 3 4 5 6
> die + 1:2
[1] 2 4 4 6 6 8
> die + 1:4
[1] 2 4 6 8 6 8
Warning message:
  In die + 1:4 :
  longer object length is not a multiple of shorter object length
> die %*% die
[,1]
[1,]   91
> die %o% die
[,1] [,2] [,3] [,4] [,5] [,6]
[1,]    1    2    3    4    5    6
[2,]    2    4    6    8   10   12
[3,]    3    6    9   12   15   18
[4,]    4    8   12   16   20   24
[5,]    5   10   15   20   25   30
[6,]    6   12   18   24   30   36
> round(3.1415)
[1] 3
> factorial(3)
[1] 6
> mean(1:6)
[1] 3.5
> mean(die)
[1] 3.5
> round(mean(die))
[1] 4
> sample(x = 1:4, size = 2)
[1] 2 3
> sample(x = die, size = 1)
[1] 4
> sample(x = die, size = 1)
[1] 4
> 
  > sample(x = die, size = 1)
[1] 5
> sample(x = die, size = 1)
[1] 1
> sample(die, size = 1)
[1] 2
> round(3.1415, corners = 2)
Error in round(3.1415, corners = 2) : unused argument (corners = 2)
> args(round)
function (x, digits = 0) 
  NULL
> round(3.1415, digits = 2)
[1] 3.14
> sample(die, 1)
[1] 4
> sample(size = 1, x = die)
[1] 1
> sample(die, size = 2)
[1] 2 3
> sample(die, size = 2)
[1] 4 1
> sample(die, size = 2, replace = TRUE)
[1] 2 2
> sample(die, size = 2, replace = TRUE)
[1] 3 5
> sample(die, size = 2, replace = TRUE)
[1] 3 3
> sample(die, size = 2, replace = TRUE)
[1] 2 1
> dice <- sample(die, size = 2, replace = TRUE) dice
Error: unexpected symbol in "dice <- sample(die, size = 2, replace = TRUE) dice"
> dice <- sample(die, size = 2, replace = TRUE) 
> dice
[1] 5 5
> sum(dice)
[1] 10
> dice
[1] 5 5
> dice
[1] 5 5
> dice
[1] 5 5
> die <- 1:6 
> dice <- sample(die, size = 2, replace = TRUE) 
> sum(dice)
[1] 7
> dice <- 1:6
> dice <- sample(die, size = 2, replace = TRUE)
> sum(dice)
[1] 7
> roll <- function() { 
    +   die <- 1:6dice <- sample(die, size = 2, replace = TRUE)  sum(dice) }
  Error: unexpected symbol in:
    "roll <- function() { 
  die <- 1:6dice"
  > roll <- function() { 
    +   die <- 1:6
    +   dice <- sample(die, size = 2, replace = TRUE)
    +   sum(dice)
    + }
  > roll()
  [1] 8
  > roll()
  [1] 3
  > roll()
  [1] 8
  > roll()
  [1] 6
  > dice
  [1] 4 3
  > dice
  [1] 4 3
  > 1 + 1
  [1] 2
  > sqrt(2)
  [1] 1.414214
  > dice <- sample(die, size = 2, replace = TRUE)
  > two <- 1 + 1
  > a <- sqrt(2)
  > roll2 <- function() {  
    +     dice <- sample(bones, size = 2, replace = TRUE)  
    +     sum(dice) 
    + }
  > roll2()
  Error in roll2() : object 'bones' not found
  > roll2 <- function(bones) {  
    +     dice <- sample(bones, size = 2, replace = TRUE)  
    +     sum(dice) 
    + }
  > roll2(bones = 1:4)
  [1] 2
  > roll2(bones = 1:6)
  [1] 4
  > roll2(1:20)
  [1] 23
  > roll2()
  Error in roll2() : argument "bones" is missing, with no default
  > roll2 <- function(bones = 1:6) {  
    +     dice <- sample(bones, size = 2, replace = TRUE)  
    +     sum(dice) 
    + }
  > roll2()
  [1] 11
  > 