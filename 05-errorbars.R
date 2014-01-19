# Use every nth points for error bar
# http://www.ansci.wisc.edu/morota/R/ggplot2/ggplot2.html

df <- data.frame(time=rep(1:100, 2),S=sin(rep(1:100, 2)*pi/50) + rnorm(200, 0, 0.1),Sex=gl(2,100),Err=rnorm(200,0,0.2))

head(df)
  time       S Sex       Err
1    1 0.10585   1  0.142666
2    2 0.18760   1 -0.027771
3    3 0.12801   1 -0.102478
4    4 0.36286   1  0.041794
5    5 0.32320   1 -0.035994
6    6 0.35872   1  0.118740

ggplot(df,aes(time,S,color=Sex)) + geom_point() + geom_errorbar(aes(x=time,ymin=S-Err,ymax=S+Err))
dev.new()
ggplot(df,aes(time,S,color=Sex)) + geom_point() + geom_errorbar(aes(x=time,ymin=S-Err,ymax=S+Err), data=df[seq(1,nrow(df), 10),])

