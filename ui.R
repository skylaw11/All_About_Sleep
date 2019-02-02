#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
#This App will give you a summary of sleep data. There are 2 datasets available to view, sleep in students
#and sleep in mammals. You can compare each parameters for each datasets to see trends in Sleep patterns. 
#Below are the data columns present for each data sets.

#Student's Sleep Data: Data which show the effect of two soporific drugs
#(increase in hours of sleep compared to control) on 10 patients.
#COLUMNS:
#[, 1]	extra	numeric	increase in hours of sleep
#[, 2]	group	factor	drug given
#[, 3]	ID	factor	patient ID


#Mamal's Sleep: This data set includes data for 39 species of mammals distributed over 13 orders. 
#The data were used for analyzing the relationship between constitutional and ecological factors and 
#sleeping in mammals. Two qualitatively different sleep variables (dreaming and non dreaming) were recorded. 
#Constitutional variables such as life span, body weight, brain weight and gestation time were evaluated. 
#Ecological variables such as severity of predation, safety of sleeping place and overall danger were 
#inferred from field observations in the literature.
#COLUMNS:
#[, 1]Species:Species of mammals
#[, 2]BodyWt:Total body weight of the mammal (in kg)
#[, 3]BrainWt:Brain weight of the mammal (in kg)
#[, 4]NonDreaming:Number of hours of non dreaming sleep
#[, 5]Dreaming:Number of hours of dreaming sleep
#[, 6]TotalSleep:Total number of hours of sleep
#[, 7]LifeSpan:Life span (in years)
#[, 8]Gestation:Gestation time (in days)
#[, 9]Predation:An index of how likely the mammal is to be preyed upon. 
  #1 = least likely to be preyed upon. 5 = most likely to be preyed upon.
#[, 10]Exposure:An index of the how exposed the mammal is during sleep. 
  #1 = least exposed (e.g., sleeps in a well-protected den). 5 = most exposed.
#[, 11]Danger:An index of how much danger the mammal faces from other animals. 
  #This index is based upon Predation and Exposure. 1 = least danger from other animals. 
  #5 = most danger from other animals.


#Library Initialization
library(shiny)
library(ggplot2)
library(purrr)
library(dplyr)
require(stats)
c <- "No Data Available"


#Upload Data Sets
data(sleep)
data(msleep)


#plotting theme for ggplot2
.theme<- theme(
  axis.line = element_line(colour = 'gray', size = .75),
  panel.background = element_blank(),
  plot.background = element_blank()
)

pageWithSidebar(
  # title
  headerPanel("ALL ABOUT SLEEP!"),
  
  
  #input
  sidebarPanel
  ( h3("Coursera Course Project: Developing Data Products"),
    h4("Instructions:"),
    h5("Choose any of the 2 datasets available"),
    h5("sleep: Student's Sleep Data"),
    h5("msleep: Sleep in Mammals Data"),
    h3("Select Options:"),
    # Input: Select what to display
    selectInput("dataset","Data:",
                choices =list(sleep = "sleep",msleep = "msleep"), selected=NULL),
    selectInput("variable","Variable:", choices = NULL),
    selectInput("group","Group:", choices = NULL),
    selectInput("plot.type","Plot Type:",
                list(boxplot = "boxplot",density = "density")
    ),
    checkboxInput("show.points", "show points", TRUE),
    h4("Extra Computations:"),
    checkboxInput("show.ttest","show T-Test for Student's Sleep Data",FALSE),
    textOutput("id1")
    
  ),
  
  # output
  mainPanel(
    h3(textOutput("caption")),
    uiOutput("plot") # depends on input
  )
)



