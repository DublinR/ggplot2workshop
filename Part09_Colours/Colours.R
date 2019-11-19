# Different Colours for Positive and Negative Values

## Generate random values
set.seed(1234)
x <- c(1:20)
y <- rnorm(20) * 10
df <- data.frame(x = x, y = y, pos = (y >= 0))

## Using 'pos' in data frame to fill
plot1 <- ggplot(df, aes(x = x, y = y, fill = pos)) + geom_bar(stat = "identity", 
    position = "identity") + scale_fill_manual(values = c("red", "steelblue"))

plot2 <- ggplot(df, aes(x = x, y = y, fill = pos)) + geom_bar(stat = "identity", 
    position = "identity", colour = "black", size = 0.25) + scale_fill_manual(values = c("red", 
    "steelblue"), guide = FALSE)
