# PRA2003-Monitoring bacterial movement and populations
## Alicia De la Torre Ortega - i6386528
## Overview
This project analyzes bacterial tracking data to study the movement and population 
counts of a normal strain versus a mutant strain. For each recorded event, the 
position/momentum of individual bacteria is read from a data file, and used to 
answer three questions: average counts per strain (with uncertainties), whether 
counts differ between strains (asymmetry), and whether that asymmetry depends on 
momentum.

## Data format
Each input file (e.g. `output-Set0.txt`) is structured as:
- **Header line:** `event_id n_particles`
- **One line per particle:** `px py pz code`, where `px/py/pz` are the momentum 
  components and `code` identifies the strain (normal or mutant).
**Answer the following questions:**
1. What are the average counts of each bacterial stain and their statistical uncertainties?
2. Is there any asymmetry between the normal and the mutant strain?
3. Is there any asymmetry as a function of their momentum?
