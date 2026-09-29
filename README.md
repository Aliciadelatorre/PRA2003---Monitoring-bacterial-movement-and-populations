# PRA2003-Monitoring bacterial movement and populations
**Alicia De la Torre Ortega - i6386528**
## Overview
This project analyses bacterial tracking data to study the movement and population counts of a normal strain vs. a mutant strain. For each recorded event, the momentum of individual bacteria is read from a data file and used to answer 3 questions: average counts per strain (with uncertainties), whether counts differ between strains (asymmetry) and whether that asymmetry depends on momentum.

## Data format
The input files (`output-Set#.txt`) is structured as:
- **Header line:** `event_id n_particles`
- **One line per particle:** `px py pz code`, where `px/py/pz` are the momentum 
  components and `code` identifies the strain (normal or mutant).
- The full sample consists of 10 files ('output-Set1.txt' to 'output-Set10.txt'), each with 500K events (5M events in total). They are not included in this repository due to file size. Obtain them from (https://surfdrive.surf.nl/index.php/s/7udCnWTk4yMUASD)

## Files
- 'Week2deliverable.R': reads one event from a data file and calculates the momentum magnitude of each particle (Question 1 setup).
- 'Week3deliverable.R': reads the full event file and calculates the average count of each bacterial strain per event and its uncertainties, with strain names (Question 1). For the full-sample result, this script was run separately on each of the 10 sub-samples ('output-Set1.txt' to 'output-Set2.txt')
  
## Getting Started
1. Install R extension in VS code
2. Download the folder as a ZIP file by pressing the green "<> Code" button and selecting "download ZIP"
3. Download the data files from surfdrive and place them in the project folder

## Running the Script
1. Navigate into the project folder
2. From the terminal, run: Rscript *Week#deliverable.R*

## Answer the following questions:
1. What are the average counts of each bacterial stain and their statistical uncertainties?
2. Is there any asymmetry between the normal and the mutant strain?
3. Is there any asymmetry as a function of their momentum?

 ## Results
### Question 1: Average count per event (full sample, 5M events)
