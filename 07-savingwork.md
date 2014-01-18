saving graphs to file is a snap with ggsave()
ggplot2 comes with a great function called ggsave() that takes all the headache out of exporting graphics from R. The only required parameter is a filename, like so. 
ggsave("LIBMFacetsWithTrend.jpg")

BY DEFAULT, it detects the desired format based on the file extension you give it and handles everything silently and efficiently.  Again...If you have done a lot of graphing in R previously then your mouth is right now hanging open in astonishment. The default behavior is to save the last ggplot object that you plotted to the graphic device, but of course you can pass it the name of any saved ggplot object.  You can also of course change things like output dimensions and DPI, etc.  
Just have a look at ?ggsave
