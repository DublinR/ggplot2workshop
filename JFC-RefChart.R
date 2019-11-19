# Author: Jo-Fai Chow
# http://rstudio-pubs-static.s3.amazonaws.com/5312_44107e3ddfa84c5faec35dc48d5749d6.html

## Stack & Dodge
plot1 <- ggplot(samsungData, aes(x = as.factor(subject), fill = activity)) + 
    geom_bar(colour = "black", position = "stack")
plot2 <- ggplot(samsungData[which(samsungData$subject %in% c("1", "3", "5")), 
    ], aes(x = as.factor(subject), fill = activity)) + geom_bar(colour = "black", 
    position = "dodge")
#####################################################

## Using qualitative palettes (change the parameter: palette = ???)
plot1 <- ggplot(samsungData, aes(x = as.factor(subject), fill = activity)) + 
    geom_bar(colour = "black", position = "stack") + scale_fill_brewer(palette = "Accent") + 
    labs(title = "Accent")
    
#####################################################

## Using sequential palettes (change the parameter: palette = ???)
plot1 <- ggplot(samsungData, aes(x = as.factor(subject), fill = activity)) + 
    geom_bar(colour = "black", position = "stack") + scale_fill_brewer(palette = "Blues") + 
    labs(title = "Blues")
    
#####################################################

# Graph with manual colours
ggplot(samsungData, aes(x = as.factor(subject), fill = activity)) + geom_bar(colour = "black", 
    position = "stack") + scale_fill_manual(values = c("darkblue", "blue", "darkred", 
    "red", "orange", "purple")) + labs(title = "Manaul")

#####################################################    
