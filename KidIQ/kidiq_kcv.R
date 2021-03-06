#' ---
#' title: "Regression and Other Stories: KidIQ cross-validation"
#' author: "Andrew Gelman, Jennifer Hill, Aki Vehtari"
#' date: "`r format(Sys.Date())`"
#' output:
#'   html_document:
#'     theme: readable
#'     toc: true
#'     toc_depth: 2
#'     toc_float: true
#'     code_download: true
#' ---

#' Linear regression and K-fold cross-validation. See Chapter 11 in
#' Regression and Other Stories.
#' 
#' -------------
#' 

#+ setup, include=FALSE
knitr::opts_chunk$set(message=FALSE, error=FALSE, warning=FALSE, comment=NA)

#' #### Load packages
library("rprojroot")
root<-has_file(".ROS-Examples-root")$make_fix_file()
library("rstanarm")
library("foreign")
# for reproducability
SEED <- 1507

#' #### Load children's test scores data
kidiq <- read.csv(root("KidIQ/data","kidiq.csv"))
head(kidiq)

#' #### Bayesian regression with the original predictors
stan_fit_3 <- stan_glm(kid_score ~ mom_hs + mom_iq, data=kidiq,
                       seed=SEED, refresh = 0)
print(stan_fit_3)

#' #### Leave-one-out cross-validation
loo3 <- loo(stan_fit_3)
loo3

#' #### K-fold cross-validation
kcv3 <- kfold(stan_fit_3)
kcv3
