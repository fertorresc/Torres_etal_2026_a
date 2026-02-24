#TESTING MONOPHYLY OF PREDEFINED GROUPS IN GENE TREES
#multiple loop over is.monophyletic()
#by Tomas Fer, 2016
#-------------------------------------------------------------

#load libraries
library (phytools)
library (ape)
library(tidyverse)



#DEFINE MONOPHYLETIC GROUPS OF INTEREST

sur = c("_PUC_hembra.codingseq", "_PUC_hembra_short.fasta", "_PUC_macho.codingseq", "_PUC_macho_short.fasta")
centro = c("_CONS_hembra_short.fasta","_CONS_hembra.codingseq", "_CONS_macho.codingseq", "_CONS_macho_short.fasta")
norte = c("_POS_hembra.codingseq", "_POS_hembra_short.fasta", "_POS_macho.codingseq", "_POS_macho_short.fasta")

sur.centro = c("_PUC_hembra.codingseq", "_PUC_hembra_short.fasta", "_PUC_macho.codingseq", "_PUC_macho_short.fasta", "_CONS_hembra_short.fasta","_CONS_hembra.codingseq", "_CONS_macho.codingseq", "_CONS_macho_short.fasta" )

sur.norte = c(sur, norte)

centro.norte= c(centro, norte)

#Cf.oak = c("Clarkia_franciscana_OH_Sianta_1603_C","Clarkia_franciscana_OH_Sianta_1603_A","Clarkia_franciscana_OH_Sianta_1603_B")
#Cf.pr = c("Clarkia_franciscana_PR_Sianta_1604_C","Clarkia_franciscana_PR_Sianta_1604_A" ,"Clarkia_franciscana_PR_Sianta_1604_B")


groupsToTest = list(norte, centro, sur, sur.centro, sur.norte, centro.norte )
groupsToTestNames = c("norte", "centro", "sur", "sur.centro", "sur.norte", "centro.norte")

#define trees (all files with *.tre in current directory) - this command will store all tree names in 'trees_files'
setwd("~/Insync/fertorresc@gmail.com/DriveFT/Dogtorado/PhD_dissertation_project/IQtree/Treefile_selected/")
trees_files <- dir("~/Insync/fertorresc@gmail.com/DriveFT/Dogtorado/PhD_dissertation_project/IQtree/Treefile_selected/")



#function reading newick tree and evaluating monophyly of species in a group (tips = "group")
monophyletic <- function(file, monolist) {
  print (file)
  #read newick tree
  tree = read.newick(file)
  #put all species to 'alltips'
  alltips <- tree$tip.label
  #in 'comparelist' will be only those species from 'monolist' that are present in a tree 
  comparelist <- alltips[alltips %in% monolist]
  #if nr. of species in comparelist is at least two function is.monophyletic is called
  if (length(comparelist) > 1) {
    mono <- is.monophyletic(phy = tree, tips = comparelist)
    #otherwise function returns "NA"
  } else {
    mono <- NA
  }
  return(c(mono))
}

#put names of trees to ismonophyl
ismonophyl <- trees_files
#make dataframe (trees names in the first column)
ismonophyl <- data.frame(tree=trees_files)

x <- 0
#loop over all groups
for(i in groupsToTest) {
  x <- x + 1
  #apply monophyly test of a group to all trees
  ismonophyl[[x+1]] <- lapply(trees_files, monophyletic, monolist = i)
}

#add column names to the matrix
colnames(ismonophyl) <- c("tree", groupsToTestNames)


# number of gene trees that support each of these groupings as monophyletic
ismonophyl %>%
  gather("group","TF", 2:7) %>%
  filter(TF == TRUE) %>%
  group_by(group) %>%
  dplyr::summarise( n = n())

nrow(ismonophyl) # 1705 trees total


### Determining number of gene trees that support various scenarios of budding speciaiton:

# no budding speciation - all species monophyletic
ismonophyl %>%
  filter(sur == T & centro ==T & norte ==T) %>%
  summarise(n = n())

# sur derived from centro
ismonophyl %>%
  filter(sur == T & sur.centro == T & centro == F & norte == T) %>%
  summarise(n = n())

# sur derived from norte
#ismonophyl %>%
#  filter(sur == T & sur.norte == T & norte == F & centro == T) %>%
#  summarise(n = n())

#centro derived from norte
ismonophyl %>%
  filter(centro == T & centro.norte == T & norte == F & sur == T) %>%
  summarise(n = n())

# sur derived from centro, centro derived from norte
ismonophyl %>%
  filter(sur== T & sur.centro == T & centro == F & norte == F)  %>%
  summarise(n = n())


# All other tress:
ismonophyl %>%
  filter(!c( c(sur== T & sur.centro == T & centro == F & norte == F) | 
               c(centro == T & centro.norte == T & norte == F & sur == T) | 
               c(sur == T & sur.norte == T & norte == F & centro == T) |
               c(sur == T & sur.centro == T & centro == F & norte == T) |
               c(sur == T & centro ==T & norte ==T) )
  ) %>%
  summarise(n = n())
