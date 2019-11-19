R Graphics Cookbook - Chapter 2: Quickly Exploring Data
2.1 Creating a Scatter plot
2.2 Creating a Line Graph
2.3 Creating a Bar Graph
2.4 Creating a Histogram
2.5 Creating a Box Plot
2.6 Plotting a Function Curve
2.1 Creating a Scatter plot
You want to create a scatter plot.

plot(mtcars$wt, mtcars$mpg)


library(ggplot2)
qplot(mtcars$wt, mtcars$mpg)


qplot(wt, mpg, data=mtcars)


ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()


2.2 Creating a Line Graph
You want to create a line graph

plot(pressure$temperature, pressure$pressure, type='l')


To add points and/or multiple lines, first call plot() for the first line, then add points with points() and additional lines with lines()

plot(pressure$temperature, pressure$pressure, type='l')
points(pressure$temperature, pressure$pressure)
lines(pressure$temperature, pressure$pressure/2, col='red')
points(pressure$temperature, pressure$pressure/2, col='red')


library(ggplot2)
qplot(pressure$temperature, pressure$pressure, geom='line')


qplot(temperature, pressure, data=pressure, geom='line')


ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line()


Lines and points together

qplot(temperature, pressure, data=pressure, geom=c("line", "point"))


ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line() + geom_point()


2.3 Creating a Bar Graph
You want to make a bar graph

barplot(BOD$demand, names.arg=BOD$Time)


To generate the count of each unique value in a vector, use the table() function

barplot(table(mtcars$cyl))


library(ggplot2)
qplot(BOD$Time, BOD$demand, geom='bar', stat='identity')


Convert the x variable to a factor, so that it is treated as discrete

qplot(factor(BOD$Time), BOD$demand, geom='bar', stat='identity')


qplot(mtcars$cyl)
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.


qplot(factor(mtcars$cyl))


qplot(Time, demand, data=BOD, geom='bar', stat='identity')


ggplot(BOD, aes(x=Time, y=demand)) + geom_bar(stat='identity')


qplot(factor(cyl), data=mtcars)


ggplot(mtcars, aes(x=factor(cyl))) + geom_bar()


2.4 Creating a Histogram
You want to view the distribution of one-dimensional data with a histogram

hist(mtcars$mpg)


hist(mtcars$mpg, breaks=10)


qplot(mtcars$mpg)
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.


qplot(mpg, data=mtcars, binwidth=4)


ggplot(mtcars, aes(x=mpg)) + geom_histogram(binwidth=4)


2.5 Creating a Box Plot
You want to create a box plot for comparing distributions.

To make a boxplot, use plot() and pass it a factor of x values and a vector of y values. When x is a factor, it will automatically create a box plot

plot(ToothGrowth$supp, ToothGrowth$len)
boxplot(len ~ supp, data = ToothGrowth)


boxplot(len ~ supp + dose, data = ToothGrowth)


library(ggplot2)
qplot(ToothGrowth$supp, ToothGrowth$len, geom='boxplot')


qplot(supp, len, data=ToothGrowth, geom='boxplot')


ggplot(ToothGrowth, aes(x=supp, y=len)) + geom_boxplot()


Using three separate vectors

qplot(interaction(ToothGrowth$supp, ToothGrowth$dose), ToothGrowth$len, geom='boxplot')


qplot(interaction(supp, dose), len, data=ToothGrowth, geom='boxplot')


ggplot(ToothGrowth, aes(x=interaction(supp, dose), y=len)) + geom_boxplot()


2.6 Plotting a Function Curve
curve(x^3 - 5*x, from=-4, to=4)


myfun = function(xvar){
  1/(1 + exp(-xvar+10))  
}
curve(myfun(x), from=0, to=20)
curve(1-myfun(x), add=T, col='red')


library(ggplot2)
qplot(c(0,20), fun=myfun, stat='function', geom='line')


ggplot(data.frame(x=c(0,20)), aes(x=x)) + stat_function(fun=myfun, geom='line')
