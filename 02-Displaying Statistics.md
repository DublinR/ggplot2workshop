Displaying Statistics
======================
You'll frequently want to add statistical analyses to your plots, or your plots may just be of statistical summaries anyway. ggplot2 has a few built in statistics to make plotting easier.

The most frequent statistic I use is a smoothing line with stat_smooth(). There are a number of different smoothing lines you can add, from local regression lines (loess) to linear or logistic regressions. Let's start with the mpg data again.

p <- ggplot(mpg, aes(displ, hwy))

p + geom_point() + stat_smooth()

By default, stat_smooth() has added a loess line with the standard error represented by a semi-transparent ribbon. You could also specify the method to use to add a different smoothing line.

p + geom_point() + stat_smooth(method = "lm")

library(MASS)
p + geom_point() + stat_smooth(method = "rlm")

Now, statistics are represented with default geometries. For stat_smooth(), its default geoms are geom_ribbon() + geom_smooth(). You could also (inadvisedly) represent the output of the smoothing function with points and errorbars.

p + stat_smooth(geom = "point")+stat_smooth(geom = "errorbar")
