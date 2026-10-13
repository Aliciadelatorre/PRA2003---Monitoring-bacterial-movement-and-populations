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

| Particle ID | Bacterial strain |  Particle ID | Bacterial strain |
| --- | --- | --- | ---| 
| 211 | E. coli WT | -211 | E. coli mutant |
| 321 | Bacillus subtilis WT | -321 | Bacillus subtilis mutant |
| 2212 | Pseudomonas aeruginosa WT | -2212 | P. aeruginosa antibiotic-resistant |
| 3122 | Streptococcus pneumoniae | -3122 | Capsule-deficient S. pneumoniae |
| 3312 | Mycobacterium tuberculosis | -3312 | Drug-resistant M. tuberculosis |
| 3334 | Salmonella enterica | -3334 | Salmonella mutant |

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

#### E. coli (211 / -211)
<img width="1643" height="960" alt="image" src="https://github.com/user-attachments/assets/bc9d9498-8284-4f31-8b11-20aac1119d70" />
*Figure 1. Asymmetry between WT and mutant E. coli. Overall asymmetry 0.00081 ± 0.00011. All 13 points are above zero, and the values rise from 0.0003 at P = 0 to 1, to 0.0014 to 0.0017 at P = 4 to 8 and 0.0026 at P = 24 to 40 (0.0082 above 40). However, no single bin reaches 3σ, the line fit gives a slope of (9.2 ± 4.6) × 10⁻⁵ per 10⁻²⁰ kg m/s (2.0σ), and a flat line fits the points (χ² = 5.4 for 12 points). The rise with momentum is the clearest of all pairs, but not significant.*

<img width="1643" height="960" alt="image" src="https://github.com/user-attachments/assets/66a29993-a444-4b74-948b-19e9ec17dc26" />
*Figure 2. Momentum distribution of E. coli. E. coli is by far the most common strain (about 9.2 million WT per sub-sample), so the bins extend to P = 40. The density is highest in the first bin (dN/dP ≈ 5.8 at P = 0 to 1) and falls to 0.011 at P = 24 to 40. WT and mutant overlap because they differ by less than 0.1%.*

#### B. subtilis (321 / -321)
<img width="1643" height="960" alt="image" src="https://github.com/user-attachments/assets/96d2ec9c-76f9-4e65-a861-7da203764bb7" />
*Figure 3. Asymmetry between WT and mutant B. subtilis. Overall asymmetry 0.00114 ± 0.00066, not significant (1.7σ). The bin values range from −0.0005 to 0.0027 (0.0068 above P = 16), no bin reaches 3σ (the highest is 2.1σ, in the open bin), and the line fit gives a slope of (3.0 ± 1.8) × 10⁻⁴ per 10⁻²⁰ kg m/s (1.6σ), with χ² = 5.2 for 6 points for a flat line. No significant asymmetry and no significant momentum dependence.*

<img width="1643" height="960" alt="image" src="https://github.com/user-attachments/assets/4b8c65fb-0e22-4d32-843e-746d1a0a3041" />
*Figure 4. Momentum distribution of B. subtilis (about 1.16 million WT per sub-sample, 6 wider bins). dN/dP is about 0.47 below P = 2 and falls to 0.031 at P = 8 to 16.*

#### P. aeruginosa (2212 / -2212)
<img width="1643" height="960" alt="image" src="https://github.com/user-attachments/assets/d7cf29ac-4d88-4abb-b292-ee95a36eff4a" />
*Figure 5. Asymmetry between WT and antibiotic-resistant P. aeruginosa. Overall asymmetry 0.00998 ± 0.00100 (10σ). Every point lies above zero, so WT outnumber the mutant at every momentum. The values rise from 0.0073 to 0.0088 below P = 3 to 0.0154 ± 0.0024 above P = 16, but the line fit gives a slope of (3.7 ± 2.6) × 10⁻⁴ per 10⁻²⁰ kg m/s, only 1.4σ from 0, and a flat line fits the points (χ² = 2.9 for 10 points). The data hint at a rise with momentum, but it is not significant.*

<img width="1643" height="960" alt="image" src="https://github.com/user-attachments/assets/8b0f5ab7-debd-4fb8-9684-f77d139355db" />
*Figure 6. Momentum distribution of P. aeruginosa. Most bacteria have P ≈ 1 to 1.5 (dN/dP ≈ 0.22); above that the number falls steadily, to 0.013 at P = 12 to 16. WT and mutant overlap because they differ by only about 1%, which is why the asymmetry is plotted separately. The large error bars in some bins (e.g. 3 to 4) come from sub-sample Set10, which has a different momentum distribution from the other nine.*

#### M. tuberculosis (3312 / -3312)
<img width="1643" height="960" alt="image" src="https://github.com/user-attachments/assets/b01f81e2-4790-48f4-86fa-fd4a67fba328" />
*Figure 7. Asymmetry between WT and capsule-deficient S. pneumoniae. Overall asymmetry 0.00894 ± 0.00106 (8.4σ). All points are above zero, with values between 0.0054 and 0.0090 below P = 4 and between 0.0073 and 0.0133 above, but no single bin reaches 3σ. The line fit gives a slope of (5.1 ± 5.0) × 10⁻⁴ per 10⁻²⁰ kg m/s (1.0σ) and a flat line fits the points (χ² = 1.8 for 10 points): no significant momentum dependence.*

<img width="1643" height="960" alt="image" src="https://github.com/user-attachments/assets/8ed7623e-972c-437d-b155-a2fe0c0a0770" />
*Figure 8. Momentum distribution of S. pneumoniae (about 128,000 WT per sub-sample). The peak is at P = 1 to 1.5 (dN/dP ≈ 0.047), falling to 0.0032 at P = 12 to 16. As for P. aeruginosa, the bins at P = 2.5 to 4 have the largest error bars because of sub-sample Set10.*

#### M. tuberculosis (3312 / -3312)
<img width="1643" height="960" alt="image" src="https://github.com/user-attachments/assets/8a082926-0891-4ea5-95f1-87ee53ae3a52" />
*Figure 9. Asymmetry between WT and drug-resistant M. tuberculosis. Overall asymmetry 0.0056 ± 0.0062, not significant (0.9σ). Ten of the eleven points are above zero, but every error bar includes zero (no bin reaches even 1σ) and all points agree with the pink band. The line fit gives a slope of (5 ± 14) × 10⁻⁴ per 10⁻²⁰ kg m/s, only 0.4σ from 0, and a flat line fits the points (χ² = 0.4 for 10 points). M. tuberculosis has about 30 times fewer bacteria than P. aeruginosa, so the uncertainties are about 6 times larger: the data may hint at an asymmetry, but cannot show one.*
 

<img width="1643" height="960" alt="image" src="https://github.com/user-attachments/assets/e739aa04-a373-4969-b23a-698df80eaf87" />
*Figure 10. Momentum distribution of M. tuberculosis (about 18,000 WT per sub-sample). Same shape as P. aeruginosa, but about 40 times lower at the peak (dN/dP ≈ 0.0058 at P = 1 to 1.5).*

#### Salmonella (3334 / -3334)
<img width="1643" height="960" alt="image" src="https://github.com/user-attachments/assets/112fcfc3-84b2-48b6-a4d2-0abadc0f5886" />
*Figure 11. Asymmetry between Salmonella enterica and its mutant. With only about 1,100 bacteria per sub-sample, just 4 momentum bins could be used. The overall asymmetry is 0.015 ± 0.029 (0.5σ), the bin values range from −0.0007 to 0.048 with error bars of 0.05 to 0.08, and the line fit gives a slope of (−1.3 ± 2.4) × 10⁻² per 10⁻²⁰ kg m/s (0.6σ), with χ² = 0.3 for 3 points. There are too few bacteria to see any asymmetry or momentum dependence.*
<img width="1643" height="960" alt="image" src="https://github.com/user-attachments/assets/5ca4a2b5-fb2a-4a47-b9bb-338ef9c698ef" />
*Figure 12. Momentum distribution of Salmonella. The rarest strain: dN/dP is only about 0.0001 per event, highest at P = 1.5 to 3.*

#### All pairs
 
Slope in units of (10⁻²⁰ kg m/s)⁻¹. χ²: flat line, compared with the number of points.
 
| Pair | Overall A ± SD | Line fit slope ± error | Slope significance | χ² / points | A depends on momentum? |
|---|---|---|---|---|---|
| E. coli (211) | 0.00081 ± 0.00011 | (9.2 ± 4.6) × 10⁻⁵ | 2.0σ | 5.4 / 12 | No (hint) |
| B. subtilis (321) | 0.00114 ± 0.00066 | (3.0 ± 1.8) × 10⁻⁴ | 1.6σ | 5.2 / 6 | No |
| P. aeruginosa (2212) | 0.00998 ± 0.00100 | (3.7 ± 2.6) × 10⁻⁴ | 1.4σ | 2.9 / 10 | No |
| S. pneumoniae (3122) | 0.00894 ± 0.00106 | (5.1 ± 5.0) × 10⁻⁴ | 1.0σ | 1.8 / 10 | No |
| M. tuberculosis (3312) | 0.0056 ± 0.0062 | (5 ± 14) × 10⁻⁴ | 0.4σ | 0.4 / 10 | No |
| Salmonella (3334) | 0.015 ± 0.029 | (−1.3 ± 2.4) × 10⁻² | 0.6σ | 0.3 / 3 | No |
 
No slope reaches 3σ. However, for the four pairs with the most bacteria (E. coli, B. subtilis, P. aeruginosa, S. pneumoniae) the slope is positive, between 1.0σ and 2.0σ: the data hint that the excess of WT grows with momentum, but the effect is not significant. 

## Conclusion: do we see any asymmetry?
 
- **Overall (Question 2):** yes for E. coli, P. aeruginosa and S. pneumoniae: the WT is more abundant than the mutant, by more than 3σ. The asymmetry is largest for P. aeruginosa and S. pneumoniae (about 1%) and smallest for E. coli (0.08%). For B. subtilis, M. tuberculosis and Salmonella the asymmetry is not significant.
- **As a function of momentum (Question 3):** no significant momentum dependence for any pair; no slope reaches 3σ. For E. coli (2.0σ), B. subtilis (1.6σ), P. aeruginosa (1.4σ) and S. pneumoniae (1.0σ) the asymmetry tends to increase with momentum, so there is a hint that the excess of WT is larger among the fastest bacteria, but it is not significant with these uncertainties. M. tuberculosis (0.4σ) and Salmonella (0.6σ, only 4 momentum bins because of its few bacteria) show no momentum dependence.
## Limitations
 
- Sub-sample Set10 has a different momentum distribution from the other nine, which makes the SD larger in several momentum bins.
- With only 10 sub-samples, each SD is itself uncertain (by roughly 25%).
- The χ² of a flat line is well below the number of points for every pair (e.g. 2.9 for 10 points for P. aeruginosa): the points scatter much less than their SD error bars. The SD describes how much one sub-sample varies, while each point is an average of 10 sub-samples, so the SD may overestimate the uncertainty of the points and hide a real momentum dependence.
- The last bin is open-ended and covers a wide range of momenta in one point.
- The rare strains (M. tuberculosis, Salmonella) have too few bacteria to detect a small asymmetry.
