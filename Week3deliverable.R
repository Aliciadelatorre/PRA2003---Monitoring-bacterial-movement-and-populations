#average formula
#every header corresponds to a different experiment
#header contains number of events (to use in average formula)
#count how many e.g. 211, -211... we have
#eg. we find 34 211 in 3 experiments. then avg= 34/3
#if an experiment has 0 events, we still count it
#for now we don't care about the first 3 numbers in each event

cat("Reading file... This will take approximately 4 minutes\n")
flush.console() #flush.console() forces R to print this now, instead of saving it until later
lines <- readLines("output-Set1.txt") #each element of "lines" is one full line of the file as text (not yet split into numbers)
cat("Done reading,", length(lines), "lines\n")
flush.console() 

#header lines look like "1 33" (two whole numbers, no decimals) -> flag them
is_header <- grepl("^\\d+ \\d+$", lines) #grepl checks every line against the pattern -> TRUE if it matches (header),FALSE if not (particle line)
# ^: start of the line, \\d+: one or more digits (a whole number), space, $: end of the line
n_events <- sum(is_header) # total # of events equal total # of headers
cat("Found", n_events, "events\n"); flush.console()

# particles lines look like eg. "0.729758 0.610603 -24.4335 -321" but we only want the last number which is the strain code (eg. -321)
codes <- sub(".* ", "", lines[!is_header])
counts <- table(codes) #how many times each code appears is added across the whole file (eg. 34 times we saw 211, 12 times we saw -211...

averages <- counts / n_events #avg per event = total count of a code/total events (events with 0 of that code still count)
uncertainties <- sqrt(counts) / n_events   #Poisson counting error: sqrt(n) on the total, scaled down by n_events like the average was


# translate numeric codes into the strain names from the ID table
strain_names <- c(
  "211" = "E. coli WT",
  "-211" = "E. coli mutant",
  "321" = "Bacillus subtilis WT",
  "-321" = "Bacillus subtilis mutant",
  "2212" = "Pseudomonas aeruginosa WT",
  "-2212" = "Pseudomonas aeruginosa antibiotic-resistant",
  "3122" = "Streptococcus pneumoniae",
  "-3122" = "Capsule-deficient streptococcus pneumoniae",
  "3312" = "Mycobacterium tuberculosis",
  "-3312" = "Drug-resistant mycobacterium tuberculosis",
  "3334" = "Salmonella enteric",
  "-3334" = "Salmonella mutant"
)
# keeps only the codes that are actual bacterial strains and ignores any other codes that are in the file
bacteria_codes <- names(strain_names) #the 12 known sttain codes
bacteria_averages <- averages[names(averages) %in% bacteria_codes] #%in% checks each code in "averages" agains that list and keeps only the matches

bacteria_uncertainties <- uncertainties[names(uncertainties) %in% bacteria_codes]  # keep only the 12 bacterial strains, same as bacteria_averages

for (code in names(bacteria_averages)) {
  cat(strain_names[[code]], ":", bacteria_averages[[code]], "±", bacteria_uncertainties[[code]], "\n")
}
