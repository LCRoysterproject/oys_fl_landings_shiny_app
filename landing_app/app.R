library("shiny")
library("ggplot2")
library("tidyverse")
library("shinythemes")
library("rsconnect")


#rsconnect::setAccountInfo(name='oysterprojectck',
#                          token='F16D04C1548412A5806A896A22342C97',
#                          secret='QoYg+iiKNQ8wysd6UfA18M4Y3YHortTMsTJT84eo')



data<- read.csv ("data/data.csv", header=T)

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("yeti"),
              
              
   # Application title

   titlePanel("Landings Area"),

   
   sidebarLayout(
      sidebarPanel(
        
        h4("Help text"),
        helpText("Please note that the y-axis on the comparison", 
                 "landings plots will differ, to allow for a better",
                 "representation of trends."),
        
        selectInput("area1", label= h4("Apalachicola"), 
                    choices=c("Apalach Landings", "Apalach Trips", "Apalach Per Trips" ), selected = "Apalach Landings"),
        
        selectInput("area2", label= h4("State"), 
                    choices=c("State Landings", "State Trips","State Per Trips", "No Area" ), selected= "State Landings"),
        
        selectInput("area3", label= h4("Suwannee"), 
                    choices=c("Suwannee Landings", "Suwannee Trips", "Suwannee per Trips", "No Area" ), selected= "Suwannee Landings")
      ),
  
      
      # Show a plot of the generated distribution
      mainPanel(
        width = 8,
        #h2("Comparison Figures"),
        plotOutput("plot",height = "600px")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  plotInput <- reactive({
    
      data <- data %>% 
        filter(area == input$area1|area == input$area2|area == input$area3)
    
      
    ggplot(data=data, aes(x= Year, y= measurement)) +
      labs(x= "Year", y="Pounds")+
      geom_point( size=2)+
      geom_line(linetype = "dashed")+
      scale_x_continuous(limits=c(1986,2018), breaks=c(1986,1990,1994,1998,2002,2006,2010,2014,2018)) +
    theme(panel.border = element_rect(color = "black", size = 0.5, fill = NA, linetype="solid"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.text=element_text(size=15),
          axis.title=element_text(size=15,face="bold"),
          plot.title =element_text(size=20, face='bold'),
          axis.text.x = element_text(angle = 90, hjust = 1),
          strip.text = element_text(face="bold", size=15)) +
      facet_wrap(~area, ncol=1, scales="free_y")
    
    
   })
  
  output$plot <-renderPlot({
    plotInput()
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

