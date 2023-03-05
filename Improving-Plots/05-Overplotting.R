# Setting up the Data

set.seed(1234)
DFnorm<- data.frame(x=rnorm(3000), y=rnorm(32000))

####################################################

p.norm <- ggplot(DFnorm, aes(x,y))

p.norm + geom_point()

####################################################

# Hollow Glyphs / Narrow Glyphs

p.norm + geom_point(shape = 1)

p.norm + geom_point(shape = ".")

####################################################

# Transparency (alpha blending)

p. norm + geom_point(alpha=(0.25),colour="blue")
