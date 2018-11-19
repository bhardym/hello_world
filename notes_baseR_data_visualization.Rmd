---
title: "baseR_data_visualization"
author: "bhardym"
date: "November 17, 2018"
output: html_document
---

##Notes on Base R Data visualization:

###2 types of graphical data displays:
1)*Exploratory visualization* (to understand data)

* help you see what is in your data
* level of detail: keep as much detail as possible (don't lose info)
* practical limit: how much can you see and interpret
* example of an exploratory plot:

    ```{r}
    #exploratory plot to the data frame Chickweight from R package
    plot(ChickWeight)
    ```

2)*Explanatory visualization* (share our understanding with others)

* Showing others what you've found
* Requires editorial decisions:What features to highlight & features to eliminate

editorial decisions: 

1. Variables to be plotted
2. Axis labels: specified as strings to the `xlab` and `ylab`arguments to the `plot()` funtion

```{r}
library(MASS)
# Plot Gas vs. Temp in the Whiteside dataframe
 plot(UScereal$sugar, UScereal$calories)
  title(xlab = "sugar content",ylab =  "calorie content")
```


##Four Graphic systems in R

1. *Base graphics*: Easiest to learn
2. *Grid graphics*: Powerful (and flexibility, but more complicated) set of modules for building other tools
3. *Lattice graphics*: general prupose system based on grid graphics, good for conditional scatterplots.
4. *ggplot2*: "the grammar of graphics"

##Using the plot function:

The `plot()` funtion is **generic**, and the results will therefore differ depending on the nature of the object thta it is applied to. For example, if applied to a categorical variable, would produce a barplot instead of scatterplots.

###Scatterplot example: 
Relation between 2 numerical datasets.
```{r}
library(MASS)
#Dataset of house prices in Boston in 1978, rm = average number of rooms, medv  = median house price
plot(Boston$rm, Boston$medv, main = "Sactterplot")
```

###Sunflowerplots example:
Useful when numerical data points are repeated(1 petal of flower for each repeated datapoint).

```{r}
library(MASS)
#Boston dataset
sunflowerplot(Boston$rad, Boston$tax, main = "Sunflowerplot")
```

###Boxplot example:

```{r}
library(MASS)
boxplot(crim ~ rad, data = Boston, log = "y", las = 1, main = "Boxplot", xlab = "rad", ylab = "crim")
```
The code `crim ~ rad` indicated that we are interested in how the crime rate `crim` varies accross the variable `rad`. 

###Mosaicplots example:
show relation between 2 categorical variables ( or numerical variables with only a few values)
```{r}
library(datasets)
mosaicplot(cyl ~ gear, data = mtcars, main = "Mosaicplot")
```

##Base R can be enhanced:

* Using deffrent point shapes for different data subsets
* Adding features to the plot:
 * `points()` adds new set of points, 
 * `lines()`  adds lines, usuallt curved
 * `abline(), adds a reference line
 * `text()` adds labels
* Using different colours
* `par()` functions allows to set many graphic parameters GLOBALLY so they apply to all subsequent plots. 
 * for example, `mfrow` sets up row arrays
 
 * `pch` argument to change point shape in `plot()` function
 * `col`argument to change color in `plot()` function
 
```{r}
# For dataset Cars93:

# Plot Max.Price vs. Price as red triangles. Pch = 17 indicates we want solid triangles. Colour needs to be specified as a string.
plot(Cars93$Price, Cars93$Max.Price, pch = 17, col = "red")

# Add Min.Price vs. Price as blue circles. points() will add a set of datapoints to the graph
points(Cars93$Price, Cars93$Min.Price, pch = 16, col = "blue")

# Add an equality reference line with abline(). Adding a dashed equality reference line. Tjis is saying that 'a'  =  intercep at y=0, and b = the slope
abline(a = 0, b = 1, lty = 2)
```
 
###Create multiple plot arrays:

For example, `par(mfrow = c(1, 2))` creates a plot array with 1 row and 2 columns, so you can see 2 graphs side by side.
 
```{r}
#install.packages("robustbase")
library(robustbase)

# Set up the side-by-side plot array to be able to compare to visual representations (1 row, 2 columns)
par(mfrow = c(1, 2))

# First plot: brain vs. body in its original form
plot(Animals2$body, Animals2$brain)
# Add the first title
title("Original representation")

# Second plot: log-log plot of brain vs. body
plot(Animals2$body, Animals2$brain, log = "xy")
# Add the second title
title("Log-log plot")
```
 
###Example to Pie charts:
use `pie()`, but their use is discouraged. Bar charts is the recommended alternative.

*Comparison between pie cart and bar chart*:

```{r}
library(MASS)
# Set up a side-by-side plot array
par(mfrow = c(1, 2))

# Create a table of calories record counts and sort (not the best dataset for these charts, would usually work better with 1 categorical data and 1 numerical value)
tbl <- sort(table(UScereal$calories),
            decreasing = TRUE)

# Create the pie chart
pie(tbl)
title("Pie chart")

# Create the barplot with perpendicular, half-sized labels, las = 2 make the axis titles perpendicular, and cex.names = reduces the value names by hald their default size.
barplot(tbl, las = 2, cex.names = 0.5)
title("Bar chart")
```
 
##Characterizing a single variable
tools to characterize a variable (e.g. see if the repartition is normal or not): Simulated Gaussian data values, Histogram, Density estimate, Normal QQ-plot (very useful to determine is data are normalized).

###The hist() and truehist() functions:
Histogram: look at how the values of a numerical variable are distributed

`hist()` default option yieldshistogram based on the number of times a record falls into each of the bins on which the histogram is based

`truehist`is from the MASS package and scales these counts to give an estimate of the probability density

To see the difference between `hist()` and `truehist()`:

```{r}
# Set up a side-by-side plot array
par(mfrow = c(1, 2))

# Create a histogram of counts with hist() for the variable Horsepower in the dataset Cars93.
hist(Cars93$Horsepower, main = "hist() plot")

# Create a normalized histogram with truehist()
truehist(Cars93$Horsepower, main = "truehist() plot")
```

###Density plots (smoothed histograms):
Example of a density plot for chick weight: For this example, I select for the chicks that are 16 weeks old. Then create a histogram using the `truehist()` function, and *add its density plot on top*, using the `lines()` and `density()` functions with their default options.

```{r}
# Create index16, pointing to 16-week chicks
index16 <- which(ChickWeight$Time == 16)

# Get the 16-week chick weights
weights <- ChickWeight$weight[index16]

# Plot the normalized histogram
truehist(weights)

# Add the density curve to the histogram
lines(density(weights))

```


###QQ-plot(quantile-quantile) with the qqPlot() function in the `car` package:
QQ-plots sort our data, plot it against a specially-designed x-axis based on our reference distribution (e.g., the Gaussian "bell curve"), and look to see whether the points lie approximately on a straight line.

```{r}
# Load the car package to make qqPlot() available
#install.packages("car")
library(car)

# Create index16, pointing to 16-week chicks
index16 <- which(ChickWeight$Time == 16)

# Get the 16-week chick weights
weights <- ChickWeight$weight[index16]

# Show the normal QQ-plot of the chick weights
qqPlot(weights)

```

##Visualizing relations between 2 variables

###Scatterplot (or sunflowerplot())

Showing how medv(y) varies in relation to rm(x)
data argument is the dataframe
*formula interface* format of `medv ~ rm`
```{r}
library(MASS)
plot(medv ~ rm, data = Boston)
```

###Boxplot example:

the `las = 1` argument means that the titles are horizontal, `xlab` argument is for the name of x axis

```{r}
library(MASS)
boxplot(crim ~ rad, data = Boston, log = "y", las = 1, xlab = "rad")
title("Variation of Boston$crim values over discrete Boston$rad values")
```

*Usefeul options for boxplot*:
`varwidth`: allows for variable-width boxplots that show the different sizes of the data subsets. The format is `varwidth = TRUE` 
`log = "y"`:allows for log-transformed y-values.
`las = 1`:allows for more readable axis labels.


###Mosaic plot example:
`main` argument for title

```{r}
mosaicplot(cyl ~ gear, data = mtcars, main = "Mosaicplot")
```

##Complex relationships between more than 2 variables:

* Bagplots (like a 2 dimensional boxplot)
The bag plot extends this representation to two numerical variables, showing their relationship, both within two-dimensional "bags" corresponding to the "box" in the standard boxplot, and indicating outlying points outside these limits.

```{r}
# Load aplpack to make the bagplot() function available
#install.packages("aplpack")
library(aplpack)

# Create a bagplot for two variables
bagplot(Cars93$Min.Price, Cars93$Max.Price, cex = 1.2)

# Add an equality reference line
abline(a = 0, b = 1, lty = 2)

```


* Correlation coefficient: between 2 numerical values, number between -1 and +1.. See the `corrplot()` function.


```{r}
#install.packages("corrplot")
mtCor <- cor(mtcars)
library(corrplot)
corrplot(mtCor, method = "ellipse")
```
*give a useful prelimenary view*

* Decision tree to predict gas milage 

```{r}
library(rpart)
treeModel <- rpart(mpg ~ ., data = mtcars)
plot(treeModel)
text(treeModel, cex = 1.6, col = "red", xpd = TRUE)
```

##The plot() function and its options
Can be called locally (in the plot) or globally (like in the `par` function `mfrow`, `cex` `pch`).
First, High level function `plot()`, then low level functions like `lines()`, `legend()`, or `title()`.

###options of the par() function
Showing all the arguments that are set in par():

```{r}
# Assign the return value from the par() function to plot_pars
plot_pars <- par()

# Display the names of the par() function's list elements
names(plot_pars)
```

`type` parameter for the `plot()` funtion: specifies how the plot is drawn(`"p"` fro points, `"l"` for lines, `"o"` for lines overlaid with points, and `"s"` for steps)

`type = "n"` is useful when we are plotting data from multiple sources on a common set of axes. In such cases, we can compute ranges for the x- and y-axes so that all data points will appear on the plot, and then add the data with subsequent calls to `points()` or `lines()` as appropriate.
for example:

```{r}
# Compute max_hp
max_hp <- max(Cars93$Horsepower, mtcars$hp)

# Compute max_mpg
max_mpg <- max(Cars93$MPG.city, Cars93$MPG.highway, mtcars$mpg)

# Create plot with type = "n"               
plot(max_hp, max_mpg,
     type = "n", xlim = c(0, max_hp),
     ylim = c(0, max_mpg), xlab = "Horsepower",
     ylab = "Miles per gallon")

# Add open circles to plot
points(mtcars$hp, mtcars$mpg, pch = 1)

# Add solid squares to plot
points(Cars93$Horsepower, Cars93$MPG.city, pch = 15)

# Add open triangles to plot
points(Cars93$Horsepower, Cars93$MPG.highway, pch = 2)

```

###Adding points and lines to plots:

Using the `points()` functions to highlight outliers:

```{r}
library(MASS)
plot(UScereal$fibre)
index <- which(UScereal$fibre > 20)
points(index, UScereal$fibre[index], pch = 16, col = "red")
title("Using the points() function to highlight outliers")
```

Using the `line()` function to add lines to a plot, like a density line in a histogram:

```{r}
library(MASS)
truehist(geyser$duration)
lines(density(geyser$duration), lwd = 2, col = "blue")
title("Old Faithful geyser duration data: \n Histogram with overlaid Density Plot")
```

`lty` argument defines line types. 1 = solid line, 2 = dashed line, 3 = dotted line
`lwd` argument defines width of line

`lm()` to return a linear model object, which can be passed as an argument to the `abline()` function to draw  the desired line on our plot.
see example:

```{r}
# Build a linear regression model for the whiteside data
linear_model <- lm(Gas ~ Temp, data = whiteside)

# Create a Gas vs. Temp scatterplot from the whiteside data
plot(whiteside$Temp, whiteside$Gas, data = whiteside)

# Use abline() to add the linear regression line
abline(linear_model, lty = 2)
```


###Adding text to plots

* Axis labels: `xlab = ""` and `ylab = ""`
* Titles: `title()` or argument `main = ""` (creating a 2 lines title by using the return character `\n`)
* Legends
* Text in plot itself

`text(x, y, labels, adj)` can add text to a plot.
`adj` argument determines the alignment of axis titles, default is 0.5 for centered text, but can be changed)

For * varying fonts, orientations, and other features* example:

```{r}
library(MASS)
plot(Boston$rad)
#creating text in red: first 2 numbers are the x-y position of the text, then text in "", srt argument specifies the angle (orientation of text), then font type (2 = bold), then font size (20% larger than default, then color)
text(350, 24, adj = 1, "Inner city? -->", srt = 30, font = 2, cex = 1.2, col = "red")
#font = 3 mean italic
text(100, 15, "Suburbs? -->", srt = -45, font = 3, col = "green")
title("Text with varying orientations, fonts and sizes and colors")
```

###naming only part of a dataset in a scatterplot:

```{r}
# Create MPG.city vs. Horsepower plot with solid squares
plot(Cars93$Horsepower, Cars93$MPG.city, pch = 15)

# Create index3, pointing to 3-cylinder cars
index3 <- which(Cars93$Cylinders == 3)

# Add text giving names of cars next to data points of 3 cylinder cars
text(x = Cars93$Horsepower[index3], 
     y = Cars93$MPG.city[index3],
     labels = Cars93$Make[index3], adj = 0)
```

*Adding a legend to the plot* see example:

```{r}
library(MASS)
plot(Cars93$Price, Cars93$Max.Price, pch = 17, col = "red", xlab = "Average price", ylab = "Min & Max price")
points(Cars93$Price, Cars93$Min.Price, pch = 16, col = "green")
#pch, col and legend are all displayed as vectors
legend(x = "topleft", pch = c(16, 17), col = c("green", "red"), legend = c("Min Price", "Max Price"))
title("The pegend() function adds boxed explanatory text")

```

*Adding custom axes to a plot*, with `axes = FALSE` see example:
`side = 1` for x axis below plot, 2 means y to left of plot, 3 = x axis above plot , 4 = y axis to right of plot
`at` argument indicates where the axis tick marks are, and `labels` indicates what lables should appear at these tick marks
`las = 2` orients labels perpendicular to axis

```{r}
library(MASS)
#axes = FALSE
boxplot(MPG.city ~ Cylinders, data = Cars93, varwidth = TRUE, axes = FALSE)

axis(side = 3, at = Cars93$Cylinders, labels = as.character(Cars93$Cylinders), las = 2)
axis(side = 4, col = "red", las = 1)

```

*Adding a smooth trend line*, see example:
`supsmu` function provides this smooth curve: (supsmu(x, y))
`bass` argument: controls the degree of smoothness in the resulting trend curve. The default value is 0, but specifying larger values (up to a maximum of 10) results in a smoother curve

```{r}
library(MASS)
plot(Boston$rm, Boston$medv)
trend <- supsmu(Boston$rm, Boston$medv)
lines(trend, lwd = 2, col = "blue")
```

##Managing Visual Complexity

* showing details clearly
* not showing too much results/ details at the same time

###Multiple scatter plots on one set of axes: matplot()

``` {r}
library(MASS)
# calling a numerical X variable and a matrix of y values
matplot(Cars93$Horsepower, Cars93[, c("MPG.city", "MPG.highway")], xlab = "Horsepower", ylab = "Gas mileage")
legend("topright", pch = c("1", "2"), col = c("black", "red"), legend = c("MPG.city", "MPG.highway"))

```

`wordcloud()` function: make the words that a repeated more often appear bigger. This function is called with a character vector of words, and a second numerical vector giving the number of times each word appears in the collection used to generate the wordcloud.

Argument `scale`is a two-component numerical vector giving the relative size of the largest word in the display and that of the smallest word.

Argument ` min. freq` The wordcloud only includes those words that occur at least min.freq times in the collection and the default value for this argument is 3.

example:
```{r}
#install.packages("wordcloud")
library(wordcloud)
# Create mfr_table of manufacturer frequencies
mfr_table <- table(Cars93$Manufacturer)

# Create the default wordcloud from this table
wordcloud(words = names(mfr_table), 
          freq = as.numeric(mfr_table), 
          scale = c(2, 0.25))

# Change the minimum word frequency
wordcloud(words = names(mfr_table), 
          freq = as.numeric(mfr_table), 
          scale = c(2, 0.25), 
          min.freq = 1)

```

When putting multiple plots side by sie with the `par(mfrow = c(n, n))` function, it is possible to specify how to take advantage of the space of the graph. With the argument `pty = "s"` will generate square plots, while `pty = "m"` will maximise the space.

*Chage the range of the plot's axes so that all the plots that are side by side have the same range on their axes*: 

```{r}
# Define common x and y limits for the four plots
xmin <- min(anscombe$x1, anscombe$x2, anscombe$x3, anscombe$x4)
xmax <- max(anscombe$x1, anscombe$x2, anscombe$x3, anscombe$x4)
ymin <- min(anscombe$y1, anscombe$y2, anscombe$y3, anscombe$y4)
ymax <- max(anscombe$y1, anscombe$y2, anscombe$y3, anscombe$y4)

# Set up a two-by-two plot array
par(mfrow = c(2, 2))

# Plot y1 vs. x1 with common x and y limits, labels & title
plot(anscombe$x1, anscombe$y1,
     xlim = c(xmin, xmax),
     ylim = c(ymin, ymax),
     xlab = "x value", ylab = "y value",
     main = "First dataset")

# Do the same for the y2 vs. x2 plot
plot(anscombe$x2, anscombe$y2,
     xlim = c(xmin, xmax),
     ylim = c(ymin, ymax),
     xlab = "x value", ylab = "y value",
     main = "Second dataset")

# Do the same for the y3 vs. x3 plot
plot(anscombe$x3, anscombe$y3,
     xlim = c(xmin, xmax),
     ylim = c(ymin, ymax),
     xlab = "x value", ylab = "y value",
     main = "Third dataset")

# Do the same for the y4 vs. x4 plot
plot(anscombe$x4, anscombe$y4,
     xlim = c(xmin, xmax),
     ylim = c(ymin, ymax),
     xlab = "x value", ylab = "y value",
     main = "Fourth dataset")
```


###Creating plot arrays with the layout() function:

Takes more works, but offers more flexibility.
2 steps: constructing the layout matrix indicates where each plot goes, then call layout function.

```{r}
# first step: construction the layout matrix

#first plot will take up the space of a large rectangle of 2 X 3
rowA <- c(1, 1, 1)
# second plot, blank space, third plot ( 2nd and 3rd plots will be much smaller and square)
rowB <- c(2, 0, 3)
layoutVector <- c(rowA, rowA, rowB)

#byrow = TRUE indicates that the parts of the vector will bw on different rows, and nrow =  3 indicates that there are 3 rows
layoutMatrix <- matrix(layoutVector, byrow = TRUE, nrow = 3)
layoutMatrix
```

```{r}
layout(layoutMatrix)
# to see the layout of the 3 plots
layout.show(n = 3)
# then we would create 3 plots
```

##Creating and saving more complex plots

`barplot()` function also returns a vector of numerical values. The returns value of this function will be captured  and can be used to assign names for the bars.

```{r}
library(MASS)
tbl <- table(UScereal$shelf)
#capturing the return value of this barplot(returns numerical vector with the center positions of each bars)
#Here name.arg = "" to suppress the default y axis legend.
mids <- barplot(tbl, horiz = TRUE, col = "transparent", names.arg = "")
mids

text(10, mids, names(tbl), col = "red", font = 2, cex = 2)
title("Distribution of cereals by shelf")

```


###Showing relation between 3 or more variables with the symbol() function
 The size and shape of points can be determined by other variables.See example:
 
 `symbol(x, y,arguments)`

```{r}
library(MASS)
# `squares` is shape of points, could also be `circles`
#`bg` backgroud color of each symbol is also determined by shelf variable
symbols(UScereal$sugars, UScereal$calories, squares = UScereal$shelf, inches = 0.1, bg = rainbow(3)[UScereal$shelf])
title("Cereal calories vs. sugars, coded by shelf")

```


## Saving plots as png files:

`png("")`, which specifies the name of the png file to be generated and sets up a special environment that captures all graphical output until we exit this environment with the dev.off() command.See example:

```{r}
#divert graph output to png file
png("SavedGraph.png")
#Create the plot
symbols(UScereal$sugars, UScereal$calories, squares = UScereal$shelf, inches = 0.1, bg = rainbow(3)[UScereal$shelf])

#Add title
title("Cereal calories vs. sugars, coded by shelf")
```

To exit: 

```{r}
# Call png() with the name of the file we want to create
png("bubbleplot.png")

# Re-create the plot from the last exercise
symbols(Cars93$Horsepower, Cars93$MPG.city,
        circles = sqrt(Cars93$Price),
        inches = 0.1)

# Save our file and return to our interactive session
dev.off()

# Verify that we have created the file
list.files(pattern = "png")

```


###Using color effectively:

limitations of color: reproduction of papers in black and white...
Ideally, use max 6 color in graph, ideally primary colors.
example:
```{r}
# Iliinsky and Steele color name vector
IScolors <- c("red", "green", "yellow", "blue",
              "black", "white", "pink", "cyan",
              "gray", "orange", "brown", "purple")

# Create the `cylinderLevels` variable
cylinderLevels <- as.numeric(Cars93$Cylinders)

# Create the colored bubbleplot
symbols(Cars93$Horsepower, Cars93$MPG.city, 
        circles = cylinderLevels, inches = 0.2, 
        bg = IScolors[cylinderLevels])

```

###Other graphics systems in R

* Base R: Flexible, good for exploratory analysis and easy to learn
* grid package: greater control over low-level graphical details, more flexible than base, but steeper learning curve (grid base, but requires familiarity with both packages)
* Lattice: Very good at conditional scatterplots
* ggplot2: very popular, easy, allows to build a plot in stages












