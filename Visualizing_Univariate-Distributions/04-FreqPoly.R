
qplot(clarity, data=diamonds, geom="freqpoly", group=cut, colour=cut, position="identity") 

qplot(clarity, data=diamonds, geom="freqpoly", group=cut, colour=cut, position="stack")
