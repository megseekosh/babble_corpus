clips <- read.csv('Box Sync/LENA_babble/analysis/metadata_answers_global_noRAM.csv')


# make it ms
clips$length_ms <- clips$length*1000

View(clips)

# look by corpus
library('dplyr')
clips <- clips %>% 
  group_by(corpus) %>% 
  mutate(mean_clip = mean(length_ms)) %>%
  mutate(sd_clip = sd(length_ms)) %>%
  as.data.frame



