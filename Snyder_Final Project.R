## ----- Script Metadata -----
##
## Script name: CompSkills Final Project 
##
## Purpose of script: Employing data reduction techniques and plotting skills to analyze data from a paper in a new light
##
## Author: Augustus M. Snyder
##
## Date Created: 2022-12-8
##
## Copyright (c) Augustus M. Snyder
## Email: amsnyder7@alaska.edu

## ----- Notes -----

## Recent updates: First iteration of script


## ----- Setting Working Directory -----

setwd("C:/Users/augus/Desktop/UAF/F694 - Computational Skills")


## ----- Loading Required Packages -----

require(tidyverse)
library("corrplot")
library("patchwork")

# source("functions/packages.R")  # Haven't created a "functions/packages.R" script yet, but hypothetically loads up all the packages we need

## ----- Loading in data -----
PKD_trout <- read.delim("./Bruneaux et al. 2017/dataset-dryad-bruneaux-2016-FE.tsv")
View(PKD_trout)

## ----- Summarizing data -----
PKD_Trout_summary1 = PKD_trout %>% group_by(origin, month) %>% summarize(n = n(),
                                                                                mn_len = mean(length),
                                                                                sd_len = sd(length),
                                                                                mn_mass = mean(mass),
                                                                                sd_mass = sd(mass),
                                                                                mn_KB_ratio = mean(KB_ratio),
                                                                                sd_KB = sd(KB_ratio),
                                                                                mn_AS_std = mean(AS_std),
                                                                                sd_As_std = sd(AS_std),
                                                                                mn_UTT = mean(UTT_degree_sec),
                                                                                sd_UTT = sd(UTT_degree_sec))

View(PKD_Trout_summary1) # Summarizes data for all fish samples. Note the problem with NAs for AS and UTT

PKD_Trout_summary_AS = PKD_trout %>% filter(!is.na(AS_std)) %>% group_by(origin, month) %>% summarize(n = n(),
                                                                                                           mn_len = mean(length),
                                                                                                           sd_len = sd(length),
                                                                                                           mn_mass = mean(mass),
                                                                                                           sd_mass = sd(mass),
                                                                                                           mn_KB_ratio = mean(KB_ratio),
                                                                                                           sd_KB = sd(KB_ratio),
                                                                                                           mn_AS_std = mean(AS_std),
                                                                                                           sd_As_std = sd(AS_std),
                                                                                                      )
View(PKD_Trout_summary_AS) # Summarizes data for just the fish with aerobic scope measurements. Looking at As and UTT separately.

PKD_Trout_summary_UTT = PKD_trout %>% filter(!is.na(UTT_degree_sec)) %>% group_by(origin, month) %>% summarize(n = n(),
                                                                                                       mn_len = mean(length),
                                                                                                       sd_len = sd(length),
                                                                                                       mn_mass = mean(mass),
                                                                                                       sd_mass = sd(mass),
                                                                                                       mn_KB_ratio = mean(KB_ratio),
                                                                                                       sd_KB = sd(KB_ratio),
                                                                                                       mn_UTT = mean(UTT_degree_sec),
                                                                                                       sd_UTT = sd(UTT_degree_sec))

View(PKD_Trout_summary_UTT)

# Counting NAs per column -- about half don't have SMR / MMR / AS, about a third don't have immune cell counts. Unfortunately, it's almost directly opposite, such that fish with AS measurements don't have lymphocyte measurements, and vice versa
na_count <-sapply(PKD_CTmax_salmon, function(y) sum(length(which(is.na(y))))) # I believe "y" refers to the columns
View(as.data.frame(na_count))

## ----- Subsetting data -----

PKD_trout_subset = PKD_trout %>% select(-c(fish_id, month, qPCR_sqrt, body_depth, kidney_depth)) # initial subset
View(PKD_trout_subset)

PKD_trout_AS_subset = PKD_trout_subset[,c(1:6,27)] %>% na.omit() # subset which focuses on Aerobic scope
View(PKD_trout_AS_subset)

PKD_trout_UTT_subset = PKD_trout_subset[,c(1:6,31)] %>% na.omit()
View(PKD_trout_UTT_subset)

## ----- Testing for multicolinearity -----
PKD_AS_cor = cor(PKD_trout_AS_subset[,-1]) # Aerobic scope
View(PKD_AS_cor)

PKD_UTT_cor = cor(PKD_trout_UTT_subset[,-1]) # UTT
View(PKD_UTT_cor)

# Saving Aerobic scope corrplot
file_path= "PKD_AS_cor.png"
png(height=1800, width=1800, file=file_path)
corrplot(PKD_AS_cor,  # Aerobic scope data correlation matrix
         method = "ellipse",
         tl.cex = 3,
         cl.cex = 3)
dev.off()

corrplot(PKD_UTT_cor, method = "ellipse") # UTT

## ----- Data reduction via PCA -----

PKD_AS_pca <- prcomp(PKD_trout_AS_subset[,-1], center = T, scale. = T) # Aerobic scope
PKD_UTT_pca <- prcomp(PKD_trout_UTT_subset[,-1], center = T, scale. = T) # UTT

## ----- AS PCA Plot -----

View(PKD_AS_pca$rotation)
View(PKD_AS_pca$x)
summary(PKD_AS_pca)

# Redoing plot using base R:
opar <- par(no.readonly = TRUE)
par(pty = "s",
    cex.main = 1.2,
    cex.lab = 1,
    lab = c(5,5,2),
    mar = c(6,4,7,4),
    font.main =2,
    font.lab = 2,
    family = "sans",
    col.main = "gray10",
    col.lab = "gray10",
    fg = "gray10",
    las = 1)

plot.new()

plot.window(
  xlim = c(-10,10), 
  ylim = c(-10,10), 
  asp = 1)

axis(side = 1, labels = T, lwd = 1.5)
axis(side = 2, labels = T, lwd = 1.5)
axis(side = 3, labels = F, lwd = 1.5, tck = -0.02)
axis(side = 4, labels = F, lwd = 1.5, tck = -0.02)
axis(side = 1, labels = T, lwd = 1.5, tck = 0.02)
axis(side = 2, labels = T, lwd = 1.5, tck = 0.02)
axis(side = 3, labels = F, lwd = 1.5, tck = 0.02)
axis(side = 4, labels = F, lwd = 1.5, tck = 0.02)

points(x = PKD_AS_pca$x[,1:2],
       pch = 21, col = "black", bg = "cornflowerblue")

title(
  xlab = "PC1 (38.9%)", ylab = "PC2 (26.1%)")

title(main = "Aerobic Scope PCA",
      line = 4
)


box(lwd = 1.5)
abline(h=0, lty=2)
abline(v=0, lty=2)

# adding vector arrows for factors on top of PCA plot
par(new = T, las =1)
plot.window(xlim = c(-1,1),
            ylim = c(-1,1),
            asp = 1)
axis(side = 3,
     at = c(-1,0.5, 0, -0.5, 1),
     labels = T,
     col = "burlywood4",
     col.ticks = "burlywood4",
     lwd = 2,
     col.axis = "burlywood4")
axis(side = 4,
     at = c(-1,0.5, 0, -0.5, 1),
     labels = T,
     col = "burlywood4",
     col.ticks = "burlywood4",
     lwd = 2,
     col.axis = "burlywood4")

mtext((text = "PC1 rotations"),
      side = 3,
      cex = 1,
      font = 2,
      family = "sans",
      col = "burlywood4",
      line = 2.5)
mtext((text = "PC2 rotations"),
      side = 4,
      cex = 1,
      font = 2,
      family = "sans",
      col = "burlywood4",
      line = 2.5,
      las = 3)

box()
abline(v=0, h=0, lty =2, col = "grey25")

arrows(x0 = 0, x1 = PKD_AS_pca$rotation[,1],
       y0 = 0, y1 = PKD_AS_pca$rotation [,2],
       col = "bisque3",
       length = 0.08,
       lwd = 2,
       angle = 30)

text(PKD_AS_pca$rotation[,1], y = PKD_AS_pca$rotation [,2],
     labels = row.names(PKD_AS_pca$rotation),
     cex = 0.8,
     font = 1,
     col = "gray10",
     pos = c(1,1,1,2,1,1))

## with ggplot:
PKD_AS_PC_df = as.data.frame(PKD_AS_pca$x)
View(PKD_AS_PC_df)
p2 = ggplot(data = PKD_AS_PC_df, aes(x = PC1, y = PC2, fill = as.factor(PKD_trout_AS_subset$origin))) +
  geom_point(size = 2, shape = 21) +
  xlab("PC1 (38.9%)") + 
  ylab("PC2 (26.1%)") +
  labs(title = "Aerobic Scope PCA") +
  scale_fill_viridis_d(name = "Origin") + 
  geom_vline(xintercept = 0, lty = 2) +
  geom_hline(yintercept = 0, lty = 2)+
  theme_bw(base_size = 14) + 
  theme(axis.title = element_text(face = "bold"),
        legend.title = element_text(face = "bold"),
        plot.title = element_text(face = "bold")) + 
  theme(plot.title = element_text(hjust = 0.5))


 p3 = ggplot(data = NULL) +
   scale_x_continuous(limits = c(-2, 4)) +
   scale_y_continuous(limits = c(-4, 0.5)) +
   labs(title = "PCA Rotations") +
   geom_segment(data = as.data.frame(PKD_AS_pca$rotation),
               aes(x = 0, y = 0, xend = PC1 * 4, yend = PC2 * 4, color = "red"), 
               arrow = arrow(length = unit(0.3, "cm")), show.legend = F) + 
   geom_text(data = as.data.frame(PKD_AS_pca$rotation), 
             aes(x = PC1*4, y = PC2*4, label = rownames(PKD_AS_pca$rotation))) + 
   theme_bw(base_size = 14) + 
   xlab("PC1 Rotation * 4") + 
   ylab("PC2 Rotation * 4") +
   theme(axis.title = element_text(face = "bold"), plot.title = element_text(face = "bold"))+
   theme(plot.title = element_text(hjust = 0.5))
 
 p4 = p1 + p2
 p4
ggsave("Aerobic_Scope_PCA.png", plot = last_plot(), dpi = 300, width = 20, height = 20, units = "cm")
