Geoms
==================
*http://sharpstatistics.co.uk/r/ggplot2-guide/*

Geoms are the names for the types of shapes that represent the data on the chart, and there are two main types. 
The `geom_point` is an example of geom that works on individual data points, and so is straight forward to use as already 
shown. 
However a collective geom such as geom_boxplot requires some collection of data to work on. So to produce a box plot,

```{r}
p <- ggplot(iris, aes(Species, Sepal.Width))
p + geom_boxplot()
```

The above plot shows a box plot of the Sepal.Width for each species. Note that Ggplot2 has automatically divided the data into the correct categories as the x axis variable is discrete. Now it is also equally valid to produce a box plot with continuous variable say Sepal.Length along the x axis.

```{r}
p<-ggplot(iris,aes(sepal.Length,Sepal.Width))
p+geom_boxplot()
```
which if tried produces a single box plot using all the data, not particularly useful. However use of the group command results in something a bit more useful
```{r}
p<-ggplot(iris,aes(Sepal.Length,Sepal.Width))
p+geom_boxplot(aes(group=Sepal.Length))
```
Making sure you have the **Plyr** package (which is a prerequisite of Ggplot2) loaded the size of the bins used for the box plot are easily adjusted with the help of the round_any function. Note this type of thing often gets a warning as typically the bins at the edge might not have enough data, as in this case where there is only one value of greater than 7.75.
```{r}
library(plyr)
p <- ggplot(iris, aes(Sepal.Length, Sepal.Width))
p + geom_boxplot(aes(group = round_any(Sepal.Length, 0.5)))
```
