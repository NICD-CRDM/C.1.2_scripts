# This plots a map of South Africa coloured by number of C.1.2 genomes detected
# Genome numbers must be manually input on line 21
# The figure is further edited in software such as Inkscape

# based on map tutorial at https://www.worldfullofdata.com/r-tutorial-plot-maps-shapefiles/

setwd('./Desktop/NICD_work/scripts/geography')

library(maptools)
library(ggplot2)
library(tidyverse)

# can get shape file from https://gadm.org/download  (South Africa shapefile)
file <- './ZAF_shp/gadm36_ZAF_1.shp'  

# Read data - had to change read-in method bc original in tutorial is deprecated
shp <- rgdal::readOGR(file)

# TODO: automate this as file read-in
# to get provinces w/no C.1.2 as white, remember to use NA instead of 0
genomes <- data.frame(province = c("Gauteng", "KwaZulu-Natal", "Western Cape", "Eastern Cape", "Limpopo", "Mpumalanga", "North West", "Free State", "Northern Cape"),
                         genome_count = c(73, 10, 5, 3, 19, 7, 4, 10, 15))
                        


# # Merge with shapefile
shp@data <- merge(x=shp@data, y=genomes, by.x=c("NAME_1"), by.y=c("province"))

# # Assign colors to provinces based on number of genomes
genome_data <- shp@data$genome_count
colors <- (genome_data - min(genome_data)) / (max(genome_data) - min(genome_data))*254+1
shp@data$color =  colorRampPalette(c('#f9f5fc', '#7322B5'))(255)[colors]

# 
ggplot_southafrica <- ggplot(shp, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "#ffffff") +
  geom_path(color = "black", size=0.1) +
  coord_equal() +
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
shapefile_data <- fortify(shp, region = "NAME_1")
shapefile_data <- merge(shapefile_data, shp@data[, c('NAME_1', 'genome_count')], by.x='id', by.y='NAME_1', all.x=TRUE)
ggplot_southafrica <- ggplot_southafrica +
  # account for areas where count is higher than shared maximum with ifelse
  geom_polygon(aes(fill = shapefile_data$genome_count)) +
  geom_path(color = "black", size=0.3) + 
  scale_fill_gradient(low = '#f9f5fc', high = '#7322B5', name = "Number of C.1.2 sequences", 
                      limits=c(0,80), breaks=c(0,20,40,60,80), labels=c('0','20','40','60','80'), 
                      na.value='white') +
  labs(fill = "Number of genomes") +
  theme(axis.title.x=element_blank(),
        axis.text.x = element_blank(),
        axis.title.y=element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        panel.grid.major = element_blank(), # get rid of major grid
        panel.grid.minor = element_blank(), # get rid of minor grid
        legend.position = 'right')+
        guides(size=guide_legend(direction='vertical'))

pdf('C.1.2_ZA.pdf')
plot(ggplot_southafrica)
dev.off()
