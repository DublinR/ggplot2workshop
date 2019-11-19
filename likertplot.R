require(ggplot2)
 
## generate fake likert data
set.seed(200)
response_scale <- c("Strongly Disagree",
                    "Disagree",
                    "Neither Agree or Disagree",
                    "Agree", 
                    "Strongly Agree")
x <- replicate(5, ordered(sample(response_scale, 20, replace = TRUE),
                          levels = response_scale), simplify = F)
x <- as.data.frame(x)
names(x) <- paste0("Q", 1:5)
 
## plot it as net stacked distribution
net_stacked(x)
