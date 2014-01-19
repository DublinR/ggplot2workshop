The ggplot() Command
=====================
- The command `ggplot()` initializes a ggplot object. It can be used to declare the input data frame for a graphic.
- It can also be used to specify the set of plot aesthetics intended to be common throughout all subsequent layers (unless specifically overridden).
- Important: The actual plots are built with subsequent commands.
- `ggplot()` is typically used to construct a plot incrementally, using the `+` operator to add layers to the existing ggplot object.
- This is advantageous in that the code is explicit about which layers are added and the order in which they are added.
- We can define common aesthetics using the `aes` argument for this command.
