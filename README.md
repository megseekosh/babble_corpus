# babble_corpus

## data/

contains data for these scripts:
  - list of clips per part
  - answers spreadsheets
  - linking file (metadata to clips)

## babble_analysis_basic

Retrieves 

- number of clips with at least one annotation
- number of clips with at least one annotation missing (only works for part 2 and 3 where 3 annotations were required)
- number of clips with at least 3 annotations
- number of clips with 100% agreement
- number of cips without majority agreement (only works for part 2 and 3 where majority=>=2)

## check_majority_agreement

check majority agreement on a preprocessed csv (see Rmd itself) and writes csv with clips without majority agreement

## babble_part_metadata

from linking file and answer spreadsheet, retrieves:
- number of children by corpus in this part
- number of utterances by child
- number of clips by child
- total number of clips in this part
- histogram of the length of utterances in this part

## utt_and_clip_duration
To use the script, you should change:
- the path to the linking file
- the corpus you want information on

Script to retrieve :

- at the clip level (max 500ms):
  - mean duration
  - sd of duration
  - min clip duration
  - max clip duration
  
- at the utterance level:
  - mean duration
  - sd of duration
  - min utt duration
  - max utt duration
  
## babble_analysis_raw_output
  
Reads output directly out of IHUP (currently for parts 6 and 7), looks at the distribution of the number of annotations per clip
  
## concat_all

Read answers spreadsheets from all parts, concatenates them and looks for one coder annotating the same clips more than once
