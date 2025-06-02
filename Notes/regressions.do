/*********************************************************************/
/*  Regression 2×2 DiD table  (Baker Table 3)                        */
/*********************************************************************/

***************************************************************
* 0.  Panel declaration (once)
***************************************************************
xtset countycode year

***************************************************************
* 1.  UNWEIGHTED regressions
***************************************************************
eststo clear

* Label the main outcome
label variable crude_rate_20_64 "Crude Mortality Rate"

* (1) Treat × Post, no FE
reg crude_rate_20_64 c.Treat##c.Post, vce(cluster countycode)
eststo m1
estadd local countyfe "No"
estadd local yearfe   "No"

* (2) Treat × Post with county & year FE  (xtreg, fe → no constant)
xtreg crude_rate_20_64 c.Treat#c.Post i.year, fe vce(cluster countycode)
eststo m2
estadd local countyfe "Yes"
estadd local yearfe   "Yes"

* (3) Long-difference, unweighted
preserve
    keep countycode year crude_rate_20_64 Treat
    reshape wide crude_rate_20_64, i(countycode) j(year)
    gen diff = crude_rate_20_642014 - crude_rate_20_642013
	label variable diff "\$\\Delta\$"
    reg diff Treat, vce(cluster countycode)
eststo m3
estadd local countyfe "No"
estadd local yearfe   "No"
restore

***************************************************************
* 2.  WEIGHTED regressions
***************************************************************

* (4) Weighted, no FE
reg crude_rate_20_64 c.Treat##c.Post [aw=set_wt], vce(cluster countycode)
eststo m4
estadd local countyfe "No"
estadd local yearfe   "No"

* (5) Weighted, county & year FE  (areg keeps _cons; we'll hide it)
areg crude_rate_20_64 c.Treat#c.Post i.year [aw=set_wt], ///
     a(countycode) vce(cluster countycode)
eststo m5
estadd local countyfe "Yes"
estadd local yearfe   "Yes"

* (6) Weighted long-difference
preserve
    keep countycode year crude_rate_20_64 Treat set_wt
    reshape wide crude_rate_20_64, i(countycode) j(year)
    gen diff = crude_rate_20_642014 - crude_rate_20_642013
    reg diff Treat [aw=set_wt], vce(cluster countycode)
eststo m6
estadd local countyfe "No"
estadd local yearfe   "No"
restore
