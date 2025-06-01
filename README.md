# Glasgow Workshop on Causal Panel Methods

Welcome to the materials for the **Glasgow Workshop on Causal Panel Methods**, a weeklong intensive course (9:00–16:00 daily) focused on advanced techniques for estimating causal effects in panel data.

---

## About the Workshop

This workshop introduces and explores some of the most important modern methods in causal inference for panel data, including:

- Difference-in-Differences (DiD)
- Synthetic Control Methods (SCM)
- Event studies and dynamic treatment effects
- Aggregation, weighting, and parallel trends diagnostics
- Recent innovations like CS, SA, DCDH, Honest DiD, as well as synthetic controls. 

The goal is not to be exhaustive but rather to bring participants from **beginner to competent** over the course of the week.

---

## Schedule Overview

Each day runs from 9:00 AM to 4:00 PM, with a lunch break from 12:00–1:15 PM. Each day includes six 45-minute teaching blocks:
- 9:00–9:45
- 10:00–10:45
- 11:00–12:00
- 1:15–2:00
- 2:15–3:00
- 3:15–4:00

Monday: The Core of DiD
- 2×2 DiD intuition + worksheet
- Potential outcomes and ATT with exercises
- Weighting and regression: the three regressions
- Event studies, leads/lags, and long differences
- Falsification strategies:
- Different group, same outcome
- Same group, different outcome

Tuesday: Violations of Parallel Trends
- Triple differences
- Repeated cross sections (Hong 2013)
- Propensity scores & IPW (with hand-calculation and code)
- Covariate balance diagnostics
- LASSO for covariate selection
- Abadie IPW, Heckman, Ichimura and Todd OR, DR, and TWFE
- Using drdid, csdid, and did for 2×T event studies

Wednesday: Introducing Differential Timing
- Fixed effects and TWFE
- Goodman-Bacon decomposition
- Callaway & Sant’Anna with simulation
- Craigslist case study
- Homework: Concealed carry and checklist

Thursday: More on Differential Timing
- Sun & Abraham and dCDH estimators
- Borusyak et al., two-stage diff-in-diff, 
- Concealed carry coding exercise
- Honest DiD
- Continuous DiD 

Friday: Synthetic Controls
- Abadie’s original SCM (JASA, APSR, JPAM best practices)
- Augmented SCM and imbalance diagnostics
- Matrix completion
- Optional: Kyle’s estimator, synthetic difference-in-differences, multiple outcomes, stacking diff-in-diff

---

## Structure

This repository contains:

- `/slides/` – Lecture slides for each day  
- `/code/` – Hands-on Stata and R code  
- `/data/` – Sample datasets used during exercises  
- `README.md` – This file  
- (Optional) `/references/` – Additional readings and papers

---

## Who Is This For?

Economists, data scientists, policy analysts, and researchers working with longitudinal or panel data who want to:

- Understand when and how DiD assumptions break down
- Learn how modern tools address those problems
- Practice implementing these methods in real code

---

## Tools

We’ll primarily use:
- **Stata** (`csdid`, `drdid`, `eventstudyinteract`)
- **R** (`did`, `fixest`, `synth`, `honestdid`)

Participants should be comfortable with basic regression and panel data structures but no prior experience with DiD is assumed.

---

## Optional Reading

- Cunningham (2021), *Causal Inference: The Mixtape*
- Baker, Callaway, Cunningham, Goodman-Bacon and Sant'Anna (2025), *Working Paper*
- Arkhangelsky and Imbens (2024), *Econometrics Journal*
- Callaway & Sant’Anna (2021), *JoE*
- Goodman-Bacon (2021), *JoE*
- Sun and Abraham (2021), *JoE*
- de Chaisemartin and D'Haultfœielle (2020), *AER*
- Abadie et al. (2010), *JASA*
- Borusyak, et al. (2024), *Restud*
- Roth & Rambachan (2023), *Honest DiD*

---

## License

MIT License. Materials are freely available for educational use.

---

## Questions?

Feel free to fork, clone, or reuse anything here. For questions, reach out via [GitHub Issues](https://github.com/scunning1975/Glasgow/issues) or contact Scott Cunningham directly.
