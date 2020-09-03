#pacote geobr, feito pelo ibge
library(geobr)
library(ggplot2)
install.packages("readxl")
library(readxl)
library(dplyr)
library(RColorBrewer)
install.packages("ggspatial")
library(ggspatial)

#função acessa os dados municipais de todos os mun do bra
PiMun<-read_municipality(code_muni= 'PI')
Pi<- read_state(code_state = "PI")

#plotar com o codigo do municipio
ggplot(PiMun)+geom_sf(
  aes(fill=code_muni))


setwd('C:/Users/extra/Documents/R/parte1/')
dados<-read_excel('atlas2013_dadosbrutos_pt.xlsx',sheet=2) %>%
  filter(ANO=="2010" & UF==22)%>% select(Codmun7,IDHM)%>% rename(code_muni=Codmun7)

unir<-inner_join(PiMun,dados,by="code_muni")

ggplot(unir)+geom_sf(
  aes(fill=IDHM,col=IDHM))+
    scale_color_gradientn(colours = c("red","white","blue"))+ 
      scale_fill_gradientn(colours = c("red","white","blue"))
#forma 3 com paletas de cores.
ggplot(unir)+geom_sf(
  aes(fill=IDHM,col=IDHM))+
  geom_sf(data= Pi, fill= 'transparent')+
  scale_color_gradientn(colours = brewer.pal(9,'Spectral'))+ 
  scale_fill_gradientn(colours = brewer.pal(9,'Spectral'))+theme_minimal()+
  annotation_scale(location='bl')+
  annotation_north_arrow(location='tl',
                         style= north_arrow_nautical(),
                         width = unit(2,'cm'),
                         height = unit(2,'cm'))+
  ggtitle("IDHM do estado do Piauí do ano de 2010") + 
  theme(plot.title = element_text(hjust = 0.5,size=28))
 
         
  
  





