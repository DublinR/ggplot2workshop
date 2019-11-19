names <- colnames(df[17:length(df)])

counter = 17L

for (i in 1:length(names)) {
  df.tax <- subset(df, df[,c(counter)] != 0)
  counter = counter + 1L
  meta <- subset(df.tax, select=c(1:16))
  meltmeta <- melt(meta, id=c("Collector", "Year","Week","Cities","Provinces"))
  ppv <- ggplot(meltmeta, aes(title = paste(names[i]), factor(Provinces), value))
  ppv + geom_boxplot() + geom_boxplot(aes(fill=Collector), alpha=I(0.5)) + geom_point(aes(color=Collector), size=1) +facet_wrap(~variable, scale="free")
  ggsave(file = paste(names[i], sep=".","provinces_vs_climate.pdf"), width=16, height=8)
}
###########################################################
for (i in 1:length(names)) {
  df.tax <- subset(df, df[,c(counter)] != 0)
  counter = counter + 1L
  meta <- subset(df.tax, select=c(1:16))
  meltmeta <- melt(meta, id=c("Collector", "Year","Week","Cities","Provinces"))
  ppv <- ggplot(meltmeta, aes(factor(Provinces), value))
  ppv <- ppv + geom_boxplot() 
  ppv <- ppv + geom_boxplot(aes(fill=Collector), alpha=I(0.5)) 
  ppv <- ppv + geom_point(aes(color=Collector), size=1) 
  ppv <- ppv + facet_wrap(~variable, scale="free")
  ppv <- ppv + ggtitle(paste(names[i]))
  ggsave(file = paste(names[i], sep=".","provinces_vs_climate.pdf"), width=16, height=8)
}
