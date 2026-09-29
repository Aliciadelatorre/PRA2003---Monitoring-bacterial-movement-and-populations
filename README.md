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
  
## Getting Started
1. Install R extension in VS code
2. Download the folder as a ZIP file by pressing the green "<> Code" button and selecting "download ZIP"
3. Download the data files from surfdrive and place them in the project folder

## Running the Script
1. Navigate into the project folder
2. From the terminal, run: Rscript *Week#deliverable.R*

## Answer the following questions:
1. What are the average counts of each bacterial strain and their statistical uncertainties?
2. Is there any asymmetry between the normal and the mutant strain?
3. Is there any asymmetry as a function of their momentum?

 ## Results
### Question 1: Average count per event (full sample, 5M events)
### Method: sub-sampling
The full sample (5M events) was split into 10 sub-samples of 500K events (`output-Set1.txt` to `output-Set10.txt`). Each quantity was calculated separately in every sub-sample. The final result is the mean of the 10 sub-sample results, which equals the result for the full sample. Its statistical uncertainty comes from the spread of the sub-sample results:

$$\sigma_{\text{mean}} = \frac{\text{SD}}{\sqrt{n}}, \quad n = 10$$

### Question 1: Average count per event (full sample, 5M events)

| Strain | Mean count per event ± uncertainty |
|---|---|
| E. coli WT | 19.950 ± 0.010 |
| E. coli mutant | 19.917 ± 0.010 |
| Bacillus subtilis WT | 2.5092 ± 0.0015 |
| Bacillus subtilis mutant | 2.5035 ± 0.0017 |
| Pseudomonas aeruginosa WT | 1.20803 ± 0.00060 |
| Pseudomonas aeruginosa antibiotic-resistant | 1.18416 ± 0.00076 |
| Streptococcus pneumoniae | 0.27660 ± 0.00034 |
| Capsule-deficient S. pneumoniae | 0.27170 ± 0.00031 |
| Mycobacterium tuberculosis | 0.03944 ± 0.00009 |
| Drug-resistant M. tuberculosis | 0.03900 ± 0.00013 |
| Salmonella enterica | 0.00119 ± 0.00001 |
| Salmonella mutant | 0.00115 ± 0.00002 |

### Question 2: Asymmetry between normal and mutant strains
For each pair, the asymmetry was calculated in every sub-sample:
$$A = \frac{N_{\text{WT}} - N_{\text{mutant}}}{N_{\text{WT}} + N_{\text{mutant}}}$$

Its uncertainty was calculated in the same way as above (SD/√10). Calculating A per sub-sample takes into account that both strains are measured on the same events. A pair is classified as **asymmetric** if |A| exceeds 3 times its uncertainty (3σ threshold), and as **symmetric** otherwise.

| Pair | Difference (WT − mutant) | Asymmetry A (%) | Significance | Result |
|---|---|---|---|---|
| E. coli | 0.0323 ± 0.0014 | 0.081 ± 0.004 | 23σ | Asymmetric |
| B. subtilis | 0.0057 ± 0.0010 | 0.11 ± 0.02 | 5.5σ | Asymmetric |
| P. aeruginosa | 0.0239 ± 0.0008 | 1.00 ± 0.03 | 32σ | Asymmetric |
| S. pneumoniae | 0.0049 ± 0.0002 | 0.89 ± 0.03 | 27σ | Asymmetric |
| M. tuberculosis | 0.00044 ± 0.00015 | 0.56 ± 0.20 | 2.9σ | Symmetric |
| Salmonella | 0.00004 ± 0.00002 | 1.6 ± 0.9 | 1.7σ | Symmetric |

**Conclusion:** Using a 3σ threshold, four of the six pairs are asymmetric, with the WT consistently more abundant than the mutant. Although *E. coli* shows the largest absolute difference in counts, *P. aeruginosa* and *S. pneumoniae* show the strongest asymmetry relative to their abundance. *M. tuberculosis* and *Salmonella* are consistent with symmetry. *M. tuberculosis* lies just below the threshold, so more data could change this conclusion. *Salmonella* has the largest relative asymmetry but is also the rarest strain, so its uncertainty is too large for the asymmetry to be significant.

### Question 3: Asymmetry as a function of momentum
*To be added.*
