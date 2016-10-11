---
title: "Building scatter plots with ggplot2"
output: html_document
author: "Tue Nguyen"
layout: "post"
date: "October 11, 2016"
category: "R tutorials"
tags: ["ggplot2"]
thumb: '161011-ggplot2-scatter-plots.png'
---





## Learning outcomes
- Learn how to build a simple scatter plot
- Learn how to tailor the plot with aesthetics (color, shape, size, etc.)
- Distinguish between mapping an aesthetic to a variable and setting it to a constant value
- Understand why we want to map aesthetics to variable
- Learn which aesthetics are suitable for which types of data
- Learn how to fit a regression line to a scatter plot

## Requirements
- Packages: `ggplot2`


## Scatter plots
- A scatter plot is often used to reveal the relationship between **2 continuous** variables.
- Each observation (or case) is represented by one **point**.

## Examples
- **Dataset**: `mpg` -- *miles per gallon dataset*
- **Variables** of interest:
    + `displ` (continuous) -- *engine displacement in litres*
    + `cty` (continuous) -- *miles per gallon of city driving*
    + `cyl` (integer) -- *number of cylinders*
    + `drv` (factor) -- *type of drivetrain*. 3 levels:
        + `f` -- front wheel
        + `r` -- rear wheel
        + `4` -- four wheel

### 1. A simple scatter plot
- **Goal**: creat a scatter plot of `displ` vs `cty`
- **Solution**: use `geom_point()`


```r
ggplot(mpg, aes(displ, cty)) +
  geom_point()
```

<img src="/figure/rmd/r-tutorials/2016-10-11-building-scatter-plots-with-ggplot2/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="864" />

### 2. Mappings vs. setting
We need to distinguish between **maping** an aesthetic to a variable and **setting** it to a constant value.

- **setting**:
    + all obersvations will be displayed the same
    + done outside `aes()`
    + used when you want to change the appearance only
- **mapping**:
    + observations displayed differently depending on the values of the variable that the aesthetic is mapped to
    + done inside `aes()`
    + use when you want to **group** observations by some attribute (variable), for example, group cars by type of drivetrain. 

To be clearer about this, see the examples in the following sections.

### 3. Mapping and setting color
1. Here is how to **map** `color` to a variable
    + **Goal**: display points using different colors based on `drv` (drivetrain type)
    + **Solution**: map `color` aesthetic to `drv` by specifying it inside `aes()`
    

```r
ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(color = drv))
```

<img src="/figure/rmd/r-tutorials/2016-10-11-building-scatter-plots-with-ggplot2/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="864" />

2. And here is how to **set** `color` to a fixed value
    + **Goal**: display all points in **blue**
    + **Solution**: set `color` to "blue" by passing it to `geom_point()`. Do not put it inside `aes()`
    

```r
ggplot(mpg, aes(displ, cty)) +
  geom_point(color = 'blue')
```

<img src="/figure/rmd/r-tutorials/2016-10-11-building-scatter-plots-with-ggplot2/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" width="864" />

3. **Notes**:
    + `geom_xxx()` functions take the first argument as `mapping`, so we don't need `mapping =`
    + we can specify `color` in the default mappings. However, be careful if we have multiple layers because the default values are used by all layers.

### 4. Mapping and setting shape
Mapping or setting `shape` is accompished in the same way we have done with `color`

1. Mapping `shape` to a variable
    + **Goal**: display points using diffrent shapes based on `drv`
    + **Solution**: map `shape` aesthetic to `drv` using `aes()`


```r
ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(shape = drv))
```

<img src="/figure/rmd/r-tutorials/2016-10-11-building-scatter-plots-with-ggplot2/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" width="864" />
    

2. Setting `shape` to a fixed value
    + **Goal**: display points as **squares** instead of **dots**
    + **Solution**: set `shape` to the corresponding code
        + each shape is coded by one integer from 1 to 25; for example: (filled) square = 15 
        + google for the complete list of shapes


```r
ggplot(mpg, aes(displ, cty)) +
  geom_point(shape = 15)
```

<img src="/figure/rmd/r-tutorials/2016-10-11-building-scatter-plots-with-ggplot2/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" width="864" />
    
### 5. Mapping and setting size
1. Mapping `size` to a variable
    + **Goal**: using larger points to display cars that have more number of cylinders
    + **Solution**: map `size` aesthetic to `cyl` using `aes()`
    + **Note**: we also map `color` to `drv` so that we can also observe other interesting patterns


```r
ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(color = drv,
                 size = cyl))
```

<img src="/figure/rmd/r-tutorials/2016-10-11-building-scatter-plots-with-ggplot2/unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" width="864" />
    

2. Setting `size` to a fixed value
    + **Goal**: display all points with the same size, but a bit bigger than the default value (default size = 1.5)
    + **Solution**: set `size` to a number

```r
ggplot(mpg, aes(displ, cty)) +
  geom_point(size = 2.5)
```

<img src="/figure/rmd/r-tutorials/2016-10-11-building-scatter-plots-with-ggplot2/unnamed-chunk-8-1.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" width="864" />

### 6. Mapping and setting transparency
1. Mapping transparency to a variable
    + **Goal**: display points that have more number of cylinders bigger and with higher transparency
    + **Solution**: 
        + map `size` to `cyl`
        + map `alpha` to `1 / cyl`


```r
ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(size = cyl,
                 alpha = 1 / cyl))
```

<img src="/figure/rmd/r-tutorials/2016-10-11-building-scatter-plots-with-ggplot2/unnamed-chunk-9-1.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" width="864" />

2. Setting transparency to a fixed value
    + **Goal**: display all points with 50% transparency
    + **Solution**: set `alpha = 0.5`
        + alpha = 1: completely opaque
        + alpha = 0: completely transparent
    

```r
ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(size = cyl),
             alpha = 0.5)
```

<img src="/figure/rmd/r-tutorials/2016-10-11-building-scatter-plots-with-ggplot2/unnamed-chunk-10-1.png" title="plot of chunk unnamed-chunk-10" alt="plot of chunk unnamed-chunk-10" width="864" />


### 7. Aesthetics and data types
- Different aesthetics work better with different types of variables
    + `color`, `shape`: works well with **categorical** variables
    + `size`: works well with **continuous** variables
- `color` is sometimes useful when using with continuous variables
- `shape` will not work well with a variable that have too many levels (more than 5)
- Keep it simple, don't use too many aesthetics in a plot -- it's hard to see the relationships simultaneously among shape, color, and size.

### 8. Adding a regression line
- **Goal**: add a fitted regression line to the scatter plot
- **Solution**:
    + add one more layer
    + using `stat_xxx` instead of `geom_xxx` because this time we don't display the data, but the statistics calculated from the data
    + the appropriate statistical transformation is `stat_smooth()`
    + `stat_smooth` uses `loess` as the default method and 95% as the level of confidence
    + we will change method to `lm` (which means **linear model**)


```r
ggplot(mpg, aes(displ, cty)) +
  geom_point() +
  stat_smooth(method = 'lm')
```

<img src="/figure/rmd/r-tutorials/2016-10-11-building-scatter-plots-with-ggplot2/unnamed-chunk-11-1.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" width="864" />

- We can set the level of confidence to 99% and disable the confidence region (the grey area along the line) as follows:


```r
ggplot(mpg, aes(displ, cty)) +
  geom_point() +
  stat_smooth(method = 'lm',
              level = .99,
              se = FALSE)
```

<img src="/figure/rmd/r-tutorials/2016-10-11-building-scatter-plots-with-ggplot2/unnamed-chunk-12-1.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" width="864" />

## Wrap-up
Here are the key points to take home:

- Build a scatter plot using `geom_point()`
- Tailor a plot with appropriate aesthetics (color, shape, size, etc.)
- Understand the difference between **mapping** and **setting** an aesthetic
    + Mapping: 
        + points will be displayed differently based on the values of the variable that the aesthetic is mapped to
        + done inside `aes()`
        + used when we want to categorize (or group) observations by some variable
    + Setting:
        + points are displayed the same
        + done outside `aes()`
        + used when we want to change the look of the points only
- Different aesthetics work better with difference data types
    + color, shape: works well with **categorical** variables
    + size: works well with **continuous** variables
    + shape: not suitable for variables that have more than 5 levels
- Don't use too many aesthetics in one plot because it's hard to see too many intertwined relationships. Some solutions
    + use facetting
    + build separate plots
- We can add a regression line to a scatter plot by adding another layer using `stat_smooth()`