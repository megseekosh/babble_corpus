# to merge answer spreadsheets from IHUP with linking file 
# note that the child_ID for the 6 Tsimane kids that were added in the later parts is not available in the 
# 'information' variable; so the code below adds those kids' child_ID to 'information' to generate
# child_ID for each child

install.packages('readr'); library('readr')
install.packages('tidyverse'); library('tidyverse')
install.packages('stringr'); library('stringr')

part8answers <- read_csv('Box Sync/LENA_babble/data_management_scripts/part-8_answers_final_9-4.csv', col_types = cols(.default = "c"))
part7answers <- read_csv('Box Sync/LENA_babble/data_management_scripts/part-7_answers_9-12.csv', col_types = cols(.default = "c")) # to get new Tsimane and Yeli data (waiting for this from ihup 4/30/19)
part6answers <- read_csv("Box Sync/LENA_babble/data_management_scripts/part6_answers.csv", col_types = cols(.default = "c")) # pt 6 includes more annotaitons from part 4-5 where there wasn't agreement (5/clip)
earlier_answers <- read_csv("Box Sync/LENA_babble/data_management_scripts/part2-5_answers.csv", col_types = cols(.default = "c"))


all_answers <- rbind(part6answers, earlier_answers, part7answers, part8answers)



linking_file <- read_csv("Box Sync/LENA_babble/data_management_scripts/linking_file_global.csv", col_types = cols(.default = "c"))


# first merge linking file w/ answer sheet
# remove .wav
all_answers$clip_ID <- gsub("\\..*","",all_answers$clip_ID)
# remove first 0
all_answers$clip_ID <- substring(all_answers$clip_ID, 2)

final <- merge(all_answers, linking_file, by = 'clip_ID')




# now create some relevant categories for the analyses
final$corpus <- gsub( "_.*$", "", final$information) # make corpus variable
final$information <- gsub("^[^_]*_", "", final$information)

# Tsimane clips for 6 kids are messed up - have 'nan' in place of childID
# index 'age_in_days' from those kids' 'information' strings
final$age_in_days <-  sapply(strsplit(final$information, "_"), function(x) x[2]) # split string; second index

# add child_ID to 'information' variable for the 6 Tsimane kids
fivhun <- final %>% filter(age_in_days=='500')
four7 <- final %>% filter(age_in_days=='407')
sev9 <- final %>% filter(age_in_days=='799')
thou <- final %>% filter(age_in_days=='1050')
fiv6 <- final %>% filter(age_in_days=='566')
fiv7 <- final %>% filter(age_in_days=='579')
fivhun$information <- sub('[^_]+', '33', fivhun$information) 
four7$information <- sub('[^_]+', '36', four7$information)
sev9$information <- sub('[^_]+', '35', sev9$information)
thou$information <- sub('[^_]+', '11b', thou$information)
fiv6$information <- sub('[^_]+', '37', fiv6$information)
fiv7$information <- sub('[^_]+', '34', fiv7$information)

# combine revised kids w/o original dataset 
final <- rbind(final, fivhun, four7, sev9, thou, fiv6, fiv7) 



final$child_ID <- gsub( "_.*$", "", final$information) # now make child_ID variable for everyone
final$child_ID <- gsub( "-.*$", "", final$child_ID) # # Middy's Yeli data is structured a bit differently so one extra step
final$child_ID <- gsub('^0',"",final$child_ID) # remove zero from single digit child id numbers 
final <- final %>% filter(child_ID != 'nan') # remove copy Tsimane kids w/ child_ID 'nan' 




# read in child demographic info
demo_info <- read.csv('Box Sync/LENA_babble/crossling_paper_analysis/crossling_demographic_edited.csv')

# merge by child_ID
all_data <- merge(demo_info, final, by="child_ID")


write_csv(all_data, "Box Sync/LENA_babble/crossling_paper_analysis/meta_answers_global_crossling_9-20.csv")

