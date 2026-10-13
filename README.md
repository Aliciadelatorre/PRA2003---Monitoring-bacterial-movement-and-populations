# PRA2003-Monitoring bacterial movement and populations
**Alicia De la Torre Ortega - i6386528**
## Overview
This project analyses bacterial tracking data to study the movement and population counts of a normal strain vs. a mutant strain. For each recorded event, the momentum of individual bacteria is read from a data file and used to answer 3 questions: average counts per strain (with uncertainties), whether counts differ between strains (asymmetry) and whether that asymmetry depends on momentum.

## Data format
The input files (`output-Set#.txt`) are structured as:
- **Header line:** `event_id n_particles`
- **One line per particle:** `px py pz code`, where `px/py/pz` are the momentum 
  components and `code` identifies the strain (normal or mutant).
- The full sample consists of 10 files ('output-Set1.txt' to 'output-Set10.txt'), each with 500K events (5M events in total). They are not included in this repository due to file size. Obtain them from (https://surfdrive.surf.nl/index.php/s/7udCnWTk4yMUASD)

## Files
- 'Week2deliverable.R': reads one event from a data file and calculates the momentum magnitude of each particle (Question 1 setup).
- 'Week3deliverable.R': reads the full event file and calculates the average count of each bacterial strain per event and its uncertainties, with strain names (Question 1). For the full-sample result, this script was run separately on each of the 10 sub-samples ('output-Set1.txt' to 'output-Set10.txt')
- `momentum.R`: goes through the 10 sub-samples, keeps the 12 strains of interest and calculates the momentum of every bacterium, $P = \sqrt{p_x^2 + p_y^2 + p_z^2}$. Saves `momenta-Set1.csv` to `momenta-Set10.csv` (columns `ID`, `p`). These files are not in the repository (too large); the script recreates them.
- `asymmetry.py`: reads the momentum files for one WT/mutant pair and makes the momentum-dependent analysis (Question 3). Saves `asymmetry-<ID>.png`, `spectrum-<ID>.png` and `asymmetry-<ID>.csv` (the numbers behind both plots).
- `plots/`: the plots shown below.
  
## Getting Started
1. Install R extension in VS code
2. Install Python 3 and the packages: 'pip install numpy pandas matplotlib'
3. Download the folder as a ZIP file by pressing the green "<> Code" button and selecting "download ZIP"
4. Download the data files from surfdrive and place them in the project folder

## Running the Script
1. Navigate into the project folder
2. Questions 1 and 2, from the terminal, run: Rscript *Week#deliverable.R*
3. Question 3, in this order:
   i. 'Rscript momentum.R' (makes the momentum files and takes a few minutes)
   ii. 'python3 asymmetry.py', then type the WT ID when asked (e.g. '2212'). Run it once per pair (6 times total).
   

## Answer the following questions:
1. What are the average counts of each bacterial strain and their statistical uncertainties?
2. Is there any asymmetry between the normal and the mutant strain?
3. Is there any asymmetry as a function of their momentum?

 ## Results
 
### Method: sub-sampling
The full sample (5M events) was split into 10 sub-samples of around 500K events (`output-Set1.txt` to `output-Set10.txt`). Each quantity was calculated separately in every sub-sample. The final result is the mean of the 10 sub-sample results, which equals the result for the full sample. Its statistical uncertainty (error bars in plot) is the standard deviation (SD) of the 10 sub-sample results.

### Question 1: Average count per event (full sample, 5M events)

| Strain | Mean count per event ± uncertainty (SD) |
|---|---|
| E. coli WT | 19.950 ± 0.033 |
| E. coli mutant | 19.917 ± 0.032 |
| Bacillus subtilis WT | 2.5092 ± 0.0048 |
| Bacillus subtilis mutant | 2.5035 ± 0.0055 |
| Pseudomonas aeruginosa WT | 1.2080 ± 0.0019 |
| Pseudomonas aeruginosa antibiotic-resistant | 1.1842 ± 0.0024 |
| Streptococcus pneumoniae | 0.2766 ± 0.0011 |
| Capsule-deficient S. pneumoniae | 0.2717 ± 0.0010 |
| Mycobacterium tuberculosis | 0.0394 ± 0.0003 |
| Drug-resistant M. tuberculosis | 0.0390 ± 0.0004 |
| Salmonella enterica | 0.00119 ± 0.00004 |
| Salmonella mutant | 0.00115 ± 0.00005 |

### Question 2: Asymmetry between normal and mutant strains
For each pair, the relative asymmetry was calculated in every sub-sample:

$$A = \frac{N_{\text{WT}} - N_{\text{mutant}}}{N_{\text{WT}} + N_{\text{mutant}}}$$

Its uncertainty is the SD of the 10 sub-sample values of A. Calculating A per sub-sample takes into account that both strains are measured on the same events. A pair is classified as **asymmetric** if |A| exceeds 3 times its uncertainty (3σ threshold), and as **not significant** otherwise.

| Pair | Difference (WT − mutant) | Asymmetry A (%) | Significance | Result |
|---|---|---|---|---|
| E. coli | 0.032 ± 0.005 | 0.08 ± 0.01 | 7.2σ | Asymmetric |
| B. subtilis | 0.006 ± 0.003 | 0.11 ± 0.07 | 1.7σ | Not significant |
| P. aeruginosa | 0.024 ± 0.002 | 1.0 ± 0.1 | 10σ | Asymmetric |
| S. pneumoniae | 0.0049 ± 0.0006 | 0.9 ± 0.1 | 8.5σ | Asymmetric |
| M. tuberculosis | 0.0004 ± 0.0005 | 0.6 ± 0.6 | 0.9σ | Not significant |
| Salmonella | 0.00004 ± 0.00007 | 1.6 ± 2.9 | 0.5σ | Not significant |

"Not significant" means that the data cannot show a difference, it does not prove that both strains are equally abundant.

### Question 3: Asymmetry as a function of momentum
**Method** For each pair, the momenta are divided into bins. The bins are narrow where there are many bacteria and wider where there are few, so that every bin holds similar number of bacteria and has a similar uncertainty. Everything above the last edge is collected in one open bin (grey area in the plots). WT and mutant always use the same bins. In every bin and every subsample:

- the asymmetry $A = (N_{WT} - N_{mut}) / (N_{WT} + N_{mut})$ was calculated. This is a ratio of two counts from the same bin, so the bin width cancels;
- the momentum distribution $dN/dP = N / (\text{bin width} \times \text{events})$ was calculated. Dividing by the bin width makes bins of different widths comparable.

The 10 sub-sample values were then averaged per bin (for A, each sub-sample is weighted by its number of bacteria in that bin). The error bars are the SD of the 10 sub-samples. To test whether A depends on momentum, a straight line $A = a \cdot P + b$ was fitted through the points (open bin excluded, since it has no defined momentum), with the SD of each point as its uncertainty. A slope more than 3σ away from 0 means that A changes with momentum. As a second check, χ² of a flat line (A equal to the overall asymmetry in every bin) was calculated: it should be about equal to the number of points if A does not depend on momentum.

Units: Momentum is given in units of $10^{-20}$ kg m/s.

#### P. aeruginosa (2212 / -2212)
<img width="1710" height="1036" alt="Captura de pantalla 2026-10-13 a las 13 22 35" src="https://github.com/user-attachments/assets/a3c01777-bf32-4637-ab6e-85ff066f873e" />


 
