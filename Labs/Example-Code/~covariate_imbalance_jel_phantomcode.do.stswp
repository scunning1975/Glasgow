/*********************************************************************/
/*  Covariate-balance table   (Baker Table 4, Stata version)         */
/*********************************************************************/
cap mkdir "Tables"

/*--------------------------------------------------------------------
   0.  Convenience locals
--------------------------------------------------------------------*/
local covs perc_female perc_white perc_hispanic ///
           unemp_rate poverty_rate median_income_k

*--------------------------------------------------------------------
* 1.  2013 levels — unweighted means, SDs, and normalised diff
*--------------------------------------------------------------------
preserve
    keep if year == 2013

    *---- means and SDs in a single collapse -----------------------
    collapse (mean)  `covs'                                   ///
             (sd)    sd_female  = perc_female                 ///
                     sd_white   = perc_white                  ///
                     sd_hisp    = perc_hispanic               ///
                     sd_unemp   = unemp_rate                  ///
                     sd_pov     = poverty_rate                ///
                     sd_income  = median_income_k,            ///
             by(Treat)

*---- rename means with m-prefix, then add an ID --------------------
foreach v of varlist `covs' {
    rename `v' m`v'
}

generate byte id = 1          // same value for both rows (Treat 0/1)

*---- reshape into one wide row -------------------------------------
reshape wide m* sd_*, i(id) j(Treat)
drop id                       // no longer needed

*---- normalised differences ----------------------------------
*  map:  perc_female→female,  perc_white→white, …
local covs     perc_female perc_white perc_hispanic ///
               unemp_rate  poverty_rate median_income_k
local sdstems  female      white       hisp            ///
               unemp       pov         income

tokenize `covs'
local i = 1
while "`1'" != "" {
    local v  `1'
    local sd : word `i' of `sdstems'
    gen nd_`v' = (m`v'1 - m`v'0) / ///
                 sqrt( (sd_`sd'1^2 + sd_`sd'0^2) / 2 )
    macro shift
    local ++i
}

    keep m* nd_*                    // single-row dataset
    tempfile unwt_pre
    save `unwt_pre'
restore



/*--------------------------------------------------------------------
   2.  2013 levels — weighted
--------------------------------------------------------------------*/
preserve
    keep if year == 2013

    /* weighted means & *population* variances ---------------------- */
    foreach v of local covs {
        gen wm_`v' = .
        gen wv_`v' = .
        levelsof Treat, local(T)
        foreach g of local T {
            qui summarize `v' [aw = set_wt] if Treat == `g'
            scalar mu   = r(mean)
            scalar varp = r(Var)
            replace wm_`v' = mu   if Treat == `g'
            replace wv_`v' = varp if Treat == `g'
        }
    }

    collapse (first) wm_* wv_*, by(Treat)

    /* rename:  wm_*  →  wm...   (means) 
                 wv_*  →  ws...   (variances)  */
    foreach v of varlist wm_* wv_* {
        local stem = substr("`v'", 4, .)
        if substr("`v'",1,2) == "wm" rename `v' wm`stem'
        else                       rename `v' ws`stem'
    }

    /* reshape to one wide row ------------------------------------- */
    generate byte id = 1
    reshape wide wm* ws*, i(id) j(Treat)
    drop id

    /* weighted normalised differences ----------------------------- */
    foreach v of local covs {
        gen wnd_`v' = (wm`v'1 - wm`v'0) / sqrt( (ws`v'1 + ws`v'0) / 2 )
    }

    keep wm* wnd_*                          // one-row dataset
    tempfile wtd_pre
    save `wtd_pre'
restore

