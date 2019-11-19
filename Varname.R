foo <- rnorm(100)
number <- 1
chart_title <- substitute(paste("Chart no. ",number,": ",alpha," vs ",beta,sep=""), list(number = number))
qplot(foo,foo) + opts(title = chart_title)
