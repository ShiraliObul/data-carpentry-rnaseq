# Analysis of RNAseq data

Authors: Hugo Tavares, Georg Zeller

These are extra materials used as a complement to 
[Data Carpentry in R](http://www.datacarpentry.org/R-ecology-lesson/) 
courses, and thus assume that some of those lessons were covered beforehand. 

These lessons are under active development and may change over time:

* [Introduction](01_rnaseq_intro.html)
* [Basic exploratory analysis](02_rnaseq_exploratory.html)
to understand some properties of these expression data
* [Explore transcriptome-wide changes](03_rnaseq_pca.html)
induced by the stress treatment and genotype
* [Explore patterns of expression]()
for a subset of potentially interesting genes (**lesson under development**)


### Important note

There are many dedicated packages to deal with RNAseq data, mostly 
within the [Bioconductor](https://bioconductor.org/) package repository. 

**This lesson is not about analysing RNAseq data** (that would be a topic for a whole 
course!), but rather to show you how the data manipulation principles learned 
so far can be applied to explore these kind of data. 

If you are doing RNAseq analysis, you should use 
[dedicated packages and workflows](https://www.bioconductor.org/help/workflows/rnaseqGene/), 
which implement models to account for particular features of these data.

If you are interested, you can see [how the data for this lesson was pre-processed]() 
using the `DESeq2` package.

