What is ggplot2
===========================

- ggplot2 is a data visualization package for the statistical programming language R. 
- Created by Hadley Wickham in 2005, ggplot2 is an implementation of Leland Wilkinson's Grammar of Graphics, a general 
 scheme for data visualization which breaks up graphs into semantic components such as scales and layers. 
- ggplot2 can serve as a replacement for the base graphics in R and contains a number of defaults for web and print 
display of common scales. 
- Since 2005, ggplot2 has grown in use to become one of the most popular R packages.
- It is licensed under GNU GPL v2.

### Installing ggplot2

- Available on CRAN
- `install.packages("ggplot2")'

<hr>
ggplot2 is meant to be an implementation of the ***Grammar of Graphics***, hence gg-plot. The basic notion is that there is a grammar to the composition of graphical components in statistical graphics, and by direcly controlling that grammar, you can generate a large set of carefully constructed graphics tailored to your particular needs. Each component is added to the plot as a layer.

Plots convey information through various aspects of their aesthetics. Some aesthetics that plots use are:
- x position
- y position
- size of elements
- shape of elements
- color of elements

The elements in a plot are geometric shapes, like
- points
- lines
- line segments
- bars
- text

Some of these geometries have their own particular aesthetics. For instance:
- points
 - point shape
 - point size
- lines
 - line type
 - line weight
- bars
 - y minimum
 - y maximum
 - fill color
 - outline color
- text
 - label value

There are other basics of these graphics that you can adjust, like the scaling of the aesthetics, and the positions of the geometries.
