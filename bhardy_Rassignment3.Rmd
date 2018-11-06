---
title: "bhardy_assignment3"
author: "bhardym"
date: "November 3, 2018"
output:
  html_document: default
  pdf_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

[Here is a link]https://www.dropbox.com/s/gqu520cc6r7xjw4/eXpress_dm_counts.csv?dl=0) to some data that was used in a recent paper from our lab using RNA-seq to help understand the relationship between condition dependence and sexual dimorphism using the Asian Rhinocerous beetle. This data is a set of counts of expression values after mapping reads to the beetle transcriptome, and identifying orthologs (in this case to Drosophila), Each row (FBpp) represents a distinct polypeptide (which is how we identified orthology between the beetles and the flies), and each column are the estimated counts from the RNA-seq data for the given gene for a given sample. So all counts on a single row are for the same gene (but across samples), while all counts within a single column are for all of the genes within an individual sample.

Sample names (column names) have identifiers about the individual, nutritional treatment, sex and tissue each seperated by an underscore.

So F101_lg_female_hdhorn is individual F101, from the high nutrition (lg is for large, since the animals are bigger with better food), a female, and from the head horn tissue. While M120_sm_male_genitalia is individual 120, low nutrition (small), male from the genitalia tissue.

Two nutritional treatments (lg and sm) four tissues (only three in females) hdhorn (head horn), thoracic horn (thxhorn), wing and genitalia.

For this assignment I want you to use your knowledge of control flow, writing functions, and performing repeated operations (using loops and/or apply family of functions) to generate some summaries.

###Question 2. 
Read in the .csv file (call it rna_counts). Write a function that calculates and can output mean expression (using the mean() function) for a given data column. Write this function so that it can work on either raw counts (as provided) or transformed to log2 values of the counts, with a logical argument that allows the user to choose whether to do this on the raw scale or log2 scale (i.e. log2 transform, then calculate the mean). Make sure all functions you write for this assignment have this argument. We often use log2 scale for RNAseq data. Demonstrate that it works on several of the columns of data.
```{R}
rna_counts <- read.csv("eXpress_dm_counts.csv", stringsAsFactors = FALSE)
rna_counts[2:56] <- lapply(rna_counts[2:56], as.numeric)
mean_expression <- function(x, raw = TRUE){
    if (raw != TRUE) {
     x<- 2 ^ x
     print(mean(x))
    } else {
      print(mean(x))
    }
}

mean_expression(rna_counts$F101_lg_female_hdhorn, raw = TRUE)
mean_expression(rna_counts$F101_lg_female_thxhorn, raw = TRUE)
mean_expression(rna_counts$F101_lg_female_wings, raw = TRUE)

```

###Question 3. 
Now using the function you have written, use a loop to generate a vector of the mean expression value for each column (each sample). Make sure that your output vector have named elements (i.e. each element of the vector is associated with the names of the original columns of the data). Confirm that this function is giving you the correct answer based on what you found in question 2. Do you notice any patterns for which individuals or tissues have the highest mean expression?
```{R}
rna_counts <- read.csv("eXpress_dm_counts.csv", stringsAsFactors = FALSE)
rna_counts[2:56] <- lapply(rna_counts[2:56], as.numeric)
rna_counts <- rna_counts[2:56]

col_sample_mean <- vector()
for(i in rna_counts){
 col_sample_mean <- cbind(col_sample_mean, c(mean_expression(i)))
}
 colnames(col_sample_mean)=colnames(rna_counts)
 col_sample_mean

```

###Question 4. 
Repeat this procedure (using the function you wrote, or slightly revised) that uses one of the apply family of functions to do the same as 3. Check which is faster (to compute not to write), and demonstrate how you did this.
```{R}
sapply(rna_counts[2:55], mean_expression)
system.time(sapply(rna_counts[2:55], mean_expression))
system.time(col_sample_mean)
```

###Question 5. 
What is a much easier way to do the operations we did in Q 3 and 4, (i.e. you don't need to write your own function) to calculate and output all of the column means? i.e. an Rish way of doing this?
```{R}
mean_sample <- vector(length = 55)
mean_sample <- sapply(rna_counts[2:55], mean)
mean_sample
```

###Question 6. 
It is common (say for a MAplot) to want the mean expression value of each given gene across all samples. Write a function to do this, and using one of the approaches from Q 3-5 generate and store these values in a variable.
```{R}
rna_counts[2:55] <- lapply(rna_counts[2:55], as.numeric)
rna_counts <- rna_counts

gene_exp_mean <- function(x, y, raw = TRUE){
  if (raw != TRUE) {
     x<- 2 ^ x
     z <- rowMeans(x[y])
    } else {
     z <- rowMeans(x[y])
    }
  return(z)
}

gene_expres <- gene_exp_mean(rna_counts,2:55)
head(gene_expres, n = 15L)
```

###Question 7. 
We are very interested in what is going on in the head horns between small males and large males. Using the type of tools you have written (feel free to modify as you need, but show the new functions) calculate the mean expression for the subset of columns for large and small male head horns. Note you are calculating means on a gene by gene basis, NOT sample by sample. Now calculate the mean difference (again gene by gene) between large male and small males (for head horns). i.e. first calculate the mean expression among individuals who are large males (head horns), ditto for the small males, and calculate their difference.
```{R}
headhorns_lg <- rna_counts[,c(grep(".*lg_male_hdhorn$", names(rna_counts))), drop=F]
headhorns_sm <- rna_counts[,c(grep(".*sm_male_hdhorn$", names(rna_counts))), drop=F]

gene_exp_mean <- function(x, y, raw = TRUE){
  if (raw != TRUE) {
     x<- 2 ^ x
     z <- rowMeans(x[y])
    } else {
     z <- rowMeans(x[y])
    }
  return(z)
}
large <- gene_exp_mean(headhorns_lg, raw = TRUE)
small <- gene_exp_mean(headhorns_sm, raw = TRUE)
diff_expres <- large - small
head(diff_expres, n = 15L)
```

###Question 8. 
Using the basic plot function (although you can use ggplot2 if you prefer), plot the mean expression of each gene on the X axis, and the difference in expression values on the Y axis. Now repeat, but with log2 transformed data. This is the basic idea of a MAplot.
```{R}
library(ggplot2)
# if data is 0, replace by 0.0001
for(i in gene_expres){
  if(i == 0){
    i <- 0.01
  }
}
for(i in diff_expres){
  if(i == 0){
    i <- 0.01
  }
}
ggplot(rna_counts, aes(x= gene_expres, y = diff_expres)) + geom_point()
ggplot(rna_counts, aes(x= gene_expres, y = diff_expres)) + geom_point() + scale_x_continuous(trans='log2') + scale_y_continuous(trans='log2')
```

###Bonus question. 
What other way might you be able to do these operations (could be a tidyverse way, or a more Rish vectorized way)?