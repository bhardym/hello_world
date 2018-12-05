---
title: "assignement4_bhardym"
author: "bhardym"
date: "November 30, 2018"
output: html_document
---
##Question 1 
done

##Question 2
```{r}
#for diploids
#w_AA, w_Aa, w_aa are are the fitness of each genotype
#p=allele freq of A, q=allele freq of a in generation t
#n= number of generations
diploid <- function(w_AA, w_Aa, w_aa, p_0, q_0, n){
  #initializing vectors to store allele freq and mean pop fitness
  p <- rep(NA, n)
  q <- rep(NA, n)
  p_t <- rep(NA, n)
  mean_pop_fitness <- rep(NA, n)
  
  # conditions
  p[1] <- p_0
  q[1] <- q_0
  mean_pop_fitness[1] <- (p[1]^2*w_AA)+(2*p[1]*q[1]*w_Aa)+(q[1]^2*w_aa)
  
  #for loop
  for (i in 2:length(p)) {
    mean_pop_fitness[i] <- (p[i-1]^2*w_AA)+(2*p[i-1]*q[i-1]*w_Aa)+(q[i-1]^2*w_aa)
    p[i] <- (p[i-1]^2*(w_AA/mean_pop_fitness[i-1]))+(p[i-1]*q[i-1]*(w_Aa/mean_pop_fitness[i-1])) 
    q[i] <- 1-p[i]
  }
  
  if (any(p>0.99999, na.rm = TRUE)){
    fixation <- min(which.max(p>0.99999))
    cat("fixation for A occurs in approximately at generation:", fixation)
  } else{
    maxAlleleFreq <- max(p)
    cat("fixation of A does not occur, max allele frequency is:", print(maxAlleleFreq, digit = 2))
  }
 
  plot(x = 1:n, y = p, 
     xlab="generations", 
	 ylab="Allele frequency (p)", 
	 pch = 20, col = "red", cex.lab = 1.5)
}
diploid(w_AA = 1.2, w_Aa = 1.1, w_aa = 1, p = 0.02, q = 0.98, n = 200)

```

##Question 3
```{r}
#N = population size, pA = starting pop freq
allele_counts <- function(N, pA, n_generations){
  pA <- c()
  pA[1] <- 0.5 #1st generation freq.
  i <- 1
  
  while(i < n_generations){ #run loop for all generations
    nA <-0 #number of A individuals, setting counter to individual 0
    for(j in 1:N){ #for each individual
      random <- runif(1) #generate a random number
      if(random < pA[i]){ #if the random number is less than pA, add 1 to nA counter
        nA <- nA + 1
      }
    }
    pA[i+1] <- nA/N
    i <- i+1 #increment i
  }
  plot(1:i, pA[1:i], xlab = "generations", ylab = "allele frequencies", type = "o")
  
}
allele_counts(N = 50, pA = 0.5, n_generations = 100)

```



##Question 4
```{r}
#N = population size, pA = starting pop freq
allele_counts <- function(N, pA, n_generations, simulation){
  pA <- c()
  pA[1] <- 0.5 #1st generation freq.
  i <- 1
  lost <- 0
  
  for(t in 1:simulation){
  while(i < n_generations){ #run loop for all generations
    nA <-0 #number of A individuals, setting counter to individual 0
    for(j in 1:N){ #for each individual
      random <- runif(1) #generate a random number
      if(random < pA[i]){ #if the random number is less than pA, add 1 to nA counter
        nA <- nA + 1
      }
    }
    pA[i+1] <- nA/N
    i <- i+1 #increment i
  }
    if(nA == 0){
      lost <- lost + 1
    }
  }
  print("proprtion of lost A allele lost over 1000 times is")
  return(lost/1000)
  
}
allele_counts(N = 400, pA = 0.5, n_generations = 100, simulation = 1000)

```

```{r}
#N = population size, pA = starting pop freq
allele_counts <- function(N, pA, n_generations, simulation){
  pA <- c()
  pA[1] <- 0.25 #1st generation freq.
  i <- 1
  lost <- 0
  
  for(t in 1:simulation){
  while(i < n_generations){ #run loop for all generations
    nA <-0 #number of A individuals, setting counter to individual 0
    for(j in 1:N){ #for each individual
      random <- runif(1) #generate a random number
      if(random < pA[i]){ #if the random number is less than pA, add 1 to nA counter
        nA <- nA + 1
      }
    }
    pA[i+1] <- nA/N
    i <- i+1 #increment i
  }
    if(nA == 0){
      lost <- lost + 1
    }
  }
  print("proprtion of lost A allele lost over 1000 times is")
  return(lost/1000)
  
}
allele_counts(N = 400, pA = 0.25, n_generations = 100, simulation = 1000)

```

```{r}
#N = population size, pA = starting pop freq
allele_counts <- function(N, pA, n_generations, simulation){
  pA <- c()
  pA[1] <- 0.1 #1st generation freq.
  i <- 1
  lost <- 0
  
  for(t in 1:simulation){
  while(i < n_generations){ #run loop for all generations
    nA <-0 #number of A individuals, setting counter to individual 0
    for(j in 1:N){ #for each individual
      random <- runif(1) #generate a random number
      if(random < pA[i]){ #if the random number is less than pA, add 1 to nA counter
        nA <- nA + 1
      }
    }
    pA[i+1] <- nA/N
    i <- i+1 #increment i
  }
    if(nA == 0){
      lost <- lost + 1
    }
  }
  print("proprtion of lost A allele lost over 1000 times is")
  return(lost/1000)
  
}
allele_counts(N = 400, pA = 0.1, n_generations = 100, simulation = 1000)

```

##Question 5
```{r}
#N = population size, pA = starting pop freq
allele_counts <- function(N, pA, n_generations, simulation){
  pA <- c()
  pA[1] <- 0.1 #1st generation freq.
  i <- 1
  lost <- 0
  
  for(t in 1:simulation){
  while(i < n_generations){ #run loop for all generations
    nA <-0 #number of A individuals, setting counter to individual 0
    for(j in 1:N){ #for each individual
      random <- runif(1) #generate a random number
      if(random < pA[i]){ #if the random number is less than pA, add 1 to nA counter
        nA <- nA + 1
      }
    }
    pA[i+1] <- nA/N
    i <- i+1 #increment i
  }
    if(nA == 0){
      lost <- lost + 1
    }
  }
  cat(pA)
  #dat <- matrix(pA, ncol = simulation)
  #matplot(dat, type = c("b"), pch = 1, col = 1:100)
  #plot(1:i, pA[1:i], xlab = "generations", ylab = "allele frequencies", type = "o")
  
}
allele_counts(N = 400, pA = 0.1, n_generations = 100, simulation = 100)

```



##Question 6
```{r}
#First part
# not as a function
x <- seq(from = 1, to = 10, length.out = 20)#length.out is how many observations we will have
a <- 0.5 #intercept
b <- 0.1#slope
y_deterministic <- a + b*x
set.seed(3)
y_simulated <- rnorm(length(x), mean = y_deterministic, sd = 2)

mod_sim <- lm(y_simulated ~ x)
p_val_slope <- summary(mod_sim)$coef[2,4] #extract the p-value
p_val_slope

# as a function:
#n = number of observations, a = intercept, b= slope
p_val_slope2 <- function(n, a, b, sd){
  x <- seq(from = 1, to = 10, length.out = n)
  y_deterministic <- a + b*x
  set.seed(3)
  y_simulated <- rnorm(length(x), mean = y_deterministic, sd)
  
mod_sim <- lm(y_simulated ~ x)
p_val_slope <- summary(mod_sim)$coef[2,4] #extract the p-value
p_val_slope
}
p_val_slope2(n = 20, a = 0.5, b = 0.1, sd = 2)

```

```{r}
# Second part: without set-seed
p_val_slope2 <- function(n, a, b, sd){
  x <- seq(from = 1, to = 10, length.out = n)
  y_deterministic <- a + b*x
  y_simulated <- rnorm(length(x), mean = y_deterministic, sd)
  
mod_sim <- lm(y_simulated ~ x)
p_val_slope <- summary(mod_sim)$coef[2,4] #extract the p-value
p_val_slope
}
p_val_slope2(n = 20, a = 0.5, b = 0.1, sd = 2)

all_slopes_p_val <- replicate(1000, p_val_slope2(n = 20, a = 0.5, b = 0.1, sd = 2))


hist(all_slopes_p_val, xlab = "p-values", ylab = "frequency of occurence in 1000 simulations", breaks = 20)
```
Proportion of time that p-value is <0.05 is 0.1


```{r}
#Third part
p_val_slope2 <- function(n, a, b, sd){
  x <- seq(from = 1, to = 10, length.out = n)
  y_deterministic <- a + b*x
  y_simulated <- rnorm(length(x), mean = y_deterministic, sd)
  
mod_sim <- lm(y_simulated ~ x)
p_val_slope <- summary(mod_sim)$coef[2,4] #extract the p-value
p_val_slope
}
p_val_slope2(n = 20, a = 0.5, b = 0.1, sd = 2)

all_slopes_p_val <- replicate(1000, p_val_slope2(n = 20, a = 0.5, b = 0, sd = 2))

hist(all_slopes_p_val, xlab = "p-values", ylab = "frequency of occurence in 1000 simulations", breaks = 20)
```
Proportion of time that p-value is <0.05 is 0,05. If slope is equal to zero, there is no effect, so not correlations are not very significant. 

```{r}
#Fourth part:

#range of correlations
r <- seq(10, 100, by = 5)

p_val_slope2 <- function(n, a, b, sd){
  x <- seq(from = 1, to = 10, length.out = n)
  y_deterministic <- a + b*x
  y_simulated <- rnorm(length(x), mean = y_deterministic, sd)
mod_sim <- lm(y_simulated ~ x)
p_val_slope <- summary(mod_sim)$coef[2,4] #extract the p-value
}

for(i in r){
  samples[i] <- replicate(100, p_val_slope2(r[i], a = 0.5, b = 0.1, sd = 1.5))
}
plot(r, samples, xlab = "sample sizes", ylab = "freq of p<0.05")

```







