Grouping
============================

ggplot2 represents data as grouped, and draws geoms and calculates statistics according tho these groupings. We've already seen an example of this, where lines of different colors aren't connected. Groups of data can be defined in two ways: as combinations of aesthetic settings, or explicitly with the argument group.

Let's start by looking at how statistics are calculated by groups.

ggplot(mpg, aes(displ, hwy, color = factor(cyl)))+
  geom_point()+
  stat_smooth(method = "lm")
