# http://learnr.wordpress.com/2010/08/16/consultants-chart-in-ggplot2/

Set up dummy dataframe

```{r}
> library(ggplot2)
> set.seed(9876)
> DF <- data.frame(variable = 1:10, value = sample(10,
+     replace = TRUE))
> DF
```


#### Prepare the charts

Dougnut chart is essentially a bar chart using a polar coordinate system, so we start off with a simple bar chart. And to make life a bit more colourful will fill each slice with a different colour.


```{r}
> ggplot(DF, aes(factor(variable), value, fill = factor(variable))) +
+     geom_bar(width = 1)

```
Next the coordinate system is changed and some of the plot elements are removed for a cleaner look.
```{r}


> last_plot() + scale_y_continuous(breaks = 0:10) +
+     coord_polar() + labs(x = "", y = "") + opts(legend.position = "none",
+     axis.text.x = theme_blank(), axis.text.y = theme_blank(),
+     axis.ticks = theme_blank())
```

```{r}

set.seed(9876)

DF <- data.frame(variable = 1:10, value = sample(10,replace = TRUE))

last_plot() + scale_y_continuous(breaks = 0:10) +
   coord_polar() + labs(x = "", y = "") + opts(legend.position = "none",
   axis.text.x = theme_blank(), axis.text.y = theme_blank(),
   axis.ticks = theme_blank())
```

