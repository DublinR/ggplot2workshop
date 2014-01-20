# http://stackoverflow.com/questions/14415674/reordering-groups-in-likert-plots-with-r
# additional requirements

library(ggplot2)
library(reshape2)
library(RColorBrewer)

# create summary table
table_summary = likert(items)

# reshape results
results = melt(table_summary$results, id.vars='Item')

# reorder results
results$Item = factor(results$Item, levels=c("LT", "ST", "SemTag", "SemTagContext"))

# some defaults
ymin = 0
text.size = 3

##############################################################

ggplot(results, aes(y=value, x=Item, group=Item)) + 
  geom_bar(stat='identity', aes(fill=variable)) + 
  ylim(c(-5,105)) + 
  coord_flip() +
  scale_fill_manual('Response', values=brewer.pal(7, "RdYlGn"), 
              breaks=levels(results$variable), 
              labels=levels(results$variable)) +
  geom_text(data=table_summary$summary, y=ymin, aes(x=Item, 
              label=paste(round(low), '%', sep='')), 
              size=text.size, hjust=1) +
  geom_text(data=table_summary$summary, y=100, aes(x=Item,
              label=paste(round(high), '%', sep='')), 
              size=text.size, hjust=-.2) +
  ylab('Percentage') + xlab('')
