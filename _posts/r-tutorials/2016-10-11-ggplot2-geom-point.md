---
layout: "post"
title: "ggplot2 - Geom point"
author: "Tue Nguyen"
date: "October 11, 2016"
output: html_document
category: "R tutorials"
tags: ["ggplot2", "grammar of graphics"]
thumb: '161011-ggplot2-geoms.png'
---



## Requirements
- Package: `ggplot2`
- Dataset: `diamonds`, `economics`, `mpg`
- Assumptions:
    + You will explore the datasets by yourself.

## Basic info
- **Function** -- draws a point using an x and a y coordinate
- **Usage** -- to create scatter plots
- Default **stat** -- `identity` (no statistical tranformation)
- Default **position** -- `identity` (no position adjustment)
- Possible **aesthetics**:
    + `x` -- x position.
    + `y` -- y position.
    + `shape` -- shape of the point (default: dot)
    + `size` -- diameter of the point (default: 0.5)
    + `color` -- color of the point (default: black)
    + `fill` -- fill of the point (default: NA; only a few shapes accept `fill`)
    + `alpha` -- transparency of the point (default: 1 -- completely opaque)
    + `stroke` -- the thickness of the point's border

- Other **params**
    + `na.rm` -- whether to suppress warnings when removing points with NA coordinates (default: `FALSE` -- show warnings)

## Examples
### 1. Create a basic scatter plot
- **Dataset**: `mpg`
- **Variables** of interest:
    + `cty` -- miles per gallon for city driving
    + `hwy` -- miles per gallon for highway driving
- **Goal**: 
    + create a scatter plot of `cty` vs `hwy`
    + final result should look like the figure below
    


```
## Error in eval(expr, envir, enclos): could not find function "ggplot"
```

- **Solution**:


```r
ggplot(mpg, aes(cty, hwy)) +
  geom_point()
```

### 2. Use color aesthetic
- **Dataset**: `mpg`
- **Variables** of interest:
    + `cty`
    + `hwy`
    + `manufacturer` -- the manufacturer of a car
- **Goal**: 
    + create a scatter plot of `cty` vs `hwy`.
    + color the points by `manufacturer`
    + final result should look like the figure below


```
## Error in eval(expr, envir, enclos): could not find function "ggplot"
```

- **Solution**:


```r
ggplot(mpg, aes(cty, hwy,
                # mapping for color aesthetic
                color = manufacturer)) +
  geom_point()
```


### 3. Use shape aesthetic
- **Dataset**: `mpg`
- **Variables** of interest:
    + `cty`
    + `hwy`
    + `drv` -- type of drivetrain of a car. 3 levels:
        + `f` -- front wheel.
        + `r` -- rear wheel.
        + `4` -- four wheel.
- **Goal**: 
    + create a scatter plot of `cty` vs `hwy`
    + use different point shapes for different types of `drv`
    + final result should look like the figure below


```
## Error in eval(expr, envir, enclos): could not find function "ggplot"
```

- **Solution**:


```r
ggplot(mpg, aes(cty, hwy, 
                shape = drv)) + # mapping for shape aesthetic
  geom_point()
```

### 4. Use size aesthetic
- **Dataset**: `mpg`
- **Variables** of interest:
    + `cty`
    + `hwy`
    + `displ` -- the engine displacement in litres of a car.
- **Goal**: 
    + create a scatter plot of `cty` vs `hwy`
    + use larger points for cars that have higher `displ`
    + final result should look like the figure below


```
## Error in eval(expr, envir, enclos): could not find function "ggplot"
```

- **Solution**:


```r
ggplot(mpg, aes(cty, hwy, 
                # mapping for shape aesthetic
                size = displ)) +
  geom_point()
```