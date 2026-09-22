# PRA2003-Monitoring bacterial movement and populations
**Alicia De la Torre Ortega - i6386528**
## Overview
This project analyses bacterial tracking data to study the movement and population counts of a normal strain vs. a mutant strain. For each recorded event, the momentum of individual bacteria is read from a data file and used to answer 3 questions: average counts per strain (with uncertainties), whether counts differ between strains (asymmetry) and whether that asymmetry depends on momentum.

## Data format
The input files (`output-Set#.txt`) is structured as:
- **Header line:** `event_id n_particles`
- **One line per particle:** `px py pz code`, where `px/py/pz` are the momentum 
  components and `code` identifies the strain (normal or mutant).

## Files
- 'Week2deliverable.R': reads one event from a data file and calculates the momentum 
  magnitude of each particle (Question 1 setup).
- 'Week3deliverable.R': reads the full event file and calculates the average count of each bacterial strain per event and its uncertainties, with strain names (Question 1)
- *(The rest are to be defined in the upcoming weeks)*
  
## Getting Started
1. Install R extension in VS code
2. Download the folder as a ZIP file by pressing the green "<> Code" button and selecting "download ZIP"

## Running the Script
1. Navigate into the project folder
2. From the terminal, run:
Rscript *Week#deliverable.R*

## Answer the following questions:
1. What are the average counts of each bacterial stain and their statistical uncertainties?
2. Is there any asymmetry between the normal and the mutant strain?
3. Is there any asymmetry as a function of their momentum?

 ## Results

**Question 1 — average count per event, with statistical uncertainty (Poisson, sqrt(N)/n_events):**
| Bacterial strain | Average count / event | Uncertainty |
|---|---|---|
| E. coli WT | 18.47739 | ± 0.006079045 |
| E. coli mutant | 18.45157 | ± 0.006074795 |
| Bacillus subtilis WT | 2.321694 | ± 0.002154852 |
| Bacillus subtilis mutant | 2.322076 | ± 0.002155029 |
| Pseudomonas aeruginosa WT | 1.119182 | ± 0.001496116 |
| Pseudomonas aeruginosa antibiotic-resistant | 1.094724 | ± 0.001479678 |
| Streptococcus pneumoniae | 0.256764 | ± 0.0007166087 |
| Capsule-deficient streptococcus pneumoniae | 0.252488 | ± 0.0007106166 |
| Mycobacterium tuberculosis | 0.036264 | ± 0.0002693102 |
| Drug-resistant mycobacterium tuberculosis | 0.036612 | ± 0.0002705993 |
| Salmonella enteric | 0.001188 | ± 4.874423e^-05 |
| Salmonella mutant | 0.001088 | ± 4.664762e^-05 |
