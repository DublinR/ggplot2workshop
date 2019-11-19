R Graphics Cookbook - Chapter 4: Line Graphs
Edgar Scott

4.1 - Making a Basic Line Graph
4.2 - Adding Points to a Line Graph
4.3 - Making a Line Graph with Multiple Lines
4.4 - Changing the Appearance of Lines
4.5 - Changing the Appearance of Points
4.6 - Making a Graph with a Shaded Area
4.7 - Making a Stacked Area Graph
4.8 - Making a Proportional Stacked Area Graph
4.9 - Adding a Confidence Region
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
4.1 - Making a Basic Line Graph
You want to make a basic line graph.

use geom_line()
ggplot(BOD, aes(x=Time, y=demand)) + geom_line()


When the x variable is a factor, you must also use aes(group=1) to ensure that ggplot() knows that the data points belong together and should be connected with a line.
BOD1 = mutate(BOD, Time = factor(Time))
ggplot(BOD1, aes(x=Time, y=demand, group=1)) + geom_line()


Setting the limits on the y-axis
ggplot(BOD, aes(x=Time, y=demand)) + 
  geom_line() + 
  ylim(0, max(BOD$demand))


ggplot(BOD, aes(x=Time, y=demand)) + 
  geom_line() +
  expand_limits(y=0)


4.2 - Adding Points to a Line Graph
use geom_point()
ggplot(BOD, aes(x=Time, y=demand)) + geom_line() + geom_point()


Useful to add points when the observations are not at regular intervals
ggplot(worldpop, aes(x=Year, y=Population)) + geom_line() + geom_point()


ggplot(worldpop, aes(x=Year, y=Population)) + geom_line() + geom_point() + scale_y_log10()


4.3 - Making a Line Graph with Multiple Lines
You want to make a line graph with more than one line.

Map another (discrete) variable to color or linetype
tg = ddply(ToothGrowth, .(supp, dose), summarise, length=mean(len))
ggplot(tg, aes(x=dose, y=length, color=supp)) + geom_line()


ggplot(tg, aes(x=dose, y=length, linetype=supp)) + geom_line()


What if dose is treated as a categorical variable instead of a continuous variable? Convert dose to a factor and use group.
ggplot(tg, aes(x=factor(dose), y=length, color=supp, group=supp)) + geom_line()


You can also use shape and fill for grouping with lines and points
ggplot(tg, aes(x=dose, y=length, shape=supp)) + geom_line() + geom_point(size=4)


ggplot(tg, aes(x=dose, y=length, fill=supp)) + geom_line() + geom_point(size=4, shape=21)


you can also “dodge” overlapping points.
ggplot(tg, aes(x=dose, y=length, shape=supp)) +
  geom_line(position=position_dodge(0.2)) +
  geom_point(position=position_dodge(0.2), size=4)
## ymax not defined: adjusting position using y instead
## ymax not defined: adjusting position using y instead


4.4 - Changing the Appearance of Lines
You want to change the appearance of the lines in a line graph

Change the line type with linetype, the line thickness with size, and the color with color.
ggplot(BOD, aes(x=Time, y=demand)) + 
  geom_line(linetype='dashed', size=1, color='blue')


using different colors with scale_color_brewer()
tg = ddply(ToothGrowth, .(supp, dose), summarise, length=mean(len))

ggplot(tg, aes(x=dose, y=length, color=supp)) +
  geom_line() +
  scale_color_brewer(palette='Set1')


To set constant colors, line types, size, and points shape for all lines, specify color, size, linetype, and shape outside of aes().
ggplot(tg, aes(x=dose, y=length, group=supp)) +
  geom_line(color='darkgreen', size=1.5)


ggplot(tg, aes(x=dose, y=length, color=supp)) +
  geom_line(linetype='dashed') +
  geom_point(shape=22, size=3, fill='white')


4.5 - Changing the Appearance of Points
You want to change the appearance of the points in a line graph.

In geom_point(), set the size, shape, color, or fill outside of aes()
ggplot(BOD, aes(x=Time, y=demand)) +
  geom_line() +
  geom_point(size=4, shape=22, color='darkred', fill='pink')


hollow points
ggplot(BOD, aes(x=Time, y=demand)) +
  geom_line() +
  geom_point(size=4, shapae=21, fill='white')


using scale_fill_manual() with plotting multiple lines
tg = ddply(ToothGrowth, .(supp, dose), summarise, length=mean(len))
pd = position_dodge(0.2)
ggplot(tg, aes(x=dose, y=length, fill=supp)) + 
  geom_line(position=pd) + 
  geom_point(shape=21, size=3, position=pd) + 
  scale_fill_manual(values=c('purple', 'gold'))
## ymax not defined: adjusting position using y instead
## ymax not defined: adjusting position using y instead


4.6 - Making a Graph with a Shaded Area
You want to make a graph with a shaded area

use geom_area()
sunspotyear = data.frame(
  Year = as.numeric(time(sunspot.year)),
  Sunspots = as.numeric(sunspot.year))

ggplot(sunspotyear, aes(x=Year, y=Sunspots)) + geom_area()


change the color and transparency
ggplot(sunspotyear, aes(x=Year, y=Sunspots)) +
  geom_area(color='black', fill='blue', alpha=.2)


draw the area without an outline (by not specifying color), and then layer a geom_line() on top.
ggplot(sunspotyear, aes(x=Year, y=Sunspots)) +
  geom_area(fill='blue', alpha=.2) +
  geom_line()


4.7 - Making a Stacked Area Graph
You want to make a stacked area graph

use geom_area() and map factor to fill
ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) + geom_area()


reverse the legend order, change the color and transparency
ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) +
  geom_area(color = 'black', size=.2, alpha=.2) + 
  scale_fill_brewer(palette='Blues', breaks=rev(levels(uspopage$AgeGroup)))


reorder stacking
ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup, order=desc(AgeGroup))) + 
  geom_area(color='black', size=.2, alpha=.4) +
  scale_fill_brewer(palette='Blues')


eliminate the left and right outlines
ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup, order=desc(AgeGroup))) +
  geom_area(color=NA, alpha=.4) +
  scale_fill_brewer(palette='Blues') +
  geom_line(position='stack', size=.2)
## ymax not defined: adjusting position using y instead


4.8 - Making a Proportional Stacked Area Graph
You want to make a stacked graph with the overall height scaled to a constant value.

calculate the proportions
uspopage_prop = ddply(uspopage, .(Year), mutate, Percent = Thousands/ sum(Thousands)*100)

ggplot(uspopage_prop, aes(x=Year, y=Percent, fill=AgeGroup)) + 
  geom_area(color='black', size=.2, alpha=.4) + 
  scale_fill_brewer(palette='Blues', breaks=rev(levels(uspopage$AgeGroup)))


4.9 - Adding a Confidence Region
You wnat to add a confidence region to a graph.

use geom_ribbon() and map values to ymin and ymax
clim = climate %>% filter(Source == 'Berkeley') %>% select(Year, Anomaly10y, Unc10y)
ggplot(clim, aes(x=Year, y=Anomaly10y)) +
  geom_ribbon(aes(ymin=Anomaly10y-Unc10y, ymax=Anomaly10y+Unc10y), alpha=0.2) +
  geom_line()


use dotted lines instead of shaded area
ggplot(clim, aes(x=Year, y=Anomaly10y)) + 
  geom_line(aes(y=Anomaly10y-Unc10y), color='grey50', linetype = 'dotted') + 
  geom_line(aes(y=Anomaly10y+Unc10y), color='grey50', linetype='dotted') + 
  geom_line()
