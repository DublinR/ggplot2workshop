# http://stackoverflow.com/questions/5380417/is-there-a-way-of-manipulating-ggplot-scale-breaks-and-labels

df <- data.frame(
        fac=rep(LETTERS[1:10], 100),
        x=rnorm(1000)
)

#################################

ggplot(df, aes(x=x)) + 
  geom_bar(binwidth=0.5) + 
  facet_grid(~fac) + 
  scale_x_continuous(formatter="percent")

#################################

ggplot(df, aes(x=x)) + 
  geom_bar(binwidth=0.5) + 
  facet_grid(~fac) + 
  scale_x_continuous(breaks = c(min(df$x), 0, max(df$x))
    , labels = c(paste( 100 * round(min(df$x),2), "%", sep = ""), paste(0, "%", sep = ""), paste( 100 * round(max(df$x),2), "%", sep = ""))
    )

#################################

myBreaks <- function(x){
    breaks <- c(min(x),median(x),max(x))
    names(breaks) <- attr(breaks,"labels")
    breaks
}

#################################

ggplot(df, aes(x=x)) + 
  geom_bar(binwidth=0.5) + 
  facet_grid(~fac) + 
  scale_x_continuous(breaks = myBreaks,labels = percent_format()) + 
  opts(axis.text.x = theme_text(angle = 90, hjust = 1,size = 5))
