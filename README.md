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

## babble_part_metadata

Script to determine the minimum sample size needed to obtain a stable majority agreement. 
It requires:
- A data file with at least 20k entries (the chunks indeces are hard-coded, but can be changed if the file is smaller)
It returns, for every chunk:
- number of clips with at least one annotation
- number of clips with 2 or more annotations
- the proportion of majority agreement for the given data (includes both 2/3 agreement and 3/3 agreement)
