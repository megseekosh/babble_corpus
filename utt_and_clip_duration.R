library(tidyverse)

# Opening the linking_file
babble_linking_file <- read_tsv("/Volumes/pn-opus/Seedlings/ACLEW/aclew_babble_corpus/Linking-file-2-27-19.txt", col_names=F)


babble_linking_file %>% 
  count()
# Setting the corpus that is currently studied
corpora <- c("Casillas-Yeli", "Tsimane", "Seedlings", "Warlaumont", "Cychosz", "Tseltal")

# Cleaning data and computing durations at the clip level
babble <- babble_linking_file %>% 
  separate("X3", c("corp","subj","age","begin","end"), sep="_") %>% 
  separate(end, c("end", "wav"), sep=-4) %>% 
  mutate(begin=as.numeric(begin), end=as.numeric(end)) %>% 
  distinct(corp, subj, X2, begin, end, X4, X5) %>% 
  mutate(dur_utt = 1000*(end-begin), dur_clip = 1000*(X5-X4)) %>% 
  filter(corp %in% corpora)

distinct(babble,X2)


babble %>%
  nrow()
# Summary of the data at the clip level
summary(babble)
sd(babble$dur_clip)

# Grouping by utterances
babble_utt <- babble %>% 
  ungroup() %>% 
  distinct(corp, subj, begin, end, dur_utt) 

# Summary of the data at the utterance level
summary(babble_utt)
sd(babble_utt$dur_utt)
