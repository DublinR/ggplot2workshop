R Graphics Cookbook - Chapter 5: Scatter Plots
============================================

5.1 - Making a Basic Scatter Plot
5.2 - Grouping Data Points by a Variable Using Shape or Color
5.3 - Using Different Point Shapes
5.4 - Mapping a Continuous Variable to Color or Size
5.5 - Dealing with Overplotting
5.6 - Adding Fitted Regression Model Lines
5.7 - Adding Fitted Lines from an Existing Model (THIS IS HEAVY)
5.8 - Adding Fitted Lines from Multiple Existing Models
5.9 - Adding Annotations with Model Coefficients
5.10 - Adding Marginal Rugs to a Scatter Plot
5.11 - Labeling Points in a Scatter Plot
5.12 - Creating a Balloon Plot
5.13 Making a Scatter Plot Matrix
Libraries needed for this chapter

library(gcookbook)
library(ggplot2)
library(plyr) #Is this automatically loaded with ggplot2?
library(MASS)
library(dplyr)
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:MASS':
## 
##     select
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
library(hexbin)
5.1 - Making a Basic Scatter Plot
You want to make a scatter plot.

Use geom_point(), and map one variable to x and one to y
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point()


use different shapes with shape
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point(shape=21)


use different sizes with size
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point(size=1.5)


5.2 - Grouping Data Points by a Variable Using Shape or Color
You want to group points by some variable, using shape or color.

Map the grouping variable to shape or color.
ggplot(heightweight, aes(x=ageYear, y=heightIn, color=sex)) + 
  geom_point()


ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point(aes(color=sex))


ggplot(heightweight, aes(x=ageYear, y=heightIn, shape=sex)) + geom_point()


mapping to both shape and color
ggplot(heightweight, aes(x=ageYear, y=heightIn, shape=sex, color=sex)) + geom_point()


making stuff prettier
ggplot(heightweight, aes(x=ageYear, y=heightIn, shape=sex, color=sex)) +
  geom_point() + 
  scale_shape_manual(values=c(1,2)) +
  scale_color_brewer(palette='Set1')


5.3 - Using Different Point Shapes
You want to use point shapes that are different from the defaults.

Specify the shape in geom_point() to set the shape of all points.
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point(shape=3)


If you have mapped a variab le to shape, use scale_shape_manual() to change the shapes
ggplot(heightweight, aes(x=ageYear, y=heightIn, shape=sex)) +
  geom_point(size=3) + scale_shape_manual(values=c(1,4))


You can have the shape represent one variable and the fill represent another variable. (Why would you want to do this?)
hw = heightweight %>% mutate(weightGroup = cut(weightLb, breaks=c(-Inf, 100, Inf),labels=c("< 100", ">=100")))

ggplot(hw, aes(x=ageYear, y=heightIn, shape=sex, fill=weightGroup)) +
  geom_point(size=2.5) +
  scale_shape_manual(values=c(21,24)) +
  scale_fill_manual(values=c(NA, 'black'), 
                    guide=guide_legend(override.aes=list(shape=21)))


5.4 - Mapping a Continuous Variable to Color or Size
You want to represent a third continusous variable using color or size

Map the continusous variable to size or color
ggplot(heightweight, aes(x=ageYear, y=heightIn, color=weightLb)) + geom_point()


ggplot(heightweight, aes(x=ageYear, y=heightIn, color=weightLb)) + geom_point()


-Using **scale_fill_gradient()* with a third continuous variable

ggplot(heightweight, aes(x=weightLb, y=heightIn, fill=ageYear)) +
  geom_point(shape=21, size=2.5) + 
  scale_fill_gradient(low='black', high='white')


ggplot(heightweight, aes(x=weightLb, y=heightIn, fill=ageYear)) +
  geom_point(shape=21, size=2.5) +
  scale_fill_gradient(low='black', high='white', breaks=12:17, 
                      guide=guide_legend())


Plotting with a third and fourth variable where one is continuous and the other is categorical.
ggplot(heightweight, aes(x=ageYear, y=heightIn, size=weightLb, color=sex)) +
  geom_point(alpha=.5) +
  scale_size_area() +
  scale_color_brewer(palette='Set1')


5.5 - Dealing with Overplotting
You have many points and they obscure each other

You have several options:

Make the points semitransparent
Bin the data into rectangles
Bin the data into hexagons
Use box plots
sp = ggplot(diamonds, aes(x=carat, y=price))
sp + geom_point()


make the points transparent
sp + geom_point(alpha=.1)


sp + geom_point(alpha=.01)


Another solution is to bin the points into rectangles and map the density of the points to the fill color of the rectangles with stat_bin2d()
sp + stat_bin2d()


sp + stat_bin2d(bin=50) +
  scale_fill_gradient(low='lightblue', high='red', limits=c(0,6000))


Another alternative is to bin the data into hexagons instead of rectangles, with stat_bin_hex() which comes from library hexbin
sp + stat_binhex() + 
  scale_fill_gradient(low='lightblue', high='red', limits=c(0,8000))


sp + stat_binhex() +
  scale_fill_gradient(low='lightblue', high='red', 
                      breaks=c(0, 250, 500, 1000, 2000, 4000, 6000),
                      limits=c(0,6000))


when you have discrete data one or both axes, you can randomly jitter the points with position_jitter()
sp1 = ggplot(ChickWeight, aes(x=Time, y=weight))

sp1 + geom_point()


sp1 + geom_point(position='jitter')


sp1 + geom_point(position=position_jitter(width=.5, height=0))


grouping…(I’m too sleepy now. I need to reread this page 88)
sp1 + geom_boxplot(aes(group=Time))


sp1 + geom_boxplot()


5.6 - Adding Fitted Regression Model Lines
You want to add lines from a fitted regression model to a scatter plot.

To add a linear regression line to a scatter plot, add stat_smooth() and tell it to use method=lm.
sp = ggplot(heightweight, aes(x=ageYear, y=heightIn))
sp + geom_point() + stat_smooth(method=lm)


Change the confidence interval with se
sp + geom_point() + stat_smooth(method=lm, level=0.99)


sp + geom_point() + stat_smooth(method=lm, se=FALSE)


Make other changes with color, linetype, and size
sp + geom_point(color="grey60") + stat_smooth(method=lm, se=FALSE, color='black')


The default line drawing method is loess
sp + geom_point(color='grey60') + stat_smooth()
## geom_smooth: method="auto" and size of largest group is <1000, so using loess. Use 'method = x' to change the smoothing method.


sp + geom_point(color='grey60') + stat_smooth(method=loess)


Fitting a logistic regression model.
#b = biopsy
#b$classn[b$class == 'benign'] = 0
#b$classn[b$class == 'malignant'] = 1
b = biopsy %>% mutate(classn = ifelse(class == "benign", 0, 1))
ggplot(b, aes(x=V1, y=classn)) +
  geom_point(position=position_jitter(width=0.3, height=0.06), alpha=0.4,
             shape=21, size=1.5) +
  stat_smooth(method=glm, family=binomial)


Adding multiple lines when points are grouped by a factor
sps = ggplot(heightweight, aes(x=ageYear, y=heightIn, color=sex)) +
  geom_point() +
  scale_color_brewer(palette='Set1')

sps + geom_smooth()
## geom_smooth: method="auto" and size of largest group is <1000, so using loess. Use 'method = x' to change the smoothing method.


sps + geom_smooth(method=lm, se=FALSE, fullrange=TRUE)


5.7 - Adding Fitted Lines from an Existing Model (THIS IS HEAVY)
You have already created a fitted regression model object for a data set, and you want to plot the lines for that model.

Create the model yourself with lm() and then add it to your graph.
model = lm(heightIn ~ ageYear + I(ageYear^2), heightweight)
xmin = min(heightweight$ageYear)
xmax = max(heightweight$ageYear)
predicted = data.frame(ageYear = seq(xmin, xmax, length.out=100))
predicted = mutate(predicted, heightIn = predict(model, predicted))

sp = ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point(color='grey40')

sp + geom_line(data=predicted, size=1)


Let’s define a function predictvals() that, when passed a model, will do the work of finding the variable names and range of the predictor, and will return a data frame with predictor and predicted values. The data frame can then be passedto geom_line to draw the fitted line.
predictvals = function(model, xvar, yvar, xrange=NULL, samples=100,...){
  if(is.null(xrange)){
    if(class(model) %in% c('lm','glm')){
      xrange= range(model$model[[xvar]])
    }
    else if(class(model) %in% c('loess')){
      xrange = range(model$x)
    }
  }
  newdata = data.frame(x = seq(xrange[1], xrange[2], length.out=samples))
  names(newdata) = xvar
  newdata[[yvar]] = predict(model, newdata=newdata, ...)
  newdata
}

modlinear = lm(heightIn ~ ageYear, heightweight)
modloess = loess(heightIn ~ ageYear, heightweight)

lm_predicted = predictvals(modlinear, 'ageYear', 'heightIn')
loess_predicted = predictvals(modloess, 'ageYear', 'heightIn')

sp + geom_line(data=lm_predicted, color='red', size=.8) + 
  geom_line(data=loess_predicted, color='blue', size=.8)


An example using the glm function required type=‘response’ to be pased to predictvals()
b = biopsy %>% mutate(classn = ifelse(class == "benign", 0, 1))

fitlogistic = glm(classn ~ V1, b, family=binomial)

glm_predicted = predictvals(fitlogistic, "V1", "classn", type="response")
## Warning in if (class(model) %in% c("lm", "glm")) {: the condition has
## length > 1 and only the first element will be used
ggplot(b, aes(x=V1, y=classn)) +
  geom_point(position=position_jitter(width=.3, height=.08), 
             alpha=.4, shape=21, size=1.5) +
  geom_line(data=glm_predicted, color='#1177FF', size=1)


5.8 - Adding Fitted Lines from Multiple Existing Models
You have already created a fitted regression model object for a data set, and you wnat to plot the lines for that model

use the predictvals() function along with dlply() and ldply()
create make_model() that when passed a dataframe, it simply returns an lm object. This will enable us to use dlply()4
make_model = function(data){
  lm(heightIn ~ ageYear, data)  
}

models = dlply(heightweight, 'sex', .fun=make_model)

models
## $f
## 
## Call:
## lm(formula = heightIn ~ ageYear, data = data)
## 
## Coefficients:
## (Intercept)      ageYear  
##      43.963        1.209  
## 
## 
## $m
## 
## Call:
## lm(formula = heightIn ~ ageYear, data = data)
## 
## Coefficients:
## (Intercept)      ageYear  
##      30.658        2.301  
## 
## 
## attr(,"split_type")
## [1] "data.frame"
## attr(,"split_labels")
##   sex
## 1   f
## 2   m
predvals = ldply(models, .fun=predictvals, xvar='ageYear', yvar='heightIn')

head(predvals)
##   sex  ageYear heightIn
## 1   f 11.58000 57.96250
## 2   f 11.63980 58.03478
## 3   f 11.69960 58.10707
## 4   f 11.75939 58.17936
## 5   f 11.81919 58.25165
## 6   f 11.87899 58.32394
tail(predvals)
##     sex  ageYear heightIn
## 195   m 16.88768 69.51539
## 196   m 16.94414 69.64531
## 197   m 17.00061 69.77523
## 198   m 17.05707 69.90515
## 199   m 17.11354 70.03507
## 200   m 17.17000 70.16499
ggplot(heightweight, aes(x=ageYear, y=heightIn, color=sex)) +
  geom_point() + geom_line(data=predvals)


To form prediction lines that have the same x range across all groups, we can simply pass in xrange
predvals = ldply(models, .fun=predictvals, xvar='ageYear', yvar='heightIn', xrange=range(heightweight$ageYear))

ggplot(heightweight, aes(x=ageYear, y=heightIn, color=sex)) + 
  geom_point() + geom_line(data=predvals)


5.9 - Adding Annotations with Model Coefficients
You want to add numerical information about a model to a plot.

To add simple text to a plot, simply add an annotation.
model = lm(heightIn ~ ageYear, heightweight)
pred = predictvals(model, 'ageYear', 'heightIn')

summary(model)
## 
## Call:
## lm(formula = heightIn ~ ageYear, data = heightweight)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -8.3517 -1.9006  0.1378  1.9071  8.3371 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  37.4356     1.8281   20.48   <2e-16 ***
## ageYear       1.7483     0.1329   13.15   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.989 on 234 degrees of freedom
## Multiple R-squared:  0.4249, Adjusted R-squared:  0.4225 
## F-statistic: 172.9 on 1 and 234 DF,  p-value: < 2.2e-16
sp = ggplot(heightweight, aes(x=ageYear, y=heightIn)) + 
  geom_point() +
  geom_line(data=pred)

sp + annotate("text", label="r^2=0.42", x=16.5, y=52)


It’s also possible to enter formulas using R’s math expression syntax, by setting parse=TRUE
sp + annotate('text', label='r^2 == 0.42', parse=TRUE, x=16.5, y=52)


5.10 - Adding Marginal Rugs to a Scatter Plot
You want to add marginal rugs to a scatter plot

use geom_rug()
ggplot(faithful, aes(x=eruptions, y=waiting)) + geom_point() + geom_rug()


jitter the rugs to make the rug a little more visible
ggplot(faithful, aes(x=eruptions, y=waiting)) + geom_point() +
  geom_rug(position='jitter', size=.2)


5.11 - Labeling Points in a Scatter Plot
You want to add labels to points in a scatter plot.

to annotate one or a few points, use annotate() or geom_text().
sp = ggplot(filter(countries, Year==2009, healthexp > 2000), 
            aes(x=healthexp, y=infmortality)) + 
  geom_point()

sp + annotate('text', x=4350, y=5.4, label='Canada') +
  annotate('text', x=7400, y=6.8, label='USA')


To automatically add the labels from your data, use geom_text() and map a column that is a factor or character vector to the label aesthetic
sp + geom_text(aes(label=Name), size=4)


Using vjust to vertically adjust the text
sp + geom_text(aes(label=Name), size=4, vjust=0)


sp + geom_text(aes(y=infmortality+.1, label=Name), size=4, vjust=0)


Usng hjust to left or right justify the text
sp + geom_text(aes(label=Name), size=4, hjust=0)


sp + geom_text(aes(x=healthexp+100, label=Name), size=4, hjust=0)


If you want to label just some of the points but want the replacement to be handled automatically, you can add a new column to your data frame containing just the labels you want.
cdat = countries %>%
  filter(Year == 2009, healthexp > 2000) %>%
  mutate(Name1 = Name)

idx = cdat$Name1 %in% c('Canada', 'Ireland', 'United Kingdom', 'United States',
                        'New Zealand', 'Iceland', 'Japan', 'Luxembourg', 
                        'Netherlands', 'Switzerland')
#cdat$Name1[!idx] = NA
cdat = mutate(cdat, Name1 = ifelse(!idx, NA, Name1))

ggplot(cdat, aes(x=healthexp, y=infmortality)) +
  geom_point() +
  geom_text(aes(x=healthexp+100, label=Name1), size=4, hjust=0) +
  xlim(2000, 10000)
## Warning: Removed 17 rows containing missing values (geom_text).


5.12 - Creating a Balloon Plot
You want to make a balloon plot, where the area of the dots is proportional to their numerical value.

use geom_point() with the scale_size_area()
cdat = countries %>% 
  filter(Year == 2009, Name %in% c('Canada', 'Ireland', 'United Kingdom',
                      'United States', 'New Zealand', 'Iceland', 'Japan',
                      'Luxembourg', 'Netherlands', 'Switzerland'))

p = ggplot(cdat, aes(x=healthexp, y=infmortality, size=GDP)) +
  geom_point(shape=21, color='black', fill='cornsilk')

p


p + scale_size_area(max_size=15)


use baloon plots to represent values on a grid, where the x- and y-axes are categorical
hec = HairEyeColor[,,"Male"] + HairEyeColor[,,"Female"]

library(reshape2)
hec = melt(hec, value.name='count')

ggplot(hec, aes(x=Eye, y=Hair)) +
  geom_point(aes(size=count), shape=21, colour='black', fill='cornsilk') +
  scale_size_area(max_size=20, guide=FALSE) +
  geom_text(aes(y=as.numeric(Hair)-sqrt(count)/22, label=count), vjust=1, 
            color='grey60', size=4)


5.13 Making a Scatter Plot Matrix
You want to make a scatter plot matrix.

use the pairs() function from R’s base graphics.
c2009 = countries %>% filter(Year==2009) %>%
  select(Name, GDP, laborrate, healthexp, infmortality)

pairs(c2009[,2:5])


To show the correlation coefficient of each pair of variables instead ofa scatter plot, we’ll define the function panel.cor. This will also show higher correlations in a larger font.
panel.cor = function(x, y, digits=2, prefix="", cex.cor, ...){
  usr = par("usr")
  on.exit(par(usr))
  par(usr = c(0,1,0,1))
  r = abs(cor(x,y,use='complete.obs'))
  txt=format(c(r,0.123456789),digits=digits)[1]
  txt=paste(prefix,txt,sep='')
  if(missing(cex.cor)) cex.cor = 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor*(1+r)/2)
}
To show histograms of each variable along the diagonal, we’ll define panel.hist
panel.hist = function(x, ...){
  usr = par('usr')
  on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5))
  h = hist(x, plot=FALSE)
  breaks = h$breaks
  nB = length(breaks)
  y=h$counts
  y=y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col='white',...)
}
… and now the plot
pairs(c2009[,2:5], upper.panel = panel.cor,
      diag.panel = panel.hist,
      lower.panel = panel.smooth)


It may be more desirable to use linear regression lines instead of LOWESS lines
panel.lm = function(x, y, col=par('col'), bg = NA, pch=par('pch'),
                    cex=1, col.smooth='black', ...){
  points(x,y,pch=pch, col=col, bg=bg, cex=cex)
  abline(stats::lm(y~x), col=col.smooth,...)
}

pairs(c2009[,2:5], pch=".", upper.panel = panel.cor,
      diag.panel = panel.hist, lower.panel = panel.lm)
