R Graphics Cookbook - Chapter 3: Bar Graphs

3.1 - Making a Basic Bar Graph
3.2 - Grouping Bars Together
3.3 - Making a Bar Graph of Counts
3.4 - Using Colors in a Bar Graph
3.5 - Coloring Negative and Positive Bars Differently
3.6 - Adjusting Bar Width and Spacing
3.7 - Making a Stacked Bar Graph
3.8 - Making a Proportional Stacked Bar Graph
3.9 - Adding Labels to a Bar Graph
3.10 - Making a Cleveland Dot Plot

Libraries needed for this chapter

library(gcookbook)
library(ggplot2)
library(plyr) #Is this automatically loaded with ggplot2?
library(dplyr)
## 
## Attaching package: 'dplyr'
## 
## The following objects are masked from 'package:plyr':
## 
##     arrange, count, desc, failwith, id, mutate, rename, summarise,
##     summarize
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
3.1 - Making a Basic Bar Graph
You have a data frame where one column represents the x position of each bar, and another column represents the vertical (y) height of each bar.

ggplot(pg_mean, aes(x=group, y=weight)) + 
  geom_bar(stat='identity')


ggplot(pg_mean, aes(x=group, y=weight)) + 
  geom_bar(stat='identity', fill='lightblue', color='black')


You can converte a continuous variable to a discrete variable by using factor()
ggplot(BOD, aes(x=Time, y=demand)) + 
  geom_bar(stat='identity')


ggplot(BOD, aes(x=factor(Time), y=demand)) + 
  geom_bar(stat='identity')


3.2 - Grouping Bars Together
You want to group bars together by a second variable.

use the fill parameter in aes() of ggplot()
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + 
  geom_bar(position='dodge', stat='identity')


ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + 
  geom_bar(stat='identity', position='dodge', color='black') + 
  scale_fill_brewer(palette='Pastel1')


3.3 - Making a Bar Graph of Counts
Your data has one column representing each case, and you want plot counts of the cases.

ggplot(diamonds, aes(x=cut)) + 
  geom_bar()


ggplot(diamonds, aes(x=cut)) + 
  geom_bar(stat='bin')


If we use a continuous variable on the x-axis, versus a dicrete variable, we’ll get a histogram. It turns out that in this case, the result is the same as if we had used geom_histogram() instead of geom_bar()
3.4 - Using Colors in a Bar Graph
You want to use different colors for the bars in your graph.

use scale_fill_manual_()
#upc = subset(uspopchange, rank(Change) > 40)
#upc = uspopchange[which(rank(uspopchange$Change) > 40),]
upc = filter(uspopchange, rank(Change) > 40)
ggplot(upc, aes(x=Abb, y=Change, fill=Region)) + 
  geom_bar(stat='identity')


ggplot(upc, aes(x = reorder(Abb, Change), y=Change, fill=Region)) + 
  geom_bar(stat='identity', color='black') + 
  scale_fill_manual(values = c('#669933', '#FFCC66')) + xlab('State')
 - reorder() takes will order the first argument, which typically is a factor, by the second argument, which is typically numeric.

3.5 - Coloring Negative and Positive Bars Differently
You want to use different colors for negative and positive-valued bars.

Create a logical variable specifying the positive value of the number and specify the coloring based on this variable.
#csub = subset(climate, Source=="Berkley" & Year >= 1900)
#csub$pos = csub$Anomly >= 0
csub = climate %>% 
  filter(Source == "Berkeley", Year >= 1900) %>%
  mutate(pos = Anomaly10y >= 0)

ggplot(csub, aes(x=Year, y=Anomaly10y, fill=pos)) + 
  geom_bar(stat='identity', position='identity')


ggplot(csub, aes(x=Year, y=Anomaly10y, fill=pos)) + 
  geom_bar(stat='identity', position = 'identity', color='black', size=0.25) +
  scale_fill_manual(values=c('#CCEEFF','#FFDDDD'), guide = FALSE)


Using position = ‘identity’ with the bars will prevent a warning message about stacking not being well defined for negative numbers.
3.6 - Adjusting Bar Width and Spacing
You want to adjust the width of bars and the spacing between them.

Use the width parameter in geom_bar()
ggplot(pg_mean, aes(x=group, y=weight)) + 
  geom_bar(stat='identity')


ggplot(pg_mean, aes(x=group, y=weight)) + 
  geom_bar(stat='identity', width=0.5)


ggplot(pg_mean, aes(x=group, y=weight)) + 
  geom_bar(stat='identity', width=1)


For grouped bars, the default is to have no space between bars within each group. To add space between bars within a group, make width smaller and set the value for position_dodge to be largerthan width.
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + 
  geom_bar(stat='identity', width=0.5, position='dodge')


ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + 
  geom_bar(stat='identity', width=0.5, position=position_dodge(0.7))


All of these will have the same result because the default width = 0.9

geom_bar(position='dodge')
geom_bar(width=0.9, position=position_dodge())
geom_bar(position=position_dodge(0.9))
geom_bar(width=0.9, position=position_dodge(width=0.9))
3.7 - Making a Stacked Bar Graph
You want to make a stacked bar graph

This is the default drawing method when position in **geom_bar* is not specified.
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + 
  geom_bar(stat='identity')


The stacking order is the opposite of the order of items in the legend. Reverse the order of items in the legend with guides()
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar))+
  geom_bar(stat='identity') +
  guides(fill=guide_legend(reverse=T))


Or reverse the stacking order
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar, order=desc(Cultivar))) + 
  geom_bar(stat='identity')


polish it up
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat='identity', color='black') + 
  guides(fill=guide_legend(reverse=T)) +
  scale_fill_brewer(palette="Pastel2")


3.8 - Making a Proportional Stacked Bar Graph
You want to make a stacked bar graph that shows proportions (also called a 100% stacked bar graph).

use ddply to calcuate the weight percentages, split by “Date”.
#ce = ddply(cabbage_exp, "Date", transform, percent_weight = Weight/sum(Weight) * 100)
ce = ddply(cabbage_exp, "Date", mutate, percent_weight = Weight/sum(Weight) * 100)

ggplot(ce, aes(x=Date, y=percent_weight, fill=Cultivar)) + 
  geom_bar(stat='identity')


make pretty
ggplot(ce, aes(x=Date, y=percent_weight, fill=Cultivar)) + 
  geom_bar(stat='identity', color='black') + 
  guides(fill=guide_legend(reverse=T)) + 
  scale_fill_brewer(palette='Pastel1')


3.9 - Adding Labels to a Bar Graph
You want to add labels to the bars in a bar graph

use vjust in geom_text()
ggplot(cabbage_exp, aes(x=interaction(Date, Cultivar), y=Weight)) + 
  geom_bar(stat='identity') + 
  geom_text(aes(label=Weight), vjust=1.5, color='white')


ggplot(cabbage_exp, aes(x=interaction(Date, Cultivar), y=Weight)) + 
  geom_bar(stat='identity') + 
  geom_text(aes(label=Weight), vjust=-.05)


Changing the size of the text to fit within grouped bars, use size parameter in geom_text()
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + 
  geom_bar(stat='identity', position='dodge') + 
  geom_text(aes(label=Weight), vjust=1.5, color='white', position=position_dodge(.9), size=3)
## ymax not defined: adjusting position using y instead


Putting labels on stacked bar graphs requires finding the cumulative sum for each stack.
ce = arrange(cabbage_exp, Date, Cultivar)
#ce = ddply(ce, "Date", transform, label_y = cumsum(Weight))
ce = ddply(ce, "Date", mutate, label_y = cumsum(Weight))

ggplot(ce, aes(x=Date, y=Weight, fill=Cultivar)) + 
  geom_bar(stat='identity') +
  geom_text(aes(y=label_y, label=Weight), vjust=1.5, color='white')


To put labels in the middle of each bar, there must be an adjustment to the cumulative sum, and the y offset in geom_bar() can be removed:
ce = arrange(cabbage_exp, Date, Cultivar)

ce = ddply(ce, "Date", mutate, label_y=cumsum(Weight) - .5*Weight)

ggplot(ce, aes(x=Date, y=Weight, fill=Cultivar)) + 
  geom_bar(stat='identity') + 
  geom_text(aes(y=label_y, label=Weight), coloor='white')


A more polished graph
ggplot(ce, aes(x=Date, y=Weight, fill=Cultivar)) + 
  geom_bar(stat='identity', color = 'black') + 
  geom_text(aes(y=label_y, label=paste(format(Weight, nsmall=2), "kg")), size=4) +
  guides(fill=guide_legend(reverse=T)) + 
  scale_fill_brewer(palette='Pastel1')


3.10 - Making a Cleveland Dot Plot
You want to make a Cleveland dot plot

The simplest way to create a dot plot is to use geom_point()
tophit = tophitters2001[1:25, ]
ggplot(tophit, aes(x=avg, y=name)) + geom_point()


Order the y-axis with reorder()
ggplot(tophit, aes(x=avg, y=reorder(name, avg))) + 
  geom_point(size = 3) +
  theme_bw() + 
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(color='grey60', linetype='dashed'))


Now let’s swap the x and y-axis as well as rotate the text labels.

ggplot(tophit, aes(x=reorder(name,avg), y=avg)) + 
  geom_point(size=3) + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle=60, hjust = 1),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.x = element_line(color="grey60", linetype='dashed'))


reorder() will only order factor levels by one other variable. To order the factor levels by two variables, we must do it manually. We can separate the groups by coloring on lg.
#nameorder = tophit$name[order(tophit$lg, tophit$avg)]
nameorder = tophit %>% arrange(lg, avg) %>% select(name)

#tophit$name = factor(tophit$name, levels=nameorder)
tophit = mutate(tophit, name = factor(name, levels=nameorder[[1]]))

ggplot(tophit, aes(x=avg, y=name)) + 
  geom_segment(aes(yend=name), xend=0, color='grey50') + 
  geom_point(size=3, aes(color=lg)) + 
  scale_color_brewer(palette="Set1", limits=c('NL', 'AL')) + 
  theme_bw() +
  theme(panel.grid.major.y = element_blank(),
        legend.position=c(1,0.55),
        legend.justification=c(1,0.5))


Another way to separate the two groups is to use facets.
ggplot(tophit, aes(x=avg, y=name)) +
  geom_segment(aes(yend=name), xend=0, color='grey50') +
  geom_point(size=3, aes(color=lg)) + 
  scale_color_brewer(palette='Set1', limits=c('NL', 'AL'), guide=F) +
  theme_bw() +
  theme(panel.grid.major.y = element_blank()) +
  facet_grid(lg ~ ., scales='free_y', space='free_y')
