* Checklist using CS

clear 
capture log close
ssc install panelview

* 1. Define the target paramter
* 2. Make a table of when units are treated
* 3. Plot the treatment rollout
* 4. Pick covariates
* 5. Check covariate imbalance
* 6. Plot the average outcomes over time per treatment group (and never treated group)
* 7. Estimator (e.g., TWFE, CS, SA, etc)
* 8. Sensitivity analysis (honest diff in diff)
* 9. Don't do diff in diff

use https://github.com/scunning1975/mixtape/raw/master/castle.dta, clear
xtset sid year

* Step 1: define the target parameter. For diff in diff, there's really only one choice to make.  Will you weight by population or not? Do I want to know the effect of this gun law on the average person (which means that large states will be more influential than small ones) or do I want to know the effect on the averate state? I'm going to do try to estimate BOTH the average treatment effect on the treated groups for the average person (weight by state population) AND the average treatment effect on the average state (don't weight by state population). That is TWO SEPARATE TARGET PARAMETERS, and remmeber, they don't have to be the same number. 

* Step 2: make a table of when units are treated. 

gen 	treat_date = effyear
replace treat_date = 0 if effyear==.
label variable treat_date "Timing Group Treatment Date (never-treated is zero)"

ta treat_date if year==2000

gen treat=0
replace treat=1 if year>=effyear


* Step 3. Plot the treatment rollout. 
panelview l_homicide treat, prepost bytiming i(sid) t(year) type(treat) xtitle("Year") ytitle("US States") ylabel(none) title("Rollout of Castle Doctrine") legend(label(1 "Never Treated") label(2 "Treated (Pre)") label(3 "Treated(Post)"))


/* Step 4. Picking covariates and we will start with these:

police unemployrt income blackm_15_24 whitem_15_24 blackm_25_44 whitem_25_44 prisoner lagprisoner poverty exp_subsidy exp_pubwelfare northeast midwest south west

*/

* Step 5. Create a covariate imbalance table using that Imbens and Rubin (2015) rule, as well as Baker, Callaway, Cunningham, Goodman-Bacon and Sant'Anna JEL "Practitioner's Guide" which says if the normalized difference in means between the treatment and control group is greater than 0.25 in absolute value, there is "problematic imbalance in that covariate" and you may need to control for it. Our treatments start in 2005, then is each year after for different groups, so I am going to create an imbalance table for 2004 covariates.






