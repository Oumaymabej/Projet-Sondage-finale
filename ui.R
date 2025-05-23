
library(shiny)
library(shinyjs)
library(shinydashboard)
library(plotly)
library(DT)
library(xlsx)
library(evaluate)
library(shinycssloaders)
library(highcharter)
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
library(dashboardthemes)

dashboard_ui <-
  dashboardPage(dashboardHeader(
    title = div("Sondage", style = "font-size: 24px; font-weight: bold; padding-left: 10px;"),
                  tags$li(tags$script(),
                          class = "dropdown"),
                  
                  titleWidth = 250),
    
  # ***************************Dashboard Side Bar***************************
  dashboardSidebar(
    width = 250,
    sidebarMenu(id = "MenuTabs",
      menuItem(tags$span("Acceuil", style = "margin-left: 5px;"), tabName = "Acceuil", icon = icon("home")),
      menuItem(tags$span("Téléchargement", style = "margin-left: 2px;"), tabName = "Téléchargement", icon = icon("file")),
      menuItem(tags$span("Analyse univarié", style = "margin-left: 5px;"), tabName = "Univarié", icon = icon("bar-chart")),
      menuItem(tags$span("Diagramme de dispersion", style = "margin-left: 5px;"), tabName = "ScatterPlot", icon = icon("compass-drafting")),
      menuItem(tags$span("Diagramme en boîte bivarié", style = "margin-left: 5px;"), tabName = "BoxPlotBivarié", icon = icon("sliders")),
      menuItem(tags$span("Diagramme à barres groupées bivarié", style = "margin-left: 5px;"), tabName = "BarBivarié", icon = icon("bar-chart")),

      menuItem(tags$span("Diagramme en boîte multivarié", style = "margin-left: 5px;"), tabName = "MultiBoxPlot", icon = icon("sliders")),
      
      
      menuItem(tags$span("Méthode SAS", style = "margin-left: 5px;"), tabName = "SAS", icon = icon("sliders")),
      menuItem(tags$span("stratification", style = "margin-left: 5px;"), tabName = "stratification", icon = icon("sliders")),
      
      menuItem("Made by Oumayma Bejaoui", tabName = "madeBy", icon = icon("user-circle"))

      
      
    )
  ),
  # ***************************Dashboard Body***************************
  dashboardBody(
    tabItems(
      # ***************************Data Source***************************
      tabItem(tabName = "Acceuil",
              source("./ui_0Acceuil.R", local = T)[1]),
      # ***************************Data Source***************************
      tabItem(tabName = "Téléchargement",
              source("./ui_1Téléchargement.R", local = T)[1]),
      # ***************************Univariate Analysis***************************
      tabItem(tabName = "Univarié",
              source("./ui_2Univarié.R", local = T)[1]),
      # ***************************Bi Variate Scatter Plot***************************
      tabItem(tabName = "ScatterPlot",
              source("./ui_3ScatterPlot.R", local = T)[1]),
      # ***************************Bi Variate Box Plot***************************
      tabItem(tabName = "BoxPlotBivarié",
              source("./ui_4BoxPlotBivarié.R", local = T)[1]),
      # ***************************Bi Variate Group Bar Plot***************************
      tabItem(tabName = "BarBivarié",
              source("./ui_5BarBivarié.R", local = T)[1]),
      # ***************************Bi Variate Group Histogram***************************
      
      # ***************************Multi Variate Box Plot***************************
      tabItem(tabName = "MultiBoxPlot",
              source("./ui_8MultiBoxPlot.R", local = T)[1]),
      # ***************************Multi Variate Box Plot***************************
      tabItem(tabName = "SAS",
              source("./ui_9Methode_SAS.R", local = T)[1]),
      
      tabItem(tabName = "stratification",
              source("./ui_10Methode_stratification.R", local = T)[1]),
   
      tabItem(
        tabName = "madeBy",
        title = "Made by Oumayma Bejaoui",
        tags$a(href = "https://www.linkedin.com/in/oumayma-bejaoui-8a6398235/", "Oumayma Bejaoui's LinkedIn Profile")[1]
      )
      
    )
  ),shinyDashboardThemes(
    theme = "purple_gradient"
  )
  
)
ui <-dashboard_ui




