#install.packages('maptools')
#install.packages('rgeos')

setwd('./Desktop/NICD_work/scripts/geography')

library(maptools)
library(ggplot2)
library(tidyverse)
library("sf")
library(rnaturalearth)
library(rnaturalearthdata)
library(tmap)
library(sf)

# genomes detected
genomes <- data.frame(country = c("South Africa", "United Kingdom", "New Zealand", "China", "Switzerland", 
                                  "Mauritius", "Democratic Republic of the Congo", "Portugal", "Botswana",
                                  "Zimbabwe", "Swaziland"),
                      genome_count = c(146, 4, 1, 1, 2, 1, 1, 1, 1, 1, 7)
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
palette = colorRampPalette(c('#5E1D9D', '#faf5ff'))(255)[colors]
palette = c("white", palette)

# create plot
worldpopmap <- ggplot() +
  geom_sf(data = world.joined, size=0.1, aes(fill = ifelse(genome_count<=10, genome_count, 10)))+
  scale_fill_gradient(low = '#ffffff', high = '#5E1D9D', name = "Number of C.1.2 genomes detected", 
                      limits=c(0,10), breaks=c(0,2,4,6,8,10), labels=c('0','2','4','6','8','10'), 
                      na.value='white') +
  labs(fill = "Number of C.1.2 genomes") +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        #panel.background = element_rect(fill = "transparent"),
        legend.position = 'right')+
  guides(size=guide_legend(direction='vertical'))
#guides(size=guide_legend(direction='vertical'))

# save plot
#png('worldmap.png', units='in', width=6, height=4, res=800)
#plot(worldpopmap)
#dev.off()

pdf('world_map_C.1.2.pdf')
plot(worldpopmap)
dev.off()


mt <- world.joined[world.joined$admin == 'Mauritius',]
mt.map <- ggplot() +
  geom_sf(data = mt, size=0.5, aes(fill = ifelse(genome_count<=10, genome_count, 10)))+
  scale_fill_gradient(low = '#ffffff', high = '#5E1D9D', name = "Number of C.1.2 genomes detected", 
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
