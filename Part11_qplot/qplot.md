qplot
========================================================

### 1. Preliminaries
- Install package
- Inspect **mtcars** data set

```r
library(ggplot2)
# continuous scale vs. discrete scale
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

```r
names(mtcars)
```

```
##  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
## [11] "carb"
```

```r
table(mtcars$cyl)
```

```
## 
##  4  6  8 
## 11  7 14
```

```r
levels(mtcars$cyl)
```

```
## NULL
```



```r
qplot(wt, mpg, data = mtcars, colour = cyl)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 



```r
# Specifying cyl as a factor
qplot(wt, mpg, data = mtcars, colour = factor(cyl))
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 

### Use Different "aesthetic"" mappings size and shape


```r
qplot(wt, mpg, data = mtcars, shape = factor(cyl))
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-41.png) 

```r
qplot(wt, mpg, data = mtcars, size = qsec)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-42.png) 


### Combine mappings

```r

# (hint: hollow points, geom-concept, legend combination)
qplot(wt, mpg, data = mtcars, size = qsec, color = factor(carb))
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-51.png) 

```r
qplot(wt, mpg, data = mtcars, size = qsec, color = factor(carb), shape = I(1))
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-52.png) 


### Scatterplot


```r
qplot(wt, mpg, data = mtcars, size = qsec, shape = factor(cyl), geom = "point")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-61.png) 

```r
qplot(wt, mpg, data = mtcars, size = factor(cyl), geom = "point")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-62.png) 




```r
# bar-plot
qplot(factor(cyl), data = mtcars, geom = "bar")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-71.png) 

```r
# flip plot by 90°
qplot(factor(cyl), data = mtcars, geom = "bar") + coord_flip()
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-72.png) 




```r
# difference between fill/color bars
qplot(factor(cyl), data = mtcars, geom = "bar", fill = factor(cyl))
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-81.png) 

```r
qplot(factor(cyl), data = mtcars, geom = "bar", colour = factor(cyl))
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-82.png) 




```r

# fill by variable
qplot(factor(cyl), data = mtcars, geom = "bar", fill = factor(gear))
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 

```r
# use different display of bars (stacked, dodged, identity)
head(diamonds)
```

```
##   carat       cut color clarity depth table price    x    y    z
## 1  0.23     Ideal     E     SI2  61.5    55   326 3.95 3.98 2.43
## 2  0.21   Premium     E     SI1  59.8    61   326 3.89 3.84 2.31
## 3  0.23      Good     E     VS1  56.9    65   327 4.05 4.07 2.31
## 4  0.29   Premium     I     VS2  62.4    58   334 4.20 4.23 2.63
## 5  0.31      Good     J     SI2  63.3    58   335 4.34 4.35 2.75
## 6  0.24 Very Good     J    VVS2  62.8    57   336 3.94 3.96 2.48
```




```r
qplot(clarity, data = diamonds, geom = "bar", fill = cut, position = "stack")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-101.png) 

```r
qplot(clarity, data = diamonds, geom = "bar", fill = cut, position = "dodge")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-102.png) 

```r
qplot(clarity, data = diamonds, geom = "bar", fill = cut, position = "fill")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-103.png) 

```r
qplot(clarity, data = diamonds, geom = "bar", fill = cut, position = "identity")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-104.png) 




```r
qplot(clarity, data = diamonds, geom = "freqpoly", group = cut, colour = cut, 
    position = "identity")
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 




```r
qplot(clarity, data = diamonds, geom = "freqpoly", group = cut, colour = cut, 
    position = "stack")
```

```
## ymax not defined: adjusting position using y instead
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 




```r
# histogram
qplot(carat, data = diamonds, geom = "histogram")
```

```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13.png) 




```r
# change binwidth
qplot(carat, data = diamonds, geom = "histogram", binwidth = 0.1)
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-141.png) 

```r
qplot(carat, data = diamonds, geom = "histogram", binwidth = 0.01)
```

```
## Warning: position_stack requires constant width: output may be incorrect
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-142.png) 




```r
# use geom to combine plots (hint: order of layers)
qplot(wt, mpg, data = mtcars, geom = c("point", "smooth"))
```

```
## geom_smooth: method="auto" and size of largest group is <1000, so using loess. Use 'method = x' to change the smoothing method.
```

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-151.png) 

```r
qplot(wt, mpg, data = mtcars, geom = c("smooth", "point"))
```

```
## geom_smooth: method="auto" and size of largest group is <1000, so using loess. Use 'method = x' to change the smoothing method.
```

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-152.png) 

```r
qplot(wt, mpg, data = mtcars, color = factor(cyl), geom = c("point", "smooth"))
```

```
## geom_smooth: method="auto" and size of largest group is <1000, so using loess. Use 'method = x' to change the smoothing method.
```

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-153.png) 



