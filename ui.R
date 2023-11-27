fluidPage(
  
  titlePanel(h3(strong("WEB-CBS Uygulaması"))),
  
  sidebarLayout(
    sidebarPanel(
      width = 2,
      
      fluidRow(
        column(
          12,
          h5(strong("Deprem Yoğunluk Haritası Ayarları")),
          selectInput("sel_basemap","Altlık Harita Seç:",choices = leaflet::providers),
          sliderInput("sel_mag","Deprem Büyüklüğü:",min(data_earth$mag), max(data_earth$mag),value=5, step = 0.5),
          sliderInput("sel_blur","Isı Haritası Bulanıklık Değeri:",value=25,min=1,max=100),
          sliderInput("sel_max","Maksimum Nokta Yoğunluğu:",value=1,min=1, max=100),
          sliderInput("sel_rad","Noktaların Açısal Değeri:",value=25,min=1,max=50,step=5),
          hr(),
          h5(strong("Şehirlere Ait ÖZellikler")),
          colourInput("sel_col", "Poligon Renk:", "#FFFFFF",allowTransparent = TRUE,closeOnClick = TRUE),
          sliderInput("sel_weight","Poligon Çizgi Kalınlığı:",value=1,min=1,max=5,step = 0.5),
          sliderInput("sel_opacity","Poligon Şeffaflığı:",value=1,min=0,max=1,step = 0.1),
          sliderInput("sel_fillopacity","Poligon Dolgu Şeffaflığı:",value=0,min=0,max=100,step=5),
          hr(),
          fluidRow(
            column(6,bsButton("updateButton", 
                              "Harita Çiz",
                              style = "success",
                              block = TRUE)),
            column(6,bsButton("resetButton",
                              "Sıfırla!",
                              style = "danger",
                              block = TRUE))
          )
          
          ))
      #,fluidRow(column(12,h4("Raster veri ayarları")))
      ),
    
    mainPanel(
      tags$head(tags$style(HTML(".sep {width: 20px;height:1px;float: left;}"))),
      width=10,
      fluidRow(
        column(7,
               style='border: 1.5px solid gray; padding:0px; margin:0px;',
               leafletOutput("map",width="100%", height="620px")),
        column(5,
               style='border: 1.5px solid gray; padding:0px; margin:0px;',
               br(),
               plotlyOutput("map_statistic",width="100%", height="600px"))
      ),
      
      br(),
      
      fluidRow(
        column(12,
               style='border: 1.5px solid gray; padding:0px; margin:0px;',
               dataTableOutput("data_dt",width="100%"))
        ),
      br()
    )
  )
)