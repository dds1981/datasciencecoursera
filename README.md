---
title: "README"
author: "Doug Smith"
date: "June 21, 2015"
output: html_document
---

Getting & Cleaning Data Course Project
===================

**Description of run_analysis.R Script**

run_analysis R* generates a tidy data set through a series of steps:

- Set Up Environment
- Download files and load them into R
- Combine Test and Train Data Files 
- Extract the Mean and Standard Deviation (std) Variable Columns
- Add the Activity Labels
- Create the Final Tidy Data Set
- Write the Tidy Data to a Text File

Set Up Environment
- Install and load the relevant packages for the analysis (dplyr, reshape2, tidyr)
- Delete all variables and values from the environment (rm(list=ls())

*(WARNING -- YOU MAY WANT TO COMMENT OUT THIS SECTION BEFORE RUNNING THE SCRIPT)*

Download Files and Load Them into R
- Import Test Data
- Import Train Data

Combine Test and Train Data Files
- Combine Test and Train Data
- Import Features and Add as Column Labels

Extract the Mean and Standard Deviation (std) Variable Columns
- Create indices using gsub() to identify column labels with mean() and std()
- Extract the Columns with Mean and Standard Deviation Values  (dplyr select command)

*I'm sure there's a more elegant method -- perhaps using chaining (>%>)*

Add the Activity Labels
- Import Activities and Remove Punctuation from Activity Labels using gsub()
- Create a Factor of the Activity Labels
- Convert the Numbers into Plain Language Variables

*Credit to Course TA David Hood for the as.character(factor()) approach*


Create the Final Tidy Data Set
- Reshaped the HAR Data using melt_frame and dcast (Week 3 Lecture 4)

*Credit to classmate Lachlan Brown for his method in the discussion forums*
https://class.coursera.org/getdata-015/forum/thread?thread_id=219#post-1019

Write the Tidy Data to a Text File


