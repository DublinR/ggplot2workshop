p <- ggplot(diamonds, aes(carat, price, fill = )) +
  stat_density2d(aes(fill = ..density..), contour = F, geom = "tile") + 
  scale_x_log2()+
  scale_y_log10()

p + scale_fill_gradient(high = "black", low = "white")
