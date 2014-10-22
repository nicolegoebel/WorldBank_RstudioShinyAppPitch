library(shiny)
library(httpuv)
#install.packages("rWBclimate")
library(rWBclimate)
library(ggplot2)
#library(rCharts)
#library(ggplot2)
suppressPackageStartupMessages(library(googleVis))

# get data from API
# get temperature data for ensembles
st=1900
en=2100
world <- c(NoAm_country, SoAm_country, Eur_country, Asia_country, Africa_country, Oceana_country)
world<-world[! world %in% c("UMI")]  #remove "UMI"
world <- c("USA")
options(kmlpath = "/Users/nicolegoebel/Dropbox/Courses/Coursera_Data_Science_2014/DevelopingDataProducts/tempPredict_oneplot")
world_map_df <- create_map_df(world)
world_dat <- get_ensemble_temp(world, "annualavg", start=st, end=en)
world_dat$data <- as.numeric(as.character(world_dat$data))
world_dat<-subset(world_dat,world_dat$percentile==50) #subset to median percentile
world_dat$years=paste(world_dat$fromYear,world_dat$toYear, sep="-")
world_dat<-subset(world_dat, select=-c(percentile, fromYear, toYear))

shinyServer(function(input, output){

  yr1<-reactive({switch(
    input$scen1,
    "past" = input$yearspred1a,
    "a2" = input$yearspred1b,
    "b1" = input$yearspred1c)})

  output$add1 <- renderText({paste("Temperature prediction for years ", yr1(), " and ", input$scen1, " scenario") })
 
  output$plot1<- renderPlot({
    dfyr1<-subset(world_dat, world_dat$scenario==input$scen1)
    df1 <- subset(dfyr1, dfyr1$years==yr1())
    climate_map(world_map_df,df1,return_map = T) + scale_fill_gradient2(name="Temperature",limits=c(-20, 34), low="blue", mid="white", high = "red", space="rgb", guide="colourbar") 
  })
})