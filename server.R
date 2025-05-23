library(dplyr)
library(xlsx)
library(DT)
library(tools)
library(stringr)
library(highcharter)
library(shiny)
library(webshot2)
library(cowplot)
library(magick )
library(ggplot2)
library(tseries)  
library(moments)
library(plotly)
library(stats)
library(shinythemes)
library(purrr)
library(cluster)
library(rJava)



options(shiny.maxRequestSize=200*1024^2)
rm(list = ls())

shinyServer(function(input, output, session) {
  
  
  
  options(warn =-1)
  source("./server_1Téléchargement.R",local=T)
  source("./server_2Univarié.R",local=T)
  source("./server_3ScatterPlot.R",local=T)
  source("./server_4BoxPlotBivarié.R",local=T)
  source("./server_5BarBivarié.R",local=T)
  source("./server_8MultiBoxPlot.R", local = T)
  source("./server_9Methode_SAS.R", local = T)
  source("./server_10Methode_stratification.R", local = T)
 

  
  
})
