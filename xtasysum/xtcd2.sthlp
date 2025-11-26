{smcl}
{cmd:help xtcd2}{right: ({browse "https://doi.org/10.1177/1536867X211045560":SJ21-3: st0536_1})}
{hline}

{title:Title}

{p2colset 5 14 16 2}{...}
{p2col :{cmd:xtcd2} {hline 2}}Testing for weak cross-sectional dependence{p_end}


{title:Syntax}

{p 8 13 2}
{cmd:xtcd2} [{varname}] [{it:{help if}}] [{cmd:,} {cmdab:noest:imation}
{cmd:rho} {cmdab:kden:sity} {opt name(string)}]

{pstd}
{varname} is the name of residuals or variable to be tested for weak
cross-sectional dependence (CD).  {varname} is optional if the command is
performed after an estimation (postestimation).{p_end}


{title:Contents}

{pstd}{help xtcd2##description:Description}{p_end}
{pstd}{help xtcd2##options:Options}{p_end}
{pstd}{help xtcd2##examples:Examples}{p_end}
{pstd}{help xtcd2##stored:Stored results}{p_end}
{pstd}{help xtcd2##references:References}{p_end}
{pstd}{help xtcd2##ack:Acknowledgments}{p_end}
{pstd}{help xtcd2##about:Author}{p_end}
{pstd}{help xtcd2##also_see:Also see}{p_end}


{marker description}{title:Description}

{pstd}
{cmd:xtcd2} tests residuals or a variable for weak CD in a panel data.  CD in
the error term occurs if dependence between CD regression is not accounted
for.  The dependence between units violates the basic ordinary least-squares
assumption of an independent and identically distributed error term.  In the
worst case, CD in the error term can lead to endogeneity and therefore to
inconsistent estimates.  CD can be measured as the correlation between units.
For example, the correlation of the errors of unit i and unit j can be
calculated.  Obviously, if the correlation is large, CD is present.  Pesaran
(2015) develops a test for weak CD based on this principle.  Weak CD means
that the correlation between units at each point in time converges to zero as
the number of cross-sections goes to infinity.  Under strong dependence, the
correlation converges to a constant.  The null hypothesis of the test is that
the error term (or variable) is weakly CD.  This means that correlation
between an observation of unit i in time t and unit j in time t is zero.  The
hypothesis is

{phang2}
H0: errors are weakly CD{p_end}

{pstd}
Pesaran (2015) derives a test statistic that sums the correlation coefficients
of the different units.  The test statistic for a balanced panel is

{phang2}
CD = [2*T / {N*(N-1)}]^(1/2) * sum(i=1,N-1) sum(j=i+1,N) rho(ij){p_end}

{pstd}
and for an unbalanced panel, it is (see Chudik and Pesaran [2015])

{phang2}
CD = [2 / {N*(N-1)}]^(1/2) * sum(i=1,N-1) sum(j=i+1,N) {T(ij)^(1/2) * rho(ij)}{p_end}

{pstd}
where rho(ij) is the correlation coefficient of unit i and j and T(ij) is the
number of common observations between i and j.  Under the null hypothesis, the
statistic is asymptotically{p_end}

{phang2}
CD ~ N(0,1){p_end}

{pstd}
distributed.

{pstd}
{cmd:xtcd2} calculates the CD test statistic for a given variable.
Alternatively, if run after an estimation command that supports {cmd:predict}
and {cmd:e(sample)}, {cmd:xtcd2} calculates the error term using
{cmd:predict, residuals} and then applies the CD test from above.  In the
former case and if the option {cmd:noestimation} is set, {cmd:e(sample)} is
not needed, and any variable can be tested for CD.  In this setting, all
available observations are used.  {cmd:xtcd2} supports balanced and unbalanced
panels.  Furthermore, by specifying the {cmd:kdensity} option, one can draw a
kernel density plot with the distribution of the cross correlations.{p_end}

{pstd}
If {cmd:xtcd2} is used after {helpb xtreg}, then the residuals are calculated
using {cmd:predict, e} rather than {cmd:predict, res},  that is, the residuals
including the fixed- or random-error component; see
{helpb xtreg postestimation##predict:xtreg postestimation}.  In all other
cases, {cmd:predict, residuals} is used to calculate the residuals.{p_end}


{marker options}{title:Options}

{phang}
{cmd:noestimation} allows any variable to be tested.  If {cmd:noestimation} is
specified, then {cmd:xtcd2} is not run as a postestimation command and does
not require {cmd:e(sample)} to be set.  If not set, then {cmd:xtcd2} either
uses the variable specified in {varname} or predicts the residuals using
{cmd:predict, residuals}.  In both cases, the sample is restricted to
{cmd:e(sample)}.{p_end}

{phang}
{cmd:rho} saves the matrix with the cross correlations in {cmd:r(rho)}.{p_end}

{phang}
{cmd:kdensity} plots a kernel density plot of the cross correlations; see
{helpb twoway kdensity}.  The number of observations, the mean, the
percentiles, and the minimum and maximum of the cross correlations are
reported.  If {opt name(string)} is set, then the histogram is saved and not
drawn.{p_end}

{phang}
{opt name(string)} saves the {cmd:kdensity}.{p_end}


{marker examples}{title:Examples}

{pstd}
Load the example dataset of the Penn World Tables 8.  The dataset contains
yearly observations from 1960 until 2007 and is already {cmd:xtset}.

{phang2}{bf:. {stata use xtdcce2_sample_dataset}}{p_end}

{pstd}
Fitting a simple panel version of the Solow model and running the CD test
afterward{p_end}

{phang2}
{bf:. {stata regress d.log_rgdpo log_hc log_ck log_ngd}}{p_end}
{phang2}
{bf:. {stata xtcd2}}{p_end}

{pstd}
Predicting the error terms after {cmd:regress} leads to the same
result:{p_end}

{phang2}
{bf:. {stata regress d.log_rgdpo log_hc log_ck log_ngd}}{p_end}
{phang2}
{bf:. {stata predict res, residuals}}{p_end}
{phang2}
{bf:. {stata xtcd2 res}}{p_end}

{pstd}
The test statistic is 36.34 and the p-value is 0, therefore rejecting the null
hypothesis of weak CD.{p_end}

{pstd}
To draw a density plot with the cross correlations, use the {cmd:kdensity}
option:{p_end}

{phang2}
{bf:. {stata xtcd2 res, kdensity}}{p_end}

{pstd}
Testing the variable {cmd:log_rgdpo} for CD reads:{p_end}

{phang2}
{bf:. {stata xtcd2 log_rgdpo, noestimation}}{p_end}


{marker stored}{title:Stored results}

{pstd}
{cmd:xtcd2} stores the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(cd)}}CD test statistic{p_end}
{synopt:{cmd:r(p)}}p-value of CD test statistic{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(rho)}}cross correlation matrix, if requested{p_end}


{marker references}{title:References}

{phang}
Chudik, A., and M. H. Pesaran. 2015. Large panel data models with
cross-sectional dependence: A survey. In
{it:The Oxford Handbook Of Panel Data}, ed. B. H. Baltagi, 3-45.
Oxford: Oxford University Press.
{browse "https://doi.org/10.1093/oxfordhb/9780199940042.013.0001"}.

{phang}
Pesaran, M. H. 2015. Testing weak cross-sectional dependence in large panels.
{it:Econometric Reviews} 34: 1089-1117. 
{browse "https://doi.org/10.1080/07474938.2014.956623"}.


{marker ack}{...}
{title:Acknowledgments}

{pstd}
Thanks to Achim Ahrens for providing many helpful comments to the code and to
an anonymous reviewer for many helpful comments.{p_end}


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
Help:  {helpb xtdcce2}, {helpb xtcse2} (if installed){p_end}
