# This plots a map of the world coloured by number of C.1.2 genomes detected
# Genome numbers must be manually input on line 21
# The figure is further edited in software such as Inkscape

setwd('./Desktop/NICD_work/scripts/geography')

library(maptools)
library(ggplot2)
library(tidyverse)
library("sf")
library(rnaturalearth)
library(rnaturalearthdata)
library(tmap)
library(sf)

# TODO: automate file reading.

# genomes detected - currently manually input
genomes <- data.frame(country = c("South Africa", "United Kingdom", "New Zealand", "China", "Switzerland", 
                                  "Mauritius", "Democratic Republic of the Congo", "Portugal", "Botswana",
                                  "Zimbabwe", "Swaziland"),
                      genome_count = c(226, 4, 1, 1, 2, 1, 1, 1, 1, 1, 7)
)

# world map
world <- ne_countries(scale = "medium", returnclass = "sf")
# add genome counts
world.joined <- left_join(world, genomes, by = c('admin' = 'country'))
# allow plotting
world.joined <- fortify(world.joined, region = "admin")
genome_data <- genomes$genome_count
# colour scale
colors <- (genome_data - min(genome_data)) / (max(genome_data) - min(genome_data))*254+1
palette = colorRampPalette(c('#7adcff', '#076BB6'))(255)[colors]
palette = c("white", palette)

# create plot
worldpopmap <- ggplot() +
  geom_sf(data = world.joined, size=0.1, aes(fill = ifelse(genome_count<=10, genome_count, 10)))+
  scale_fill_gradient(low = '#CAB0DE', high = '#5E1D9D', name = "Number of C.1.2 genomes detected", 
                      limits=c(0,10), breaks=c(0,2,4,6,8,10), labels=c('0','2','4','6','8','10'), 
                      na.value='white') +
  labs(fill = "Number of C.1.2 genomes") +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        #panel.background = element_rect(fill = "transparent"),  # uncomment for transparent background
        legend.position = 'right')+
        guides(size=guide_legend(direction='vertical'))

# save plot
#png('worldmap.png', units='in', width=6, height=4, res=800)
#plot(worldpopmap)
#dev.off()

pdf('world_map_C.1.2.pdf')
plot(worldpopmap)
dev.off()

# plot MT separately so can magnify on world map
mt <- world.joined[world.joined$admin == 'Mauritius',]
mt.map <- ggplot() +
  geom_sf(data = mt, size=0.5, aes(fill = ifelse(genome_count<=10, genome_count, 10)))+
  scale_fill_gradient(low = '#CAB0DE', high = '#5E1D9D', name = "Number of C.1.2 genomes detected", 
                      limits=c(0,10), breaks=c(0,2,4,6,8,10), labels=c('0','2','4','6', '8','10'), 
                      na.value='white') +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        legend.position = 'none')
        #panel.background = element_rect(fill = "transparent"),

# save plot
pdf('MT.pdf')
plot(mt.map)
dev.off()
