
title: "In class assignment week 2, part 2. A worked example using control flow (for loops, if statements, etc)"
author: "Angela Fufeng" "Marie-Helene B-Hardy"
output: 
  html_document:
    keep_md: yes
    number_sections: yes
---

# Introduction
Let's do a little exercise integrating some of the things we have learned. Here are some Illumina HiSeq reads for one of our recent projects:

```{r}
read_1 <- "CGCGCAGTAGGGCACATGCCAGGTGTCCGCCACTTGGTGGGCACACAGCCGATGACGAACGGGCTCCTTGACTATAATCTGACCCGTTTGCGTTTGGGTGACCAGGGAGAACTGGTGCTCCTGC"
read_2 <- "AAAAAGCCAACCGAGAAATCCGCCAAGCCTGGCGACAAGAAGCCAGAGCAGAAGAAGACTGCTGCGGCTCCCGCTGCCGGCAAGAAGGAGGCTGCTCCCTCGGCTGCCAAGCCAGCTGCCGCTG"
read_3  <- "CAGCACGGACTGGGGCTTCTTGCCGGCGAGGACCTTCTTCTTGGCATCCTTGCTCTTGGCCTTGGCGGCCGCGGTCGTCTTTACGGCCGCGGGCTTCTTGGCAGCAGCACCGGCGGTCGCTGGC"
```

Question 1. what species are these sequences from?

Drosophila melanogaster

Question 2. Put all three of these reads into a single object (a vector).  What class will the vector `reads` be? Check to make sure! How many characters are in each read (and why does `length()` not give you what you want.. try...)

```{r}
reads <- c(read_1, read_2, read_3)
class(reads)
length(reads)
```

class is character
length gives 3-- giving us the number of elements rather than number of characers in each element

Question 3. Say we wanted to print each character (not the full string) from read_1, how do we do this using a for loop? You may wish to look at a function like `strsplit()` to accomplish this (there are other ways.)


Replace the blanks.
```{r}
read_1_split <- strsplit(read_1, split = NULL, fixed = T)
read = 0
for (read in read_1_split) {
  print(read)
}

class(read_1_split)

```

Question 4. What kind of object does this return? How might we make it a character vector again?

read_1_split is a list. We can use unlist() 
```{r}
unlist(read_1_split) -> vector_read_1_split
class(vector_read_1_split)

for (i in vector_read_1_split){
  print(i)
}
```

Question 5. How about if we wanted the number of occurrences of each base? Or better yet, their frequencies? You could write a loop, but I suggest looking at the help for the `table()` function... Also keep in mind that for for most objects `length()` tells you how many elements there are in a vector. For lists use `lengths()` (so you can either do this on a character vector or a list, your choice)
```{r}
table(read_1_split) -> table_1
print(table_1)
freq = table_1/lengths(read_1_split) #will recycle vector of shorter length
print(freq)
```

Question 6. How would you make this into a nice looking function that can work on either  a list or vectors of characters? (Still just for a single read)
```{r}
frequency = function(x) {
  if (class(x) == "character") {
    x <- list(x)
    table(x) -> table_1
    print(table_1)
    freq = table_1/lengths(x)
    print(freq)
  } else {
    table(x) -> table_1
    print(table_1)
    freq = table_1/lengths(x)
    print(freq)
  }
}
frequency(vector_read_1_split)

```

Question 7. Now how can you modify your approach to do it for an arbitrary numbers of reads? You could use a loop or use one of the apply like functions (which one)?


Question 8. Can you revise your function so that it can handle the input of either a string as a single multicharacter vector, **or** a vector of individual characters **or** a list? Try it out with the vector of three sequence reads (`reads`).  

```{r}
frequency = function(x) {
  if (length(x) == 1 & class(x) == "character") {
    x <- list(x)
    table(x) -> table_1
    
    freq = table_1/lengths(x)
    
  } 
  if (mode(x) == "list"){
    table(x) -> table_1
    
    freq = table_1/lengths(x)
    
  } else {
    table(x) -> table_1
    
    freq = table_1/lengths(x)
    
  }
}
frequency(reads)
print(freq)

basefreq = sapply(reads, frequency, USE.NAMES = F)
print(basefreq, digits = 2)
```
