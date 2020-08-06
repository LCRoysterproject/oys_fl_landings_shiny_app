library("shiny")
library("ggplot2")
library("tidyverse")
library("shinythemes")
library("rsconnect")


#Download latest county landings information from:
#https://public.myfwc.com/FWRI/PFDM/ReportCreator.aspx

#Use the script create_landings_data.R to create the data file for this Shiny App


all_landings<- read.csv ("data/landings_data.csv", header=T)

all_landings$area<- as.character(all_landings$area)

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("yeti"),
        

   titlePanel("Commercial Oyster Landings"),
   
   width = 4,
   
   sidebarLayout(
      sidebarPanel(
        
        h4("Landings Data"),
        helpText("Data are available at the FWC Commerical 
                 Landings website 
                 (https://public.myfwc.com/FWRI
                 /PFDM/ReportCreator.aspx)."),
      
        
        sliderInput("year_range", label = h4("Year Range"), min = 1986, 
                    max = 2020, value = c(2015, 2020), sep = "", step= 1),
      
        helpText("Select the Year Range by moving the slider button."),   
      
selectInput("area1", label = h4("Area"), 
            choices=c(unique(all_landings$area) %>% sort()), selected = "Apalachicola"),

selectInput("area2", label = h4("Comparison Area"), 
            choices=c(unique(all_landings$area) %>% sort()), selected = "Suwannee Sound"),

helpText("Apalachicola region includes Franklin and Wukulla counties.
         Suwannee Sound region includes Taylor, Dixie, and Levy counties.")),

  
      
      # Show a plot of the generated distribution
      mainPanel(
        width = 8,
        #h2("Comparison Figures"),
        plotOutput("plot",height = "600px"),
        downloadButton(outputId = "download_plot", label = "Download this figure")

      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output,  plotInput) {
  
  plotInput <- reactive({
    
      data <- all_landings %>% 
        filter(area == input$area1 | area == input$area2) %>% 
        filter(Year >= input$year_range[1] ,
               Year <= input$year_range[2]) %>% 
        select(area, Year, value, measurement)
    
      data$value<- factor(data$value,levels=c ("Landings (lbs)", "Total Trips", "CPUE"))
      
      breaks<- 1986:2020
      
    landings_plot<- ggplot(data=data, aes(x= as.numeric(Year), 
                          y= as.numeric(measurement), linetype = as.factor(area))) +
      labs(x= "Year")+
      ylab("") +
      geom_path(size= 1.2) +
      geom_point(size=3) +
      labs(linetype= "Area") +
      scale_x_continuous(breaks = breaks) +
      scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
    theme(legend.position = "top",
      panel.border = element_rect(color = "black", size = 0.5, fill = NA, linetype="solid"),
          panel.background = element_blank(),
          panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(),
          axis.text=element_text(size=15),
          axis.title=element_text(size=15,face="bold"),
          plot.title =element_text(size=20, face='bold'),
          axis.text.x = element_text(angle = 90, hjust = 1),
          strip.text = element_text(face="bold", size=15),
      legend.title=element_text(size=13), 
      legend.text=element_text(size=13)) +
      facet_wrap(~value, ncol=1, scales="free")
    
    landings_plot
   })
  
  output$plot <-renderPlot({
    plotInput()
    
  })
  
  output$download_plot <- downloadHandler(
    filename = function() {
      "plot.jpeg"
    },
    content = function(file) {
      ggsave(file, plotInput(), width = 10, height = 13)
    }
  )
}

# Run the application 
shinyApp(ui = ui, server = server)

