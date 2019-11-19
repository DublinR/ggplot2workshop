 plotfunc <- function(x){
  x +
    geom_point() +
    geom_smooth(se = FALSE, method = "lm",  color = "blue", size = 1) +
    theme(axis.title.x = element_text(size = 8, colour = 'black'),
         axis.title.y = element_text(size = 8, colour = 'black', angle = 90))+
    labs(title='this', x='that', y='the other')+
    theme_bw()
}

## plottitle <- "This is Title"
p <- ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width))
plotfunc(p)
