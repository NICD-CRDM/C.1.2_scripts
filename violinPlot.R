library(ggplot2)
library(ape)
library(repr)
library("readxl")
library('gridExtra')
#library(tidyverse)
library(dplyr)
library(hrbrthemes)
library(ggpubr)
library(cowplot)
library(ggthemes)
library(viridis)
library(ggrepel)
library("ggsci")
library(ggalt)
library("Hmisc")
library("scales")

require(tidyverse)
library("readxl")
library("lubridate")
require("ggalt")
library("wesanderson")


dataB.1.1.7<-read_excel('B.1.1.7_spike_mutations_quantification.xlsx')
dataC.1<-read_excel('C.1_spike_mutations_quantification.xlsx')

dataC.1.2<-read_excel('C.1.2_spike_mutations_quantification.xlsx')
dataP.1<-read_excel('P.1_spike_mutations_quantification.xlsx')
dataDelta<-read_excel('Delta_spike_mutations_quantification.xlsx')
dataZA.cluster<-read_excel('501Y.V2_n344_spike_mutations_quantification.xlsx')

dataKappa<-read_excel('Kappa_n210_spike_mutations_quantification.xlsx')
dataEta<-read_excel('Eta_n189_spike_mutations_quantification.xlsx')
dataIota<-read_excel('Iota_n315_spike_mutations_quantification.xlsx')
dataLambda<-read_excel('Lambda_n154_spike_mutations_quantification.xlsx')
dataMu<-read_excel('Mu_n585_spike_mutations_quantification.xlsx')

data_all<-rbind(dataDelta,dataC.1,dataZA.cluster,dataB.1.1.7,dataP.1,dataC.1.2,
                dataKappa,dataEta,dataIota,dataLambda,dataMu)


p_ac_whole <- ggplot(data=data_all, aes(Lineage, totalAminoacidSubstitutions, fill=Lineage))+
  geom_violin(size=0.2)+
  stat_summary(size=0.4,fun.data = "mean_sdl",  fun.args = list(mult = 1),geom = "pointrange", color = "black" )+
  stat_summary(fun.y=mean, geom="text", show_guide = FALSE, size=3,angle=90,fontface='bold',
               aes(color=Lineage, label=round(..y.., digits=1),y = stage(totalAminoacidSubstitutions, after_stat = 43)))+
  scale_fill_manual(values=c('#4A83E9','#4750E4','grey30','#5E1D9D','#71C3AD','#D7D452','#59ABD4','#FFA33D','#8FD286','#FF6C34','#F82D28'), name='Lineages')+
  scale_color_manual(values=c('#4A83E9','#4750E4','grey30','#5E1D9D','#71C3AD','#D7D452','#59ABD4','#FFA33D','#8FD286','#FF6C34','#F82D28'), name='Lineages')+
  xlab('')+ ylab('Amino Acid substitutions')+ggtitle("Whole Genome")+
  #scale_x_discrete(labels= c('B.1.1.54', 'B.1.1.56', 'C.1', '501Y.V2'))+
  ylim(0,45)+
  theme_bw()+
  theme(legend.position="none",axis.text.x = element_text(size=10,angle=45, hjust=1),axis.text.y = element_text(size=10))

p_ac_whole

p_ac_spike <- ggplot(data=data_all, aes(Lineage, Num_spike_mutations, fill=Lineage))+
  geom_violin(size=0.2)+
  stat_summary(size=0.2,fun.data = "mean_sdl",  fun.args = list(mult = 1),geom = "pointrange", color = "black" )+
  stat_summary(fun.y=mean, geom="text", show_guide = FALSE, size=3,angle=90,fontface='bold',
               aes(color=Lineage, label=round(..y.., digits=1),y = stage(Num_spike_mutations, after_stat = 18)))+
  scale_fill_manual(values=c('#4A83E9','#4750E4','grey30','#5E1D9D','#71C3AD','#D7D452','#59ABD4','#FFA33D','#8FD286','#FF6C34','#F82D28'), name='Lineages')+
  scale_color_manual(values=c('#4A83E9','#4750E4','grey30','#5E1D9D','#71C3AD','#D7D452','#59ABD4','#FFA33D','#8FD286','#FF6C34','#F82D28'), name='Lineages')+
  
  xlab('')+ ylab('')+ggtitle("Spike")+
  #scale_x_discrete(labels= c('B.1.1.54', 'B.1.1.56', 'C.1', '501Y.V2'))+
  theme_bw()+
  ylim(0,20)+
  theme(legend.position="none", axis.text.x = element_text(size=10,angle=45, hjust=1),axis.text.y = element_text(size=10))

p_ac_spike


plot_grid(p_ac_whole,p_ac_spike, ncol=2)


library("readxl")
library(lubridate)
library("scales")
library(ggplot2)


ggplotRegression <- function(fit){
  
  
  
  ggplot(fit$model, aes_string(x = names(fit$model)[2], y = names(fit$model)[1])) + 
    geom_point() +
    stat_smooth(method = "lm", col = "red") +
    labs(title = paste("Adj R2 = ",signif(summary(fit)$adj.r.squared, 5),
                       #"Intercept =",signif(fit$coef[[1]],5 ),
                       "R = ",signif(summary(fit)$coef, 5),
                       " Slope =",signif(fit$coef[[2]], 5),
                       " P =",signif(summary(fit)$coef[2,4], 5)))
}

#Panel A - tempest plots
#Note: Same code for all 4 plots, just substitute the data file for the required cluster
#Further edits can be done in power point or illustrator

tempest_data<-read_excel('C.1.2_global_tempest.xlsx')
tempest_data$date2<-date_decimal(tempest_data$date)

tempest_data$date2<-as.Date(cut(tempest_data$date2,
                                breaks = "day",
                                start.on.monday = FALSE))
custom2<-c("tan4",'antiquewhite2','darkolivegreen',
           'red3','plum2',
           'purple3','dodgerblue1','slategray1', 'white')

custom3<-c("tan4",'antiquewhite2',
           'red3','plum2',
           'purple3','dodgerblue1','slategray1', 'white')

custom4<-c("tan4",'plum2',
           'dodgerblue1')

custom1<-c('plum2',
           'slategray1', 'white')


ggplotRegression(lm(distance ~ date2, data = tempest_data))


p_tempest<-ggplot(tempest_data, aes(date2,distance))+
  geom_point(data=subset(tempest_data,country=='South Africa'),color='black',size=2.5,aes(fill='South Africa'),shape=21, stroke=0.5,color='#5E1D9D')+
  geom_point(data=subset(tempest_data,country!='South Africa'),size=2.5,aes(fill='Other'),shape=21, stroke=0.5,color='#5E1D9D')+
  
  geom_smooth(method=lm,se=T, color='black')+
  theme_bw()+
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  theme(axis.text=element_text(size=10))+
  theme(axis.text.x =element_text(size=10))+
  theme(axis.title=element_text(size=10))+
  scale_x_date(date_labels = "%b\n%Y",breaks='month')+
  scale_fill_manual(values=c('white','#5E1D9D'), name='Location')+
  ylab("Average per site genetic\ndivergence from root")+
  xlab("Date")+
  scale_y_continuous(labels = scientific)+
  annotate(geom="text", x=as.Date("2021/04/15"),y=0.0014,label="r = 0.43",
           color="black",size=3)+
  annotate(geom="text", x=as.Date("2021/04/15"),y=0.00125,label="r2 = 0.18",
           color="black",size=3)+
  annotate(geom="text", x=as.Date("2021/04/15"),y=0.0011,label="Slope = 3.04E-3",
           color="black",size=3)+
  ggtitle('C.1.2 Molecular Clock')

p_tempest



