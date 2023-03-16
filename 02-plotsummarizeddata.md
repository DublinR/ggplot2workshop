<!---http://www.dummies.com/how-to/content/how-to-plot-summarized-data-in-a-ggplot2-in-r.html-->

One very convenient feature of ggplot2 is its range of functions to summarize your R data in the plot. This means that you often don’t have to pre-summarize your data. For example, the height of bars in a histogram indicates how many observations of something you have in your data.

The statistical summary for this is to count the observations. Statisticians refer to this process as binning, and the default stat for geom_bar() is stat_bin().

Analogous to the way that each geom has an associated default stat, each stat also has a default geom.

So, this begs the question: How do you decide whether to use a geom or a stat? In theory it doesn’t matter whether you choose the geom or the stat first. In practice, however, it often is intuitive to start with a type of plot first — in other words, specify a geom. If you then want to add another layer of statistical summary, use a stat.

In this plot, you used the same data to first create a scatterplot with geom_point() and then you added a smooth line with stat_smooth().

Take a look at some practical examples of using stat functions.

<hr>

Stat	Description	Default Geom
stat_bin()	Counts the number of observations in bins.	geom_bar()
stat_smooth()	Creates a smooth line.	geom_line()
stat_sum()	Adds values.	geom_point()
stat_identity()	No summary. Plots data as is.	geom_point()
stat_boxplot()	Summarizes data for a box-and-whisker plot.	geom_boxplot()
How to bin data in ggplot2
You’ve already seen how to use stat_bin() to summarize your data into bins, because this is the default stat of geom_bar(). This means that the following two lines of code produce identical plots:

> ggplot(quakes, aes(x=depth)) + geom_bar(binwidth=50)
> ggplot(quakes, aes(x=depth)) + stat_bin(binwidth=50)
