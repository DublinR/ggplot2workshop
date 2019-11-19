model <- loess(wt ~ hp, data=mtcars)
xrange <- range(mtcars$hp)
xseq <- seq(from=xrange[1], to=xrange[2], length=80)
pred <- predict(model, newdata = data.frame(hp = xseq), se=TRUE)
y = pred$fit
ci <- pred$se.fit * qt(0.95 / 2 + .5, pred$df)
ymin = y - ci
ymax = y + ci
loess.DF <- data.frame(x = xseq, y, ymin, ymax, se = pred$se.fit)

ggplot(mtcars, aes(x=hp, y=wt)) +
  geom_point() +
  geom_smooth(aes_auto(loess.DF), data=loess.DF, stat="identity")
