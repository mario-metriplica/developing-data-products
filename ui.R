library(shiny) 
library(devtools) 
library(leaflet)
library(ggplot2)


shinyUI(fluidPage( 
  headerPanel(list(HTML('<img src="airplane.png"/ height="100" width="100" > '),HTML('<img src="rstudio.png"/ height="90" width="100" align = "right"> ') )),
  titlePanel("OpenFlights Airports"),
  tags$head(tags$style(
    HTML('
         #sidebar {
         background-color: #58D3F7;
         color: #000000;
         }
         
         body, label, input, button, select {
         font-family: "Arial";
         }')
  )),
  sidebarLayout(
    sidebarPanel(id="sidebar",
                 sliderInput("slider1", label = "Select number of clusters", min = 1, 
                             max = 5, value = 5),
                 selectInput("country", "Select a country to plot:",
                             c("Afghanistan"  ,                    "Albania",                          "Algeria",                         
                             "American Samoa",                   "Angola"  ,                         "Anguilla"  ,                      
                             "Antarctica" ,                      "Antigua and Barbuda" ,             "Argentina",                       
                             "Armenia" ,                         "Aruba"    ,                        "Australia" ,                      
                             "Austria" ,                         "Azerbaijan" ,                      "Bahamas" ,                        
                             "Bahrain" ,                         "Bangladesh" ,                      "Barbados" ,                       
                             "Belarus" ,                         "Belgium"   ,                       "Belize" ,                         
                             "Benin"  ,                          "Bermuda" ,                         "Bhutan"    ,                      
                             "Bolivia" ,                         "Bosnia and Herzegovina",           "Botswana"   ,                     
                             "Brazil" ,                          "British Indian Ocean Territory",   "British Virgin Islands" ,         
                             "Brunei" ,                          "Bulgaria"  ,                       "Burkina Faso"  ,                  
                             "Burma" ,                           "Burundi" ,                         "Cambodia"   ,                     
                             "Cameroon" ,                        "Canada"  ,                         "Cape Verde"  ,                    
                             "Cayman Islands" ,                  "Central African Republic",         "Chad"      ,                      
                             "Chile"    ,                        "China"     ,                       "Christmas Island"  ,              
                             "Cocos (Keeling) Islands",          "Colombia"  ,                       "Comoros"    ,                     
                             "Congo (Brazzaville)",              "Congo (Kinshasa)" ,                "Cook Islands",                    
                             "Costa Rica"  ,                     "Cote d'Ivoire" ,                   "Croatia"     ,                    
                             "Cuba",                             "Cyprus"     ,                      "Czech Republic"  ,                
                             "Denmark" ,                         "Djibouti"   ,                      "Dominica"  ,                      
                             "Dominican Republic" ,              "East Timor"  ,                     "Ecuador"  ,                       
                             "Egypt",                            "El Salvador"  ,                    "Equatorial Guinea"   ,            
                             "Eritrea"  ,                        "Estonia"     ,                     "Ethiopia"  ,                      
                              "Falkland Islands",                 "Faroe Islands"   ,                 "Fiji"    ,                        
                              "Finland" ,                         "France" ,                          "French Guiana"  ,                 
                             "French Polynesia" ,                "Gabon"  ,                          "Gambia" ,                         
                             "Georgia" ,                         "Germany" ,                         "Ghana"  ,                         
                             "Gibraltar"  ,                      "Greece" ,                          "Greenland"  ,                     
                             "Grenada",                          "Guadeloupe" ,                      "Guam"  ,                          
                             "Guatemala",                        "Guernsey",                         "Guinea" ,                         
                            "Guinea-Bissau",                    "Guyana" ,                          "Haiti"  ,                         
                              "Honduras"  ,                       "Hong Kong" ,                       "Hungary" ,                        
                             "Iceland" ,                         "India",                            "Indonesia"  ,                     
                             "Iran"  ,                           "Iraq"  ,                           "Ireland" ,                        
                             "Isle of Man" ,                     "Israel"  ,                         "Italy"  ,                         
                              "Jamaica"  ,                        "Japan"  ,                          "Jersey" ,                         
                              "Johnston Atoll",                   "Jordan" ,                          "Kazakhstan"    ,                  
                              "Kenya",                            "Kiribati" ,                        "Korea" ,                          
                             "Kuwait" ,                          "Kyrgyzstan" ,                      "Laos"   ,                         
                              "Latvia",                           "Lebanon" ,                         "Lesotho" ,                        
                              "Liberia" ,                         "Libya"  ,                          "Lithuania",                       
                              "Luxembourg",                       "Macau" ,                           "Macedonia" ,                      
                              "Madagascar",                       "Malawi" ,                          "Malaysia"  ,                      
                              "Maldives" ,                        "Mali" ,                            "Malta"  ,                         
                             "Marshall Islands" ,                "Martinique" ,                      "Mauritania"   ,                   
                              "Mauritius" ,                       "Mayotte"   ,                       "Mexico" ,                         
                             "Micronesia" ,                      "Midway Islands" ,                  "Moldova" ,                        
                             "Monaco" ,                          "Mongolia" ,                        "Montenegro",                      
                             "Montserrat"  ,                     "Morocco" ,                         "Mozambique"  ,                    
                              "Myanmar" ,                         "Namibia"  ,                        "Nauru"      ,                     
                             "Nepal"  ,                          "Netherlands" ,                     "Netherlands Antilles"  ,          
                              "New Caledonia" ,                   "New Zealand" ,                     "Nicaragua"   ,                    
                              "Niger"   ,                         "Nigeria"   ,                       "Niue"       ,                     
                              "Norfolk Island"  ,                 "North Korea"  ,                    "Northern Mariana Islands" ,       
                              "Norway"  ,                         "Oman" ,                            "Pakistan",                        
                              "Palau"    ,                        "Palestine"  ,                      "Panama" ,                         
                              "Papua New Guinea" ,                "Paraguay"  ,                       "Peru"   ,                         
                              "Philippines",                      "Poland"  ,                         "Portugal" ,                       
                              "Puerto Rico"  ,                    "Qatar" ,                           "Reunion" ,                        
                              "Romania"   ,                       "Russia" ,                          "Rwanda" ,                         
                              "Saint Helena" ,                    "Saint Kitts and Nevis",            "Saint Lucia"  ,                   
                              "Saint Pierre and Miquelon" ,       "Saint Vincent and the Grenadines", "Samoa"   ,                        
                              "Sao Tome and Principe"  ,          "Saudi Arabia" ,                    "Senegal"   ,                      
                              "Serbia"    ,                       "Seychelles" ,                      "Sierra Leone"  ,                  
                              "Singapore"  ,                      "Slovakia" ,                        "Slovenia" ,                       
                              "Solomon Islands"   ,               "Somalia" ,                         "South Africa"  ,                  
                              "South Georgia and the Islands",    "South Korea" ,                    "South Sudan"    ,                 
                              "Spain" ,                           "Sri Lanka" ,                       "Sudan"   ,                        
                             "Suriname" ,                        "Svalbard"  ,                       "Swaziland"   ,                    
                              "Sweden" ,                          "Switzerland" ,                     "Syria" ,                          
                              "Taiwan" ,                          "Tajikistan",                       "Tanzania"  ,                      
                              "Thailand" ,                        "Togo"   ,                          "Tonga" ,                          
                              "Trinidad and Tobago",              "Tunisia"    ,                      "Turkey" ,                         
                              "Turkmenistan",                     "Turks and Caicos Islands" ,        "Tuvalu" ,                         
                              "Uganda",                           "Ukraine"      ,                    "United Arab Emirates" ,           
                              "United Kingdom",                   "United States"  ,                  "Uruguay" ,                        
                             "Uzbekistan",                       "Vanuatu"     ,                     "Venezuela" ,                      
                              "Vietnam",                          "Virgin Islands",                   "Wake Island",                     
                              "Wallis and Futuna",                "West Bank" ,                       "Western Sahara",                  
                              "Yemen",                            "Zambia",                           "Zimbabwe")),
                 br(),
                 actionButton("update", "Go!"),
                 p("Click Go! to refresh inputs"),
                 br(),
                 conditionalPanel(condition="$('html').hasClass('shiny-busy')",
                                  tags$div("Please wait a moment",id="loadmessage"))
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Introduction",h5(textOutput("intro")), h5(textOutput("intro2")),h5(textOutput("intro3"))),      
        tabPanel("Data Summary",dataTableOutput("table")),      
        tabPanel("Clusters Summary",h5(textOutput("text")), plotOutput("plotcluster")),
        tabPanel("Leaflet", leafletOutput("mymap"))
      ) 
    )
  )
    )
  )
