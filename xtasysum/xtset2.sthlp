{smcl}
{* *! v. 1.0 - 16. January 2018}{...}
{cmd:help xtset2}{right: ({browse "https://doi.org/10.1177/1536867X211045560":SJ21-3: st0536_1})}
{hline}

{title:Title}

{p2colset 5 15 17 2}{...}
{p2col :{cmd:xtset2} {hline 2}}Advanced routines for xtset and _xt{p_end}


{title:Syntax}

{p 8 14 2}
{cmd:xtset2} [{it:panelvar} {it:timevar}]  [{it:{help if}}]
[{cmd:,}
{opth checkvars(varlist)}
{cmd:matrix}
{cmd:showxtset}
{cmd:version}
{it:tsoptions}]

{pstd}
{it:panelvar} is the panel identifier (cross-section) and {it:timevar} the
time identifier.  {cmd:xtset2} without the panel and time identifiers displays
the current setting.  {it:tsoptions} are options passed on to
{helpb xtset}.{p_end}


{title:Contents}

{pstd}{help xtset2##description:Description}{p_end}
{pstd}{help xtset2##options:Options}{p_end}
{pstd}{help xtset2##stored:Stored results}{p_end}
{pstd}{help xtset2##about:Author}{p_end}
{pstd}{help xtset2##also_see:Also see}{p_end}


{marker description}{title:Description}

{pstd}
{cmd:xtset2} extends {helpb xtset} and {helpb tsset}.  You can define a
balanced panel with respect to variables, similarly to the {cmd:touse} option
of {cmd:_xt}.


{marker options}{title:Options}

{phang}
{opt checkvars(varlist)} defines the variables the sample is restricted to.
If a variable in {it:varlist} has a {help missing} value, it is removed from
the sample.

{phang}
{cmd:matrix} saves a matrix with Panelid, T, Tmin, Tmax, Tbar, and missings.

{phang}
{cmd:showxtset} displays the output of {helpb xtset}.

{phang}
{cmd:version} returns the version number.

{phang}
{it:tsoptions} passes further options to {helpb xtset}.


{marker stored}{title:Stored results}

{pstd}
{cmd:xtset2} stores the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd: r(N)}}number of observations{p_end}
{synopt:{cmd: r(Tmax)}}maximum of time periods{p_end}
{synopt:{cmd: r(Tmean)}}mean of time periods{p_end}
{synopt:{cmd: r(Tmin)}}minimum of time periods{p_end}
{synopt:{cmd: r(NumGaps)}}number of gaps{p_end}
{synopt:{cmd: r(NumMissing)}}number of missings{p_end}
{synopt:{cmd: r(balancedN)}}number of balanced cross-sections{p_end}
{synopt:{cmd: r(N_g)}}number of groups{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd: r(timevar)}}name of time identifier{p_end}
{synopt:{cmd: r(panelvar)}}name of panel identifier{p_end}
{synopt:{cmd: r(balanced)}}balanced{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd: r(PanelMatrix)}}table with details for each panel{p_end}


{marker about}{title:Author}

{pstd}
Jan Ditzen{break}
Free University of Bozen-Bolzano{break}
Bozen, Italy{break}
{browse "mailto:jan.ditzen@unibz.it":jan.ditzen@unibz.it}{break}
{browse "https://sites.google.com/site/jandger87/home"}


{marker also_see}{title:Also see}

{p 4 14 2}
Article:  {it:Stata Journal}, volume 21, number 3: {browse "https://doi.org/10.1177/1536867X211045560":st0536_1},{break}
          {it:Stata Journal}, volume 18, number 3: {browse "https://doi.org/10.1177/1536867X1801800306":st0536}

{p 7 14 2}
Help:  {manhelp xtset XT}, {manhelp _xt XT}, {manhelp tsset TS}{p_end}
