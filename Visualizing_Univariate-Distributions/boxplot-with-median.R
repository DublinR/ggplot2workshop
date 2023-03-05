# display the value of median for each group
# this requires to get the aggregate data
# we used the function summaryBy in the package called "doBy"
# adding text by adding a layer with gemo = "text"

library(doBy)
a<-summaryBy(write ~ female + ses , hsb2, FUN=c(median)) 

qplot(female, write, data = hsb2, 
  geom="boxplot") + xlab("") +  layer(data = a, mapping = 
  aes(x = female, y= write.median+1, label=round(a$write.median)), 
  geom = "text", color="NavyBlue", size=3.5) +facet_grid(.~ses, 
  scales="free", space="free") + theme_bw()+ opts(strip.text.y = theme_text()) 
 
