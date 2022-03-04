#install.packages('maptools')
#install.packages('rgeos')

# map tutorial at https://www.worldfullofdata.com/r-tutorial-plot-maps-shapefiles/

setwd('./Desktop/NICD_work/scripts/geography')

library(maptools)
library(ggplot2)
library(tidyverse)

file <- './ZAF_shp/gadm36_ZAF_1.shp'  # GADM allows shapefiles to be used in publications (https://gadm.org/license.html)

shp <- rgdal::readOGR(file)

genomes <- data.frame(province = c("Gauteng", "KwaZulu-Natal", "Western Cape", "Eastern Cape", "Limpopo", "Mpumalanga", "North West", "Free State", "Northern Cape"),
                      genome_count = c(73, 10, 5, 3, 19, 7, 4, 10, 15)
)

# Merge with shapefile
shp@data <- merge(x=shp@data, y=genomes, by.x=c("NAME_1"), by.y=c("province"))

# Assign colors to provinces based on number of genomes
genome_data <- shp@data$genome_count
colors <- (genome_data - min(genome_data)) / (max(genome_data) - min(genome_data))*254+1
shp@data$color =  colorRampPalette(c('#ffffff', '#5E1D9D'))(255)[colors]

# basic polygon
ggplot_southafrica <- ggplot(shp, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "#ffffff") +
  geom_path(color = "black", size=0.1) +
  coord_equal() #+
theme(axis.title.x=element_blank(),
      axis.text.x = element_blank(),
      axis.title.y=element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      panel.grid.major = element_blank(), # get rid of major grid
      panel.grid.minor = element_blank() # get rid of minor grid
)

# Plot map and legend with colors
shp@data <- shp@data[order(shp@data$GID_1),] 
shapefile_data <- fortify(shp, region = "NAME_1")  # required for plotting
shapefile_data <- merge(shapefile_data, shp@data[, c('NAME_1', 'genome_count')], by.x='id', by.y='NAME_1', all.x=TRUE)
ggplot_southafrica <- ggplot_southafrica +
  # account for areas where count is higher than shared maximum with ifelse - if one province so high that it obscures legend
  geom_polygon(aes(fill = ifelse(shapefile_data$genome_count<=80, shapefile_data$genome_count, 80))) +
  geom_path(color = "black", size=0.3) + #theme_void() +
  scale_fill_gradient(low = '#ffffff', high = '#5E1D9D', name = "Number of C.1.2 genomes detected", 
                      limits=c(0,80), breaks=c(0,20,40,60,80), labels=c('0','20','40','60','>=80'), 
                      na.value='white') +
  labs(fill = "Number of C.1.2 genomes") +
  theme(axis.title.x=element_blank(),
        axis.text.x = element_blank(),
        axis.title.y=element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        panel.grid.major = element_blank(), # get rid of major grid
        panel.grid.minor = element_blank(), # get rid of minor grid
        #panel.background = element_rect(fill = "transparent"),
        legend.position = 'right')+
  guides(size=guide_legend(direction='vertical'))

pdf('ZA_map_C.1.2.pdf')
plot(ggplot_southafrica)
dev.off()
