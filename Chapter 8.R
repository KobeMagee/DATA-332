get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

score <- function (symbols) {
  # identify case
  same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
  bars <- symbols %in% c("B", "BB", "BBB")
  # get prize
  if (same) {
    payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25,
                 "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[symbols[1]])
  } else if (all(bars)) {
    prize <- 5
  } else {
    cherries <- sum(symbols == "C")
    prize <- c(0, 2, 5)[cherries + 1]
  }
  # adjust for diamonds
  diamonds <- sum(symbols == "DD")
  prize * 2 ^ diamonds
}

play <- function() {
  symbols <- get_symbols()
  print(symbols)
  score(symbols)
}

play() 

one_play <- play()
one_play
attributes(one_play)

attr(one_play, "symbols") <- c("B", "0", "B")
attributes(one_play)
attr(one_play, "symbols")
one_play
one_play + 1

play <- function() {
  symbols <- get_symbols()
  prize <- score(symbols)
  attr(prize, "symbols") <- symbols
  prize
}

play()
two_play <- play()
two_play

play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols)
}
three_play <- play()
three_play

slot_display <- function(prize){
  # extract symbols
  symbols <- attr(prize, "symbols")
  # collapse symbols into single string
  symbols <- paste(symbols, collapse = " ")
  # combine symbol with prize as a regular expression
  # \n is regular expression for new line (i.e. return or enter)
  string <- paste(symbols, prize, sep = "\n$")
  # display regular expression in console without quotes
  cat(string)
}

slot_display(one_play)

symbols <- attr(one_play, "symbols")
symbols

prize <- one_play
string <- paste(symbols, prize, sep = "\n$")
string

cat(string)
slot_display(play())
slot_display(play())

print(pi)
pi
print(play())
play()

num <- 1000000000
print(num)

class(num) <- c("POSIXct", "POSIXt")
print(num)

print
print.POSIXct
print.factor
methods(print)

args(print)
print.slots <- function(x, ...) {
  cat("I'm using the print.slots method")
}

print(one_play)
one_play
rm(print.slots)

now <- Sys.time()
attributes(now)

print.slots <- function(x, ...) {
  slot_display(x)
}
one_play

play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols, class = "slots")
}

class(play())
play()
play()

methods(class = 'factor')

play1 <- play()
play1
play2 <- play()
play2
c(play1, play2)
play1[1]
