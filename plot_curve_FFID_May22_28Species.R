# library
library(data.table)
library(ggplot2)
library(reshape2)
library(tidyr)
library(dplyr)
library(readxl)
library(ggpubr)
library(scales)

# setwd("~/OneDrive - University of Salford/Lab stuff/1h. FastSharkID_May22/Script_R")

##################################################
### 28 Species
##################################################

#########################
## BS1
#########################

# import data BS1
BS1_train <- read_excel("../input_May22_Extra/BS1_TRAIN_28Species.xlsx", col_names=FALSE)

# transpose dataset
BS1_train_t <- transpose(BS1_train)

# give column name form first row
colnames(BS1_train_t) <- BS1_train_t[1, ]

#save rows names
Row_sampleTrain <- BS1_train_t[ ,1]
write.csv(Row_sampleTrain, "../plot_r/sampleTrain28Spec.csv")

# remove first row
BS1_train_t = BS1_train_t[-1, ]

# rename first column "Temperature" with "Species"
names(BS1_train_t)[1] <- "Species"

# Wide to Long pivot
BS1_train_Long <- BS1_train_t %>%
  pivot_longer(!Species, names_to = "Temperature", values_to = "Value")

# Load info about species groups
Add_info28Spec <- read_excel("../input_May22_Extra/Additional_info.xlsx", sheet="28Spec", col_names=TRUE)

#Add_infoAdd36Spec <- read_excel("../input_May22_Extra/Additional_info.xlsx", sheet="Adds36Spec", col_names=TRUE)

# rename column name "sci_name" to "Species"
names(Add_info28Spec)[1] <- "Species"

# Join 2 dataframe to add information
BS1_train_Join <- full_join(BS1_train_Long, Add_info28Spec, by = "Species")

# Change data type from character to numeric
BS1_train_Join$Value <- as.numeric(BS1_train_Join$Value)
BS1_train_Join$Temperature <- as.numeric(BS1_train_Join$Temperature)

# Round the value
# aes(x = round(Temperature, digits = 0), y = round(Value, digits = 2), color = Species)) +

# ### PLOTTING

# ## All
# Plot_BS1_All <- ggplot(BS1_train_Join, aes(x = Temperature, y = Value, color = Species)) +
#   geom_point(size = 0.1) +
#   theme(legend.position = "none") +
#   labs(title = "Melt Curve in Barcode Segment 1 (BS1)",
#        y = "Fluorescence (-dF/dT)", x = "") +
#   facet_wrap(~Species, ncol = 2) +
#   theme(text = element_text(family = "Arial")) +
#   theme(axis.text = element_text()) +
#   theme(axis.title = element_text()) +
#   theme(legend.position = "none") +
#   theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
#   theme(strip.text = flement_text(face = "italic"))
#   theme(plot.title = element_text(face = "italic"))
# Plot_BS1_All



# ggsave(file="../plot_r/Plot_BS1_All.jpg", plot=Plot_BS1_All, width=3.885, height=7.520)


# ## Sharks
# Plot_BS1_Sharks <- ggplot(subset(BS1_train_Join, Group %in% c("Shark")), aes(x = Temperature, y = Value, color = Species)) +
#   geom_point(size = 0.1) +
#   theme(legend.position = "none") +
#   labs(title = "Melt Curve in Barcode Segment 1 (BS1)",
#        y = "Fluorescence (-dF/dT)", x = "") +
#   facet_wrap(~Species, ncol = 2) +
#   theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0)))
# # Plot_BS1_Sharks

# ggsave(file="../plot_r/Plot_BS1_Sharks.jpg", plot=Plot_BS1_Sharks, width=3.885, height=7.520)

# ## Rays
# Plot_BS1_Rays <- ggplot(subset(BS1_train_Join, Group %in% c("Ray")), aes(x = Temperature, y = Value, color = Species)) +
#   geom_point(size = 0.1) +
#   theme(legend.position = "none") +
#   labs(title = "Melt Curve in Barcode Segment 1 (BS1)",
#        y = "Fluorescence (-dF/dT)", x = "") +
#   facet_wrap(~Species, ncol = 2) +
#   theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0)))
# # Plot_BS1_Rays

# ggsave(file="../plot_r/Plot_BS1_Rays.jpg", plot=Plot_BS1_Rays, width=3.885, height=7.520)

# # ## Alopias_superciliosus
# # Plot_BS1_A.superciliosus <- ggplot(subset(BS1_train_Join, Species %in% c("Alopias_superciliosus")), aes(x = Temperature, y = Value, color = Species)) +
# #   # geom_ribbon(aes(ymin = Value - 1, ymax = Value + 1), alpha=0.2, fill = "grey70") +
# #   geom_point(size = 0.1) +
# #   theme(legend.position = "none") +
# #   labs(title = "Melt Curve in Barcode Segment 1 (BS1)",
# #        y = "Fluorescence (-dF/dT)", x = "") +
# #   #  facet_wrap(~Species, ncol = 4) +
# #   #  xlim(50, 90) +
# #   #  ylim(0, 0.001) +
# #   theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0)))
# # # Plot_BS1_A.superciliosus
# # 
# # ggsave(file="../plot_r/Plot_BS1_A.superciliosus.jpg", plot=Plot_BS1_A.superciliosus, width=7.520, height=3.885)



#########################
## BS2
#########################

# import data BS2
BS2_train <- read_excel("../input_May22_Extra/BS2_TRAIN_28Species.xlsx", col_names=FALSE)

# transpose dataset
BS2_train_t <- transpose(BS2_train)

# give column name form first row
colnames(BS2_train_t) <- BS2_train_t[1, ]

#save rows names
# Row_sampleTrain <- BS2_train_t[ ,1]
# write.csv(Row_sampleTrain, "../plot_r/sampleTrain28Spec.csv")

# remove first row
BS2_train_t = BS2_train_t[-1, ]

# rename first column "Temperature" with "Species"
names(BS2_train_t)[1] <- "Species"

# Wide to Long pivot
BS2_train_Long <- BS2_train_t %>%
  pivot_longer(!Species, names_to = "Temperature", values_to = "Value")

# Load info about species groups
# Add_info28Spec <- read_excel("../input_May22_Extra/Additional_info.xlsx", sheet="28Spec", col_names=TRUE)

#Add_infoAdd36Spec <- read_excel("../input_May22_Extra/Additional_info.xlsx", sheet="Adds36Spec", col_names=TRUE)

# rename column name "sci_name" to "Species"
names(Add_info28Spec)[1] <- "Species"

# Join 2 dataframe to add information
BS2_train_Join <- full_join(BS2_train_Long, Add_info28Spec, by = "Species")

# Change data type from character to numeric
BS2_train_Join$Value <- as.numeric(BS2_train_Join$Value)
BS2_train_Join$Temperature <- as.numeric(BS2_train_Join$Temperature)


# ### PLOTTING

# ## All
# Plot_BS2_All <- ggplot(BS2_train_Join, aes(x = Temperature, y = Value, color = Species)) +
#   geom_point(size = 0.1) +
#   theme(legend.position = "none") +
#   labs(title = "Melt Curve in Barcode Segment 2 (BS2)",
#        y = "Fluorescence (-dF/dT)", x = "") +
#   facet_wrap(~Species, ncol = 2) +
#   theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0)))
# # Plot_BS2_All

# ggsave(file="../plot_r/Plot_BS2_All.jpg", plot=Plot_BS2_All, width=3.885, height=7.520)


# ## Sharks
# Plot_BS2_Sharks <- ggplot(subset(BS2_train_Join, Group %in% c("Shark")), aes(x = Temperature, y = Value, color = Species)) +
#   geom_point(size = 0.1) +
#   theme(legend.position = "none") +
#   labs(title = "Melt Curve in Barcode Segment 2 (BS2)",
#        y = "Fluorescence (-dF/dT)", x = "") +
#   facet_wrap(~Species, ncol = 2) +
#   theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0)))
# # Plot_BS2_Sharks

# ggsave(file="../plot_r/Plot_BS2_Sharks.jpg", plot=Plot_BS2_Sharks, width=3.885, height=7.520)

# ## Rays
# Plot_BS2_Rays <- ggplot(subset(BS2_train_Join, Group %in% c("Ray")), aes(x = Temperature, y = Value, color = Species)) +
#   geom_point(size = 0.1) +
#   theme(legend.position = "none") +
#   labs(title = "Melt Curve in Barcode Segment 2 (BS2)",
#        y = "Fluorescence (-dF/dT)", x = "") +
#   facet_wrap(~Species, ncol = 2) +
#   theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0)))
# # Plot_BS2_Rays

# ggsave(file="../plot_r/Plot_BS2_Rays.jpg", plot=Plot_BS2_Rays, width=3.885, height=7.520)

# # ## Alopias_superciliosus
# # Plot_BS2_A.superciliosus <- ggplot(subset(BS2_train_Join, Species %in% c("Alopias_superciliosus")), aes(x = Temperature, y = Value, color = Species)) +
# #   # geom_ribbon(aes(ymin = Value - 1, ymax = Value + 1), alpha=0.2, fill = "grey70") +
# #   geom_point(size = 0.1) +
# #   theme(legend.position = "none") +
# #   labs(title = "Melt Curve in Barcode Segment 1 (BS2)",
# #        y = "Fluorescence (-dF/dT)", x = "") +
# #   #  facet_wrap(~Species, ncol = 4) +
# #   #  xlim(50, 90) +
# #   #  ylim(0, 0.001) +
# #   theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0)))
# # # Plot_BS2_A.superciliosus
# # 
# # ggsave(file="../plot_r/Plot_BS2_A.superciliosus.jpg", plot=Plot_BS2_A.superciliosus, width=7.520, height=3.885)




# ##################################################
# ### ADD 36 Species
# ##################################################

# #########################
# ## BS1
# #########################

# # import data BS1
# BS1_train_Add <- read_excel("../input_May22_Extra/BS1_TRAIN_Add36Species.xlsx", col_names=FALSE)

# # transpose dataset
# BS1_train_Add_t <- transpose(BS1_train_Add)

# # give column name form first row
# colnames(BS1_train_Add_t) <- BS1_train_Add_t[1, ]

# #save rows names
# Row_sampleTrain_Add <- BS1_train_Add_t[ ,1]
# write.csv(Row_sampleTrain_Add, "../plot_r/sampleTrainAdd36Spec.csv")

# # remove first row
# BS1_train_Add_t = BS1_train_Add_t[-1, ]

# # rename first column "Temperature" with "Species"
# names(BS1_train_Add_t)[1] <- "Species"

# # Wide to Long pivot
# BS1_train_Add_Long <- BS1_train_Add_t %>%
#   pivot_longer(!Species, names_to = "Temperature", values_to = "Value")

# # Load info about species groups
# Add_infoAdd36Spec <- read_excel("../input_May22_Extra/Additional_info.xlsx", sheet="Adds36Spec", col_names=TRUE)

# # rename column name "sci_name" to "Species"
# names(Add_infoAdd36Spec)[1] <- "Species"

# # Join 2 dataframe to add information
# BS1_train_Add_Join <- full_join(BS1_train_Add_Long, Add_infoAdd36Spec, by = "Species")

# # Change data type from character to numeric
# BS1_train_Add_Join$Value <- as.numeric(BS1_train_Add_Join$Value)
# BS1_train_Add_Join$Temperature <- as.numeric(BS1_train_Add_Join$Temperature)


# #########################
# ## BS2
# #########################

# # import data BS2
# BS2_train_Add <- read_excel("../input_May22_Extra/BS2_TRAIN_Add36Species.xlsx", col_names=FALSE)

# # transpose dataset
# BS2_train_Add_t <- transpose(BS2_train_Add)

# # give column name form first row
# colnames(BS2_train_Add_t) <- BS2_train_Add_t[1, ]

# #save rows names
# # Row_sampleTrain_Add <- BS2_train_Add_t[ ,1]
# # write.csv(Row_sampleTrain_Add, "../plot_r/sampleTrainAdd36Spec.csv")

# # remove first row
# BS2_train_Add_t = BS2_train_Add_t[-1, ]

# # rename first column "Temperature" with "Species"
# names(BS2_train_Add_t)[1] <- "Species"

# # Wide to Long pivot
# BS2_train_Add_Long <- BS2_train_Add_t %>%
#   pivot_longer(!Species, names_to = "Temperature", values_to = "Value")

# # Load info about species groups
# Add_infoAdd36Spec <- read_excel("../input_May22_Extra/Additional_info.xlsx", sheet="Adds36Spec", col_names=TRUE)

# # rename column name "sci_name" to "Species"
# names(Add_infoAdd36Spec)[1] <- "Species"

# # Join 2 dataframe to add information
# BS2_train_Add_Join <- full_join(BS2_train_Add_Long, Add_infoAdd36Spec, by = "Species")

# # Change data type from character to numeric
# BS2_train_Add_Join$Value <- as.numeric(BS2_train_Add_Join$Value)
# BS2_train_Add_Join$Temperature <- as.numeric(BS2_train_Add_Join$Temperature)


# ##################################################
# ### 28 + ADD 36 Species
# ##################################################

# ###############
# ### ROW BINDING
# ###############

# #########
# ## BS1
# #########

# # Check dimention
# dim(BS1_train_Join)
# dim(BS1_train_Add_Join)

# COMBINING
# BS1_train_ALL <-bind_rows(BS1_train_Join, BS1_train_Add_Join)
BS1_train_ALL <- BS1_train_Join
head(BS1_train_ALL)
dim(BS1_train_ALL)

#########
## BS2
#########

# # Check dimention
# dim(BS2_train_Join)
# dim(BS2_train_Add_Join)

# COMBINING
# BS2_train_ALL <-bind_rows(BS2_train_Join, BS2_train_Add_Join)
BS2_train_ALL <- BS2_train_Join
head(BS2_train_ALL)
dim(BS2_train_ALL)


###############
### PLOTTING ALL
###############

#########
## BS1
#########

# SHARKS
Plot_BS1_ALL_Sharks <- ggplot(subset(BS1_train_ALL, Group %in% c("Shark")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 0.1) +
  theme(legend.position = "none") +
  labs(title = "Melt Curve in Barcode Segment 1 (BS1)",
       y = "-dF/dT", x = "") +
  facet_wrap(CITES_status~Species, ncol = 4) +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0)))
# Plot_BS1_ALL_Sharks

ggsave(file="../plot_r/Plot_BS1_ALL_Sharks.jpg", plot=Plot_BS1_ALL_Sharks, width=7.520, height=12)

# RAYS
Plot_BS1_ALL_Rays <- ggplot(subset(BS1_train_ALL, Group %in% c("Ray")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 0.1) +
  theme(legend.position = "none") +
  labs(title = "Melt Curve in Barcode Segment 1 (BS1)",
       y = "Fluorescence (-dF/dT)", x = "") +
  facet_wrap(CITES_status~Species, ncol = 4) +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0)))
# Plot_BS1_ALL_Rays

ggsave(file="../plot_r/Plot_BS1_ALL_Rays.jpg", plot=Plot_BS1_ALL_Rays, width=7.520, height=12)

#########
## BS2
#########

# SHARKS
Plot_BS2_ALL_Sharks <- ggplot(subset(BS2_train_ALL, Group %in% c("Shark")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 0.1) +
  theme(legend.position = "none") +
  labs(title = "Melt Curve in Barcode Segment 2 (BS2)",
       y = "Fluorescence (-dF/dT)", x = "") +
  facet_wrap(CITES_status~Species, ncol = 4) +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0)))
# Plot_BS2_ALL_Sharks

ggsave(file="../plot_r/Plot_BS2_ALL_Sharks.jpg", plot=Plot_BS2_ALL_Sharks, width=7.520, height=12)

# RAYS
Plot_BS2_ALL_Rays <- ggplot(subset(BS2_train_ALL, Group %in% c("Ray")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 0.1) +
  theme(legend.position = "none") +
  labs(title = "Melt Curve in Barcode Segment 2 (BS2)",
       y = "Fluorescence (-dF/dT)", x = "") +
  facet_wrap(CITES_status~Species, ncol = 4) +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0)))
# Plot_BS2_ALL_Rays

ggsave(file="../plot_r/Plot_BS2_ALL_Rays.jpg", plot=Plot_BS2_ALL_Rays, width=7.520, height=12)



# Combined
# BS1 Train
BS1_train_Add_Long
BS1_train_Add_Long_BS1 <- BS1_train_Add_Long %>% 
  mutate(BS = "BS1")
BS1_train_Add_Long_BS1

# BS2 Train
BS2_train_Add_Long
BS2_train_Add_Long_BS2 <- BS2_train_Add_Long %>% 
  mutate(BS = "BS2")
BS2_train_Add_Long_BS2

# Join
# Join 2 dataframe to add information
# Train_combine <- full_join(BS1_train_Add_Long_BS1, BS2_train_Add_Long_BS2, by = "Species")
# Train_combine <- full_join(BS1_train_Add_Long_BS1, BS2_train_Add_Long_BS2)
Train_combine <- rbind(BS1_train_Add_Long_BS1, BS2_train_Add_Long_BS2)
Train_combine

## PLOTTING by species
## NOT SUITABLE
## Eusphyra_blochii
Plot_Eusphyra_blochii <- ggplot(subset(Train_combine, Species %in% c("Eusphyra_blochii")), aes(x = Temperature, y = Value, color = BS)) +
  geom_point(size = 0.1) +
  theme(legend.position = "none") +
  labs(title = "Eusphyra_blochii",
       y = "Fluorescence (-dF/dT)", x = "Temperature") +
  facet_wrap(~BS, ncol = 2) +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0)))
# Plot_BS2_A.superciliosus

# Plot_Eusphyra_blochii

ggsave(file="../plot_r/Eusphyra_blochii.jpg", plot=Plot_Eusphyra_blochii, width=7.520, height=3.885)








## SCRAP
# BS1_Anoxypristis_cuspidata <- subset(BS1_train_Join, Species %in% c("Anoxypristis_cuspidata")) %>% mutate(STD = runif(length(Value),0,1))
# 
# Plot_BS1_Anoxypristis_cuspidata <- ggplot(BS1_Anoxypristis_cuspidata, aes(x = Temperature, y = Value, color = Species)) +
#   geom_ribbon(aes(ymin=Value+0.5, ymax=Value-0.5), alpha=0.1, fill = "green", 
#               color = "black", linetype = "dotted", group = BS1_Anoxypristis_cuspidata$Species) + 
#   geom_point(size = 0.1, color="#B11F1F") +
#   #geom_line(size = 0.1, color="#B11F1F") +
#   ylim(-0.06,0.02) +
#   labs(title = "Anoxypristis cuspidata",
#        y = "Fluorescence (-dF/dT)", x = "Temperature") +
#   theme_bw()+
#   theme(legend.position = "none") +
#   theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
#   theme(plot.title = element_text(face = "italic"))



### PLOTTING by species
## Alopias_pelagicus
# BS1
Plot_BS1_Alopias_pelagicus <- ggplot(subset(BS1_train_ALL, Species %in% c("Alopias_pelagicus")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Alopias_pelagicus",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Alopias_pelagicus.jpg", plot=Plot_BS1_Alopias_pelagicus, width=7.520, height=3.885)

# BS2
Plot_BS2_Alopias_pelagicus <- ggplot(subset(BS2_train_ALL, Species %in% c("Alopias_pelagicus")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Alopias_pelagicus",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))


ggsave(file="../plot_r/species/BS2_Alopias_pelagicus.jpg", plot=Plot_BS2_Alopias_pelagicus, width=7.520, height=3.885)

## Alopias_superciliosus
# BS1
Plot_BS1_Alopias_superciliosus <- ggplot(subset(BS1_train_ALL, Species %in% c("Alopias_superciliosus")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Alopias_superciliosus",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Alopias_superciliosus.jpg", plot=Plot_BS1_Alopias_superciliosus, width=7.520, height=3.885)

# BS2
Plot_BS2_Alopias_superciliosus <- ggplot(subset(BS2_train_ALL, Species %in% c("Alopias_superciliosus")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Alopias_superciliosus",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Alopias_superciliosus.jpg", plot=Plot_BS2_Alopias_superciliosus, width=7.520, height=3.885)

## Anoxypristis_cuspidata
# BS1
Plot_BS1_Anoxypristis_cuspidata <- ggplot(subset(BS1_train_ALL, Species %in% c("Anoxypristis_cuspidata")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Anoxypristis_cuspidata",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Anoxypristis_cuspidata.jpg", plot=Plot_BS1_Anoxypristis_cuspidata, width=7.520, height=3.885)

# BS2
Plot_BS2_Anoxypristis_cuspidata <- ggplot(subset(BS2_train_ALL, Species %in% c("Anoxypristis_cuspidata")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Anoxypristis_cuspidata",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Anoxypristis_cuspidata.jpg", plot=Plot_BS2_Anoxypristis_cuspidata, width=7.520, height=3.885)

## Carcharhinus_brevipinna
# BS1
Plot_BS1_Carcharhinus_brevipinna <- ggplot(subset(BS1_train_ALL, Species %in% c("Carcharhinus_brevipinna")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Carcharhinus_brevipinna",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Carcharhinus_brevipinna.jpg", plot=Plot_BS1_Carcharhinus_brevipinna, width=7.520, height=3.885)

# BS2
Plot_BS2_Carcharhinus_brevipinna <- ggplot(subset(BS2_train_ALL, Species %in% c("Carcharhinus_brevipinna")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Carcharhinus_brevipinna",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Carcharhinus_brevipinna.jpg", plot=Plot_BS2_Carcharhinus_brevipinna, width=7.520, height=3.885)

## Carcharhinus_falciformis
# BS1
Plot_BS1_Carcharhinus_falciformis <- ggplot(subset(BS1_train_ALL, Species %in% c("Carcharhinus_falciformis")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Carcharhinus_falciformis",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Carcharhinus_falciformis.jpg", plot=Plot_BS1_Carcharhinus_falciformis, width=7.520, height=3.885)

# BS2
Plot_BS2_Carcharhinus_falciformis <- ggplot(subset(BS2_train_ALL, Species %in% c("Carcharhinus_falciformis")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Carcharhinus_falciformis",
       y = "F-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Carcharhinus_falciformis.jpg", plot=Plot_BS2_Carcharhinus_falciformis, width=7.520, height=3.885)

## Carcharhinus_longimanus
# BS1
Plot_BS1_Carcharhinus_longimanus <- ggplot(subset(BS1_train_ALL, Species %in% c("Carcharhinus_longimanus")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Carcharhinus_longimanus",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Carcharhinus_longimanus.jpg", plot=Plot_BS1_Carcharhinus_longimanus, width=7.520, height=3.885)

# BS2
Plot_BS2_Carcharhinus_longimanus <- ggplot(subset(BS2_train_ALL, Species %in% c("Carcharhinus_longimanus")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Carcharhinus_longimanus",
       y = "F-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Carcharhinus_longimanus.jpg", plot=Plot_BS2_Carcharhinus_longimanus, width=7.520, height=3.885)

## Carcharhinus_sorrah
# BS1
Plot_BS1_Carcharhinus_sorrah <- ggplot(subset(BS1_train_ALL, Species %in% c("Carcharhinus_sorrah")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Carcharhinus_sorrah",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Carcharhinus_sorrah.jpg", plot=Plot_BS1_Carcharhinus_sorrah, width=7.520, height=3.885)

# BS2
Plot_BS2_Carcharhinus_sorrah <- ggplot(subset(BS2_train_ALL, Species %in% c("Carcharhinus_sorrah")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Carcharhinus_sorrah",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Carcharhinus_sorrah.jpg", plot=Plot_BS2_Carcharhinus_sorrah, width=7.520, height=3.885)

## Galeocerdo_cuvier
# BS1
Plot_BS1_Galeocerdo_cuvier <- ggplot(subset(BS1_train_ALL, Species %in% c("Galeocerdo_cuvier")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Galeocerdo_cuvier",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Galeocerdo_cuvier.jpg", plot=Plot_BS1_Galeocerdo_cuvier, width=7.520, height=3.885)

# BS2
Plot_BS2_Galeocerdo_cuvier <- ggplot(subset(BS2_train_ALL, Species %in% c("Galeocerdo_cuvier")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Galeocerdo_cuvier",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Galeocerdo_cuvier.jpg", plot=Plot_BS2_Galeocerdo_cuvier, width=7.520, height=3.885)

## Glaucostegus_typus
# BS1
Plot_BS1_Glaucostegus_typus <- ggplot(subset(BS1_train_ALL, Species %in% c("Glaucostegus_typus")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Glaucostegus_typus",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Glaucostegus_typus.jpg", plot=Plot_BS1_Glaucostegus_typus, width=7.520, height=3.885)

# BS2
Plot_BS2_Glaucostegus_typus <- ggplot(subset(BS2_train_ALL, Species %in% c("Glaucostegus_typus")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Glaucostegus_typus",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Glaucostegus_typus.jpg", plot=Plot_BS2_Glaucostegus_typus, width=7.520, height=3.885)

######################
######################
## Gymnura_poecilura
# BS1
Plot_BS1_Gymnura_poecilura <- ggplot(subset(BS1_train_ALL, Species %in% c("Gymnura_poecilura")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Gymnura_poecilura",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Gymnura_poecilura.jpg", plot=Plot_BS1_Gymnura_poecilura, width=7.520, height=3.885)

# BS2
Plot_BS2_Gymnura_poecilura <- ggplot(subset(BS2_train_ALL, Species %in% c("Gymnura_poecilura")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Gymnura_poecilura",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Gymnura_poecilura.jpg", plot=Plot_BS2_Gymnura_poecilura, width=7.520, height=3.885)

## Himantura_imbricata
# BS1
Plot_BS1_Himantura_imbricata <- ggplot(subset(BS1_train_ALL, Species %in% c("Himantura_imbricata")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Himantura_imbricata",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Himantura_imbricata.jpg", plot=Plot_BS1_Himantura_imbricata, width=7.520, height=3.885)

# BS2
Plot_BS2_Himantura_imbricata <- ggplot(subset(BS2_train_ALL, Species %in% c("Himantura_imbricata")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Himantura_imbricata",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Himantura_imbricata.jpg", plot=Plot_BS2_Himantura_imbricata, width=7.520, height=3.885)

## Isurus_oxyrinchus
# BS1
Plot_BS1_Isurus_oxyrinchus <- ggplot(subset(BS1_train_ALL, Species %in% c("Isurus_oxyrinchus")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Isurus_oxyrinchus",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Isurus_oxyrinchus.jpg", plot=Plot_BS1_Isurus_oxyrinchus, width=7.520, height=3.885)

# BS2
Plot_BS2_Isurus_oxyrinchus <- ggplot(subset(BS2_train_ALL, Species %in% c("Isurus_oxyrinchus")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Isurus_oxyrinchus",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Isurus_oxyrinchus.jpg", plot=Plot_BS2_Isurus_oxyrinchus, width=7.520, height=3.885)

## Isurus_paucus
# BS1
Plot_BS1_Isurus_paucus <- ggplot(subset(BS1_train_ALL, Species %in% c("Isurus_paucus")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Isurus_paucus",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Isurus_paucus.jpg", plot=Plot_BS1_Isurus_paucus, width=7.520, height=3.885)

# BS2
Plot_BS2_Isurus_paucus <- ggplot(subset(BS2_train_ALL, Species %in% c("Isurus_paucus")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Isurus_paucus",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Isurus_paucus.jpg", plot=Plot_BS2_Isurus_paucus, width=7.520, height=3.885)

## Lamna_nasus
# BS1
Plot_BS1_Lamna_nasus <- ggplot(subset(BS1_train_ALL, Species %in% c("Lamna_nasus")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Lamna_nasus",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Lamna_nasus.jpg", plot=Plot_BS1_Lamna_nasus, width=7.520, height=3.885)

# BS2
Plot_BS2_Lamna_nasus <- ggplot(subset(BS2_train_ALL, Species %in% c("Lamna_nasus")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Lamna_nasus",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Lamna_nasus.jpg", plot=Plot_BS2_Lamna_nasus, width=7.520, height=3.885)

## Mobula_birostris
# BS1
Plot_BS1_Mobula_birostris <- ggplot(subset(BS1_train_ALL, Species %in% c("Mobula_birostris")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Mobula_birostris",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Mobula_birostris.jpg", plot=Plot_BS1_Mobula_birostris, width=7.520, height=3.885)

# BS2
Plot_BS2_Mobula_birostris <- ggplot(subset(BS2_train_ALL, Species %in% c("Mobula_birostris")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Mobula_birostris",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Mobula_birostris.jpg", plot=Plot_BS2_Mobula_birostris, width=7.520, height=3.885)

## Mobula_mobular
# BS1
Plot_BS1_Mobula_mobular <- ggplot(subset(BS1_train_ALL, Species %in% c("Mobula_mobular")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Mobula_mobular",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Mobula_mobular.jpg", plot=Plot_BS1_Mobula_mobular, width=7.520, height=3.885)

# BS2
Plot_BS2_Mobula_mobular <- ggplot(subset(BS2_train_ALL, Species %in% c("Mobula_mobular")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Mobula_mobular",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Mobula_mobular.jpg", plot=Plot_BS2_Mobula_mobular, width=7.520, height=3.885)

## Mobula_tarapacana
# BS1
Plot_BS1_Mobula_tarapacana <- ggplot(subset(BS1_train_ALL, Species %in% c("Mobula_tarapacana")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Mobula_tarapacana",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Mobula_tarapacana.jpg", plot=Plot_BS1_Mobula_tarapacana, width=7.520, height=3.885)

# BS2
Plot_BS2_Mobula_tarapacana <- ggplot(subset(BS2_train_ALL, Species %in% c("Mobula_tarapacana")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Mobula_tarapacana",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Mobula_tarapacana.jpg", plot=Plot_BS2_Mobula_tarapacana, width=7.520, height=3.885)

## Neotrygon_orientalis
# BS1
Plot_BS1_Neotrygon_orientalis <- ggplot(subset(BS1_train_ALL, Species %in% c("Neotrygon_orientalis")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Neotrygon_orientalis",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Neotrygon_orientalis.jpg", plot=Plot_BS1_Neotrygon_orientalis, width=7.520, height=3.885)

# BS2
Plot_BS2_Neotrygon_orientalis <- ggplot(subset(BS2_train_ALL, Species %in% c("Neotrygon_orientalis")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Neotrygon_orientalis",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Neotrygon_orientalis.jpg", plot=Plot_BS2_Neotrygon_orientalis, width=7.520, height=3.885)

## Prionace_glauca
# BS1
Plot_BS1_Prionace_glauca <- ggplot(subset(BS1_train_ALL, Species %in% c("Prionace_glauca")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Prionace_glauca",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Prionace_glauca.jpg", plot=Plot_BS1_Prionace_glauca, width=7.520, height=3.885)

# BS2
Plot_BS2_Prionace_glauca <- ggplot(subset(BS2_train_ALL, Species %in% c("Prionace_glauca")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Prionace_glauca",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Prionace_glauca.jpg", plot=Plot_BS2_Prionace_glauca, width=7.520, height=3.885)

## Pristis_pristis
# BS1
Plot_BS1_Pristis_pristis <- ggplot(subset(BS1_train_ALL, Species %in% c("Pristis_pristis")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Pristis_pristis",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Pristis_pristis.jpg", plot=Plot_BS1_Pristis_pristis, width=7.520, height=3.885)

# BS2
Plot_BS2_Pristis_pristis <- ggplot(subset(BS2_train_ALL, Species %in% c("Pristis_pristis")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Pristis_pristis",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Pristis_pristis.jpg", plot=Plot_BS2_Pristis_pristis, width=7.520, height=3.885)

## Rhina_ancylostoma
# BS1
Plot_BS1_Rhina_ancylostoma <- ggplot(subset(BS1_train_ALL, Species %in% c("Rhina_ancylostoma")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Rhina_ancylostoma",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Rhina_ancylostoma.jpg", plot=Plot_BS1_Rhina_ancylostoma, width=7.520, height=3.885)

# BS2
Plot_BS2_Rhina_ancylostoma <- ggplot(subset(BS2_train_ALL, Species %in% c("Rhina_ancylostoma")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Rhina_ancylostoma",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Rhina_ancylostoma.jpg", plot=Plot_BS2_Rhina_ancylostoma, width=7.520, height=3.885)

## Rhynchobatus_australiae
# BS1
Plot_BS1_Rhynchobatus_australiae <- ggplot(subset(BS1_train_ALL, Species %in% c("Rhynchobatus_australiae")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Rhynchobatus_australiae",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Rhynchobatus_australiae.jpg", plot=Plot_BS1_Rhynchobatus_australiae, width=7.520, height=3.885)

# BS2
Plot_BS2_Rhynchobatus_australiae <- ggplot(subset(BS2_train_ALL, Species %in% c("Rhynchobatus_australiae")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Rhynchobatus_australiae",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Rhynchobatus_australiae.jpg", plot=Plot_BS2_Rhynchobatus_australiae, width=7.520, height=3.885)

## Rhynchobatus_laevis
# BS1
Plot_BS1_Rhynchobatus_laevis <- ggplot(subset(BS1_train_ALL, Species %in% c("Rhynchobatus_laevis")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Rhynchobatus_laevis",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Rhynchobatus_laevis.jpg", plot=Plot_BS1_Rhynchobatus_laevis, width=7.520, height=3.885)

# BS2
Plot_BS2_Rhynchobatus_laevis <- ggplot(subset(BS2_train_ALL, Species %in% c("Rhynchobatus_laevis")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Rhynchobatus_laevis",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Rhynchobatus_laevis.jpg", plot=Plot_BS2_Rhynchobatus_laevis, width=7.520, height=3.885)

## Rhynchobatus_springeri
# BS1
Plot_BS1_Rhynchobatus_springeri <- ggplot(subset(BS1_train_ALL, Species %in% c("Rhynchobatus_springeri")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Rhynchobatus_springeri",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Rhynchobatus_springeri.jpg", plot=Plot_BS1_Rhynchobatus_springeri, width=7.520, height=3.885)

# BS2
Plot_BS2_Rhynchobatus_springeri <- ggplot(subset(BS2_train_ALL, Species %in% c("Rhynchobatus_springeri")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Rhynchobatus_springeri",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Rhynchobatus_springeri.jpg", plot=Plot_BS2_Rhynchobatus_springeri, width=7.520, height=3.885)

## Sphyrna_lewini
# BS1
Plot_BS1_Sphyrna_lewini <- ggplot(subset(BS1_train_ALL, Species %in% c("Sphyrna_lewini")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Sphyrna_lewini",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Sphyrna_lewini.jpg", plot=Plot_BS1_Sphyrna_lewini, width=7.520, height=3.885)

# BS2
Plot_BS2_Sphyrna_lewini <- ggplot(subset(BS2_train_ALL, Species %in% c("Sphyrna_lewini")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Sphyrna_lewini",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Sphyrna_lewini.jpg", plot=Plot_BS2_Sphyrna_lewini, width=7.520, height=3.885)

## Sphyrna_mokarran
# BS1
Plot_BS1_Sphyrna_mokarran <- ggplot(subset(BS1_train_ALL, Species %in% c("Sphyrna_mokarran")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Sphyrna_mokarran",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Sphyrna_mokarran.jpg", plot=Plot_BS1_Sphyrna_mokarran, width=7.520, height=3.885)

# BS2
Plot_BS2_Sphyrna_mokarran <- ggplot(subset(BS2_train_ALL, Species %in% c("Sphyrna_mokarran")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Sphyrna_mokarran",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Sphyrna_mokarran.jpg", plot=Plot_BS2_Sphyrna_mokarran, width=7.520, height=3.885)

## Stegostoma_fasciatum
# BS1
Plot_BS1_Stegostoma_fasciatum <- ggplot(subset(BS1_train_ALL, Species %in% c("Stegostoma_fasciatum")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Stegostoma_fasciatum",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Stegostoma_fasciatum.jpg", plot=Plot_BS1_Stegostoma_fasciatum, width=7.520, height=3.885)

# BS2
Plot_BS2_Stegostoma_fasciatum <- ggplot(subset(BS2_train_ALL, Species %in% c("Stegostoma_fasciatum")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Stegostoma_fasciatum",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Stegostoma_fasciatum.jpg", plot=Plot_BS2_Stegostoma_fasciatum, width=7.520, height=3.885)

## Telatrygon_zugei
# BS1
Plot_BS1_Telatrygon_zugei <- ggplot(subset(BS1_train_ALL, Species %in% c("Telatrygon_zugei")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#B11F1F") +
  ylim(-0.065,0.035) +
  labs(title = "BS1_Telatrygon_zugei",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS1_Telatrygon_zugei.jpg", plot=Plot_BS1_Telatrygon_zugei, width=7.520, height=3.885)

# BS2
Plot_BS2_Telatrygon_zugei <- ggplot(subset(BS2_train_ALL, Species %in% c("Telatrygon_zugei")), aes(x = Temperature, y = Value, color = Species)) +
  geom_point(size = 3, color="#1A5AB3") +
  ylim(-0.004,0.003) +
  labs(title = "BS2_Telatrygon_zugei",
       y = "-dF/dT", x = "Temperature") +
  theme_bw()+
  theme(text = element_text(family = "Arial", size = 24)) +
  theme(axis.text = element_text(size = 20)) +
  theme(axis.title = element_text(size = 22)) +
  theme(legend.position = "none") +
  theme(strip.text.x = element_text(margin = margin(2, 0, 2, 0))) +
  theme(plot.title = element_text(face = "italic"))

ggsave(file="../plot_r/species/BS2_Telatrygon_zugei.jpg", plot=Plot_BS2_Telatrygon_zugei, width=7.520, height=3.885)