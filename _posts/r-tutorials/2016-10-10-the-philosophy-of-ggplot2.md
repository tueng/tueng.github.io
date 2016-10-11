---
title: "The philosophy of ggplot2"
output: html_document
author: "Tue Nguyen"
layout: "post"
date: "October 10, 2016"
category: "R tutorials"
tags: ["ggplot2", "grammar of graphics"]
thumb: '161010-ggplot2-philosophy.png'
---



In this tutorial, we will learn about `ggplot2` and the logic behind it. We will start with some background information such as what is `ggplot2`, why we should use it, and in which situations it is not suitable. Then we will learn a bit about the idea of **grammar of graphics** (GoG), why this approach is better than the tradional ones, and how it is actually implemented in `ggplot2`. 

Of course, there will be examples for you to practice. We'll begin with the most verbose way (full form) to create a plot. When looking at the code, you might think it's ridiculous -- ten lines of code to create just a simple scatter plot. In fact, we don't use that way, but it's a useful starting point to understand how `ggplot2` actually works. Understanding the logic behind `ggplot2` is important because it will clear away a lot of confusion as well as allows you think of plots and build them in a more intuitive and structured manner. So, stay tuned.

## Requirements
- Package: `ggplot2`.
- Knowlege assumption: basic working knowledge of `R`.

## What is ggplot2?
Some quick information about `ggplot2`:

- is a data visualization package written for `R`.
- written by Hadley Wickham in 2005 as a chapter of his PhD thesis.
- originally based on the idea of grammar of graphics (GoG) of Wilkinson et al. (2005).
- supports 2D graphics only.

## Why use ggplot2?
- It implements a **layered grammar of graphics** (a variation of Wilkinson's GoG) which makes the process of creating a plot become more **intuitive** and **consistent**.
- The layer system makes it very easy to create a plot using **multiple datasets**. 
- It has **intelligent default settings** which reduce a lot of manual works.
- It's **flexible**. We can easily add or remove components in a plot.
- It offers **a high level of abstraction** which makes it easier to build sophisticated plots.
- It's easy to **facet** data with `ggplot2`.
- Its **theming system** provides a wide range of useful themes.
- It's **mature**. `ggplot2` has almost fully developed. In fact, it has shifted to maintenance phase, which means no more new feature is going to be added.
- It has **excellent graphics**.


## What is ggplot2 NOT suitable for?
- 3D graphics (alternative: `rgl`)
- Interactive graphics (alternative: `ggvis`)
- Network theory related graphics (alternatives: `igraph`, `sna`, `network`)

## Grammar of graphics
People traditionally referred to graphs by **name** such as box plots, dot plots, scatter plots, bar chart, pie chart, or histogram. This approach has several drawbacks:

1. We are limited to the named plots, while in fact, there are an infinite number of possible plots.
2. By referring plots by name, we fail to acknowledge the similarities and differences among various plot types.

A better approach is to specify a set of core building blocks that make up every graph and a set of rules (grammar) that describe how these blocks can be combined together to produce just any kinds of graphs that we desire. This approach is called **grammar of graphics** (GoG), which was proposed by Wilkinson et al. (2005) and was popularized by Hadley Wickham when he utilized the idea to develop the famous `R` package `ggplot2`.

Why is this better?

1. We can use just a few building blocks to create any types of plots we want.
2. It offers a consistent and systematic way of thinking about how to describe graphs as well as how to create what we've described.

## Layered GoG plot in ggplot2
`ggplot2` doesn't implement the exact version of GoG of Wilkinson, but a variation of it, called **layered GoG**. According to Wickham's layered GoG, a plot is made up of a set of independent **layers**. Each layer contains **5** elements:

1. One **dataset** (`data`) to visualize.
2. One set of **geometric objects** (`geom`) of the same type to actually display the data. Note that the data cannot display themselves. A `geom` type can be line, point, polygon, ribbon, etc.
3. One **statistical transformation** (`stat`) that transforms (typically summarizes) the data in some useful way like counting frequencies or fitting a linear regression line.
4. One set of **aesthetic mappings** (`mapping`) that map the variables in the dataset to aesthetic attributes of the `geom`. Aesthetic attributes can be color, shape, size, opacity, etc. Each `geom` type accepts a set of possible aesthetic attributes.
5. One specification about **position adjustment** (`position`) that describe how to adjust the position of the `geom` objects.

Besides a set of **layers**, a plot also has **4** other components that share among all layers in the plot:

1. One set of **scales** (`scale`) -- each mapping needs a scale to convert the data values to the corresponding aesthetic values. 
    + For example:
        + position mapping needs position scale. If a variable is continuous and mapped to `x`, then `scale_x_continuous` will be used.
        + shape mapping needs a shape scale.
        + etc.
    + When a scale is used, it also produces a **guide** that serve as a reference to help us interpret the values from the plot. Guides can be:
        + **axes** (for position scales).
        + **legends** (for the others). 
2. One **coordinate system** (`coord`) onto which the data are projected. Common coords include Cartesian and polar systems.
3. One specification about **faceting** (`facet`) that describes how to split up the data into smaller subsets and arrange the plots of these subsets on the plotting plane.
4. One **theme** (`theme`) that governs the overall defaults of a plot such as background, grids, font face, or color.


## A wrap-up of layered GoG in ggplot2
You've just read a wall of text, so it's useful to have a summary of the key points. Here are 2 important formulas:

1. a plot = layers + (scales + coord + facet + theme).
2. a layer = data + geom + stat + mappings + position.

And creating a plot in `ggplot2` (using layered GoG fashion) can be done as follows:

1. Create a plot object using `ggplot()`.

2. Creat at least one **layer** (using `layer()`) that contains:
    + one **dataset**
    + one **geom**
    + one **stat**
    + one set of aesthetic **mappings**
    + one **position** adjustment specification.
    
3. Provide a set of common **specifications** that share among all layers:
    + one set of **scales**. Each aesthetic mapping used in the layers needs one scale.
    + one **coord**.
    + one **facet** specification.
    + one **theme**

## Examples

### Understanding the data
We will create a scatter plot using the `diamonds` dataset that comes with `ggplot2` by default. First, we will load `ggplot2` into `R` and explore the dataset.


```r
# load ggplot2
library(ggplot2)

# view the structure of diamonds dataset
str(diamonds)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	53940 obs. of  10 variables:
##  $ carat  : num  0.23 0.21 0.23 0.29 0.31 0.24 0.24 0.26 0.22 0.23 ...
##  $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 5 4 2 4 2 3 3 3 1 3 ...
##  $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 2 2 6 7 7 6 5 2 5 ...
##  $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 2 3 5 4 2 6 7 3 4 5 ...
##  $ depth  : num  61.5 59.8 56.9 62.4 63.3 62.8 62.3 61.9 65.1 59.4 ...
##  $ table  : num  55 61 65 58 58 57 57 55 61 61 ...
##  $ price  : int  326 326 327 334 335 336 336 337 337 338 ...
##  $ x      : num  3.95 3.89 4.05 4.2 4.34 3.94 3.95 4.07 3.87 4 ...
##  $ y      : num  3.98 3.84 4.07 4.23 4.35 3.96 3.98 4.11 3.78 4.05 ...
##  $ z      : num  2.43 2.31 2.31 2.63 2.75 2.48 2.47 2.53 2.49 2.39 ...
```

```r
# view some first rows of the dataset
head(diamonds)
```

```
##   carat       cut color clarity depth table price    x    y    z
## 1  0.23     Ideal     E     SI2  61.5    55   326 3.95 3.98 2.43
## 2  0.21   Premium     E     SI1  59.8    61   326 3.89 3.84 2.31
## 3  0.23      Good     E     VS1  56.9    65   327 4.05 4.07 2.31
## 4  0.29   Premium     I     VS2  62.4    58   334 4.20 4.23 2.63
## 5  0.31      Good     J     SI2  63.3    58   335 4.34 4.35 2.75
## 6  0.24 Very Good     J    VVS2  62.8    57   336 3.94 3.96 2.48
```

Some quick information about `diamonds`:

- is a data frame.
- has 53,940 observations (rows).
- has 10 variables (columns). In this tutorial, we're interested in the following variables:
    + `carat` - the carat of a diamond.
        + continuous variable.
    + `price` - the price of a diamond.
        + continuous variables.
        
### Plot creation

**Goal** -- to build a **scatter** plot of `price` versus `carat` to see if there is a relationship between these variables.

#### Step 1: Specification
In this step, we will **describe** how we will create the plot. According to `ggplot2`'s philosophy, we need:

1. A **layer** that has:
    + one **dataset** -- use `diamonds`.
    + one **geom** -- use a **point** to display each observation.
    + one **stat** -- use **identity**, which means *"keep each point as is, don't apply any statistical transformation"*.
    + one set of **mappings** -- we will map
        + `carat` to the x-axis.
        + `price` to the y-axis.
    + one specification on **position** adjustment -- use **identity**, which means "*don't adjust either x or y position*".
    
2. A set of common specifications apart from the layer.
    + one set of **scales** -- since both `carat` and `price` are continuous variables, we use:
        + a continuous position scales for x-position mapping.
        + a continuous position scales for y-position mapping.
    
    + one **coord** -- use Cartesian coord.
    + one **facet** -- don't facet the data.
    + one **theme** -- use grey theme


#### Step 2: Implementation
Now, it's time to **implement** what we've described above to actually generate a plot. 


```r
# CREATE an (empty) plot
ggplot() +
  
  # LAYERS
  # only one layer
  layer(data = diamonds,
        mapping = aes(x = carat, y = price),
        geom = 'point',
        stat = 'identity',
        position = 'identity') +
  
  # COMMON SPECIFICATIONS
  # Scales: use continuous position scales
  scale_x_continuous() +
  scale_y_continuous() +
  
  # Coord: use Cartesian coord
  coord_cartesian() +
  
  # Facet: don't facet
  facet_null() +
  
  # Theme: use them_grey
  theme_grey()
```

<img src="/figure/rmd/r-tutorials/2016-10-10-the-philosophy-of-ggplot2/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="864" />

### Improvement
The code chunk above is too "verbose" for a simple task. However, if we have some basic understanding of how `ggplot2` works, we'll be able to produce the same result with much shorter code.

#### The default settings in ggplot2
1. First, we can remove `theme_grey()` since it's the default theme in `ggplot2`.
2. Second, `gglot2` doesn't facet the data by default, so we can also remove `facet_null()`.
3. Third, `ggplot2` use Cartesian coord as the default coord, so we can remove `coord_cartersian()` as well.
4. Finally, `ggplot2` is clever enough to realize the types of the variables it is dealing with (categorical or continuous) in the aesthetic mappings, and it will automatically apply the appropriate scales to these mappings. Therefore, `scale_x_continuous()` and `scale_x_continuous()` can also be omitted.

And the following code chunk just creates the same scatter plot.


```r
ggplot() +
  
  layer(data = diamonds,
        mapping = aes(x = carat, y = price),
        geom = 'point',
        stat = 'identity',
        position = 'identity')
```

#### A more compact way - using wrappers
Instead of calling `layer()` to build a layer, we can use wrapper functions (or **wrappers** for short). For example, if we want to build a layer displaying points, we can use `geom_point()` function as shown in the example bellow.


```r
ggplot() +
  geom_point(data = diamonds,
             mapping = aes(x = carat, y = price))
```
Here are some benefits of using wrappers instead of `layer()`

1. The geom type is included in the function name, so we don't need to specify `geom` argument.
2. Each geom type has a default **stat** (and vice versa), for example, the default stat of a geom point is **identity**. Therefore, we rarely have to specify `stat` argument (the default value is just right most of the time).
3. We can ignore the `position` argument as well, and `ggplot()` will automatically use the appropriate default value.

There is a wrapper for every geom type such as `geom_point()`, `geom_line()`, or `geom_smooth()`. See the documentation for the complete list.


#### Multiple layers -- the use of default data and mappings
Now, suppose we want to fit a regression line to the the scatter plot. We can do it easily by adding another layer to the plot. The wrapper to create a layer for a regression line / curve is `geom_smooth()`, which uses `loess` as the default method. Since we want a regression **line**, not a curve, we will change the method to `lm` (which means **linear model**). Here is the code.


```r
ggplot() +
  # layer displaying the scatter plot
  geom_point(data = diamonds,
             mapping = aes(x = carat, y = price)) +
  
  # layer displaying the regression line
  geom_smooth(data = diamonds,
              mapping = aes(x = carat, y = price),
              method = 'lm')
```

<img src="/figure/rmd/r-tutorials/2016-10-10-the-philosophy-of-ggplot2/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" width="864" />

You may notice a problem with the code chunk above -- **_the data and aesthetic mappings are completely the same in both layers_**. Luckily, `ggplot2` allows us to set them as default values to be used across multiple layers. What we need to do is to pass them to `ggplot()` instead of passing them to each wrapper.


```r
ggplot(data = diamonds,
       mapping = aes(x = carat, y = price)) +
  geom_point() +
  geom_smooth(method = 'lm')
```

#### Can it be even more compact? -- Well, yes!
How about this?


```r
ggplot(diamonds, aes(carat, price)) +
  geom_point() +
  geom_smooth(method = 'lm')
```

This is how the code chunk above works:

1. `ggplot()` takes the first argument as `data` and the second one as `mapping`. So we just need to pass the data and mappings in that order. `data =` and `mapping =` are not necessary.
2. Similarly, `aes()` takes the first argument as `x` and the second one as `y`, and therefore we don't need `x =` and `y =` as well.

## Wrap-up
The last code chunk shows the best way to create a plot with `ggplot2`, and in fact, most people use that style in practice. However, it's not a very good way to understand how `ggplot2` actually works. That's why I started with the most verbose way. Once we understand mechanism of `ggplot2`, we will feel much more comfortable and avoid a lot of confusion and mistakes. 

To wrap up this tutorial, here are some key points to remember:

### Layered GoG.
According to Wickham's layered GoG, a plot is made of 2 parts: 1) **layers** that actually dislay the data and 2) a set of **common specifications** that share among layers.

- A **layer** has **5** components:
    1. data
    2. geom
    3. stat
    4. mappings
    5. position
- **Common specifications** include:
    1. scales
    2. coord
    3. facet
    4. theme
    
Layered GoG can be summed up in **2** important formulas:

1. A **plot** = layers + (scales + coord + facet + theme).
2. A **layer** = data + mappings + geom + stat + position.

Most of the time, the default values for the common specifications (scales, coord, facet, and theme) are just right, and we just need to focus on defining layers to create plots. Facet can be used from time to time when we want to compare the distributions of the subsets of a dataset conditioned by one or two variables.

### Tips on building plots with ggplot2
Following 3 steps:

1. Create a plot using `ggplot()`. Use the default data and mappings to avoid unnecessary repetition.
2. Add **layers** using wrappers instead of `layer()`. Why?
    + more compact.
    + less error-prone.
    + more intuitive.
3. Add other **specifications** (scales, coord, facet, or theme) if necessary.


## References
1. Hadley Wickham. 2010. _A layered grammar of graphics_. Journal of Computational and Graphical Statistics.
[ [link](http://vita.had.co.nz/papers/layered-grammar.pdf) ]
2. Hadley Wickham. 2016. _ggplot2: Elegant graphics for data analysis_. 2nd edition.  New York (NY): Springer.
3. Hadley Wickham, Winston Chang. 2016. _ggplot2 documentation, version 2.1.0_.
[ [link](http://docs.ggplot2.org/current/) ]
