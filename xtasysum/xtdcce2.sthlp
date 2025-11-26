{smcl}
{* *! version 2.0 - 13. July 2019}{...}
{cmd:help xtdcce2}{right: ({browse "https://doi.org/10.1177/1536867X211045560":SJ21-3: st0536_1})}
{hline}

{title:Title}

{p2colset 5 16 18 2}{...}
{p2col :{cmd:xtdcce2} {hline 2}}Fitting heterogeneous coefficient models using common-correlated effects in a dynamic panel with many observations over groups and time periods{p_end}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
{cmd:xtdcce2} {depvar} [{indepvars}] [{cmd:(}{it:varlist2} {cmd:=} {it:varlist_iv}{cmd:)}] 
{ifin}{cmd:,}
{{opt cr:osssectional(varlist_cr)}|{cmdab:nocross:sectional}}
[{opt p:ooled(varlist_p)}
{opt cr_lags(integers)}
{opt ivreg2:options(options1)} 
{cmd:e_ivreg2}
{cmd:ivslow}
{cmdab:noi:sily}
{cmdab:pooledc:onstant}
{cmdab:reportc:onstant}
{cmdab:noconst:ant}
{cmd:trend}
{cmdab:pooledt:rend}
[{cmdab:jack:knife}|{cmdab:rec:ursive}]
{cmd:nocd}
{cmd:fullsample}
{cmdab:showi:ndividual}
{opt pooledvce(type)}
{cmd:fast}
{opt lr(varlist_lr)}
{opt lr_options(options2)} 
{cmdab:expo:nent}
{opt xtcse2:options(options3)}
{cmdab:blockdiag:use}
{cmdab:nodim:check}
{cmd:useinvsym}
{cmd:useqr}
{cmdab:noomit:ted}
{cmd:showomitted}]{p_end}

{pstd}
where {it:varlist2} are endogenous variables and {it:varlist_iv} are the instruments.{p_end}
{pstd}
Data must be {cmd:xtset} before using {cmd:xtdcce2}; see {helpb xtset}.{break}
{it:varlist}s may contain time-series operators ({help tsvarlist}) or factor
variables (see {help fvvarlist} and note on
{help xtdcce2##collinearity:collinearity issues}).{break}
{cmd:xtdcce2} requires the {helpb moremata} package (Jann 2005).{p_end}


{title:Contents}

{p 4 4 2}{help xtdcce2##description:Description}{p_end}
{p 4 4 2}{help xtdcce2##options:Options}{p_end}
{p 4 4 2}{help xtdcce2##model:Econometric and empirical models}{p_end}
{p 8 8 2}{help xtdcce2##EconometricModel:Econometric model}{p_end}
{p 8 8 2}{help xtdcce2##EmpiricalModel:Empirical model}{p_end}
{p 8 8 2}{help xtdcce2##R2:Coefficient of determination (R2)}{p_end}
{p 8 8 2}{help xtdcce2##collinearity:Collinearity issues}{p_end}
{p 4 4 2}{help xtdcce2##postestimation:Postestimation commands}{p_end}
{p 4 4 2}{help xtdcce2##examples:Examples}{p_end}
{p 4 4 2}{help xtdcce2##stored_results:Stored results}{p_end}
{p 4 4 2}{help xtdcce2##references:References}{p_end}
{p 4 4 2}{help xtdcce2##ack:Acknowledgments}{p_end}
{p 4 4 2}{help xtdcce2##author:Author}{p_end}
{p 4 4 2}{help xtdcce2##ChangeLog:Changelog}{p_end}
{p 4 4 2}{help xtdcce2##also_see:Also see}{p_end}


{marker description}{title:Description}

{pstd}
{cmd:xtdcce2} fits a heterogeneous coefficient model in a large panel with
dependence between cross-sectional units.  A panel is large if the number of
cross-sectional units (or groups) and the number of time periods are going to
infinity.

{pstd}
It fits the following estimation methods:

{p 8 12 2}
1.  the mean-group (MG) estimator (Pesaran and Smith 1995);

{p 8 12 2}
2.  the common-correlated effects (CCE) estimator (Pesaran 2006); and

{p 8 12 2}
3.  the dynamic common-correlated effects (DCCE) estimator (Chudik and Pesaran
2015).

{pstd}
For a dynamic model, several methods to estimate long-run effects are possible:{p_end}

{p 8 12 2}
1.  the pooled mean-group (PMG) estimator (Pesaran, Shin, and Smith 1999)
based on an error-correction model;

{p 8 12 2}
2.  the cross-sectional augmented distributed lag (CS-DL) estimator (Chudik
et. al 2016), which directly estimates the long-run coefficients from a
dynamic equation; and

{p 8 12 2}
3.  the cross-sectional autoregressive distributed lag (CS-ARDL) estimator
(Chudik et. al 2016) using an autoregressive distributed lag (ARDL)
model.{p_end}

{pstd}
For further discussion, see Ditzen (2019).  Additionally, {cmd:xtdcce2} tests
for cross-sectional dependence (CD) (see {helpb xtcd2}) and estimates the
exponent of the CD alpha (see {helpb xtcse2}).  It also supports
instrumental-variable (IV) estimations (see {helpb ivreg2}).{p_end}


{marker options}{title:Options}

{phang}
{opt crosssectional(varlist_cr)} defines the variables that are added as
cross-sectional averages to the equation.  Variables in {cmd:crosssectional()}
may be included in {cmd:pooled()}, {cmd:exogenous_vars()},
{cmd:endogenous_vars()}, and {cmd:lr()}.  Variables in {cmd:crosssectional()}
are partialed out, and the coefficients are not estimated and reported.

{phang2}
{cmd:crosssectional(_all)} adds all variables as cross-sectional averages.
No cross-sectional averages are added if {cmd:crosssectional(_none)} is used,
which is equivalent to {cmd:nocrosssectional}.

{phang2}
{cmd:crosssectional()} is required but can be substituted by
{cmd:nocrosssectional}.

{phang}
{cmd:nocrosssectional} suppresses adding any cross-sectional averages.
Results will be equivalent to the MG estimator or, if {cmd:lr()} is specified,
to the PMG estimator.{p_end}

{phang}
{opt pooled(varlist_p)} specifies variables whose estimated coefficients are
constrained to be equal across all cross-sectional units.  Variables may occur
in {indepvars}.  Variables in {cmd:exogenous_vars()}, {cmd:endogenous_vars()},
and {cmd:lr()} may be pooled as well.{p_end}

{phang}
{opt cr_lags(integers)} sets the number of lags of the cross-sectional
averages.  If not defined but {cmd:crosssectional()} contains a {it:varlist},
then only contemporaneous cross-sectional averages are added but no lags.
{cmd:cr_lags(0)} is the equivalent.  The number of lags can be different for
different variables where the order is the same as defined in
{cmd:crosssectional()}.  For example, if {cmd:crosssectional(y x)} and only
contemporaneous cross-sectional averages of y but 2 lags of x are added, then
the equivalent is {cmd:cr_lags(0 2)}.{p_end}

{pstd}
{cmd:xtdcce2} supports IV regressions using {helpb ivreg2}.  The IV-specific
options are the following:

{phang2}
{opt ivreg2options(options1)} passes further options to {cmd:ivreg2}; see
{helpb ivreg2##s_options:ivreg2} for more information.

{phang2}
{cmd:e_ivreg2} posts all available results from {cmd:ivreg2} in {cmd:e()} with
prefix {cmd:ivreg2_}; see {helpb ivreg2##s_macros:ivreg2} macros.

{phang2}
{cmd:ivslow} requests using {cmd:ivreg2} for calculating auxiliary regressions
rather than a faster {cmd:mata} routine.  For calculating standard errors for
pooled coefficients, an auxiliary regression is performed.  In the case of an
IV regression, {cmd:xtdcce2} runs a simple IV regression for the auxiliary
regressions.  This is faster.  If {cmd:ivslow} is used, then {cmd:xtdcce2}
calls {cmd:ivreg2} for the auxiliary regression.  This is advisable as soon as
{cmd:ivreg2}-specific options are used.

{phang2}
{cmd:noisily} displays output of {cmd:ivreg2}.

{phang}
{cmd:pooledconstant} restricts the constant term to be the same across all
cross-sectional units.{p_end}

{phang}
{cmd:reportconstant} reports the constant term.  If not specified, the
constant is partialed out.{p_end}

{phang}
{cmd:noconstant} suppresses the constant term.{p_end}

{phang}
{cmd:trend} adds a linear unit-specific trend.  It may not be combined with
{cmd:pooledtrend}.{p_end}

{phang}
{cmd:pooledtrend} adds a linear common trend.  It may not be combined with
{cmd:trend}.{p_end}

{pstd}
Two methods for small-sample time-series bias correction are supported:

{phang2}
{cmd:jackknife} applies the jackknife bias-correction method.  It may not be
combined with {cmd:recursive}.

{phang2}
{cmd:recursive} applies the recursive mean-adjustment method.  It may not be
combined with {cmd:jackknife}.{p_end}

{phang}
{cmd:nocd} suppresses calculation of the CD test.  For details about the CD
test, see {helpb xtcd2}.{p_end}

{phang}
{cmd:fullsample} uses the entire sample available for calculation of
cross-sectional averages.  Any observations that are lost because of lags will
be included in calculating the cross-sectional averages (but are not included
in the estimation itself).  The option does not remove any {cmd:if}
qualifiers.  This means that if an {cmd:if} qualifier removes certain
cross-sectional units from the estimation sample, {cmd:xtdcce2} will not use
those (as specified by {cmd:if}), even if {cmd:fullsample} is used.

{phang}
{cmd:showindividual} reports unit-individual estimates in the output.{p_end}

{phang}
{cmd:pooledvce(}{it:type}{cmd:)} specifies the variance estimator for pooled
regression.  The default is the nonparametric variance estimator from Pesaran
(2006).  {it:type} can be {cmd:nw} for Newey-West heterogeneity-robust
standard errors (Pesaran 2006) or {cmd:wpn} for fixed-T-adjusted standard
errors from Westerlund, Perova, and Norkute (2019).{p_end}

{phang}
{cmd:fast} omits calculation of unit-specific standard errors.{p_end}

{pstd}
{cmd:xtdcce2} can estimate long-run coefficients.  Three models are supported:
the pooled MG models (Pesaran, Shin, and Smith 1999), similar to
{helpb xtpmg}; the CS-DL model (see {helpb xtdcce2##csdl:xtdcce2, csdl}); and
the CS-ARDL model (see {helpb xtdcce2##ardl:xtdcce2, ardl}) as developed in
Chudik et. al (2016).  No options for the CS-DL model are necessary.{p_end}

{phang2}
{opt lr(varlist_lr)} specifies the variables to be included in the long-run
cointegration vector.  The first variable or variables are the
error-correction speed of the adjustment term.  The default is to use the PMG
model.  In this case, each estimated coefficient is divided by the negative of
the long-run cointegration vector (the first variable).  If the option
{cmd:lr_options(ardl)} is used, then the long-run coefficients are estimated
as the sum over the coefficients relating to a variable divided by the sum of
the coefficients of the dependent variable.

{phang2}
{opt lr_options(options2)} specifies options for the long-run coefficients.
{it:options2} may be the following:

{phang3}
{cmd:ardl} estimates the CS-ARDL estimator.  For further details, see
{helpb xtdcce2##ardl:xtdcce2, ardl}.

{phang3}
{cmd:nodivide}, where coefficients are not divided by the error-correction
speed of adjustment vector.  Equation (6) is estimated; see
{helpb xtdcce2##pmg:xtdcce2} PMG options.

{phang3}
{cmd:xtpmgnames}, where coefficient names in {cmd:e(b)} and {cmd:e(V)} match
the name convention from {helpb xtpmg}.

{phang}
{cmd:exponent} uses {helpb xtcse2} to estimate the exponent of the
cross-sectional dependence of the residuals.  A value above 0.5 indicates CD;
see {helpb xtcse2}.{p_end}

{phang}
{opt xtcse2options(options3)} passes options to {helpb xtcse2}.

{phang}
{cmd:blockdiaguse} uses {helpb mata blockdiag} rather than an alternative
algorithm.  {cmd:mata blockdiag} is slower but might produce more stable
results.{p_end}

{phang}
{cmd:nodimcheck} specifies not to check for dimension.  Before fitting a
model, {cmd:xtdcce2} automatically checks whether the time dimension within
each panel is long enough to run an MG regression.  Panel units with an
insufficient number are automatically dropped.

{pstd}
{cmd:xtdcce2} checks for collinearity in three different ways.  It checks
whether the matrix of the cross-sectional averages is of full rank.  After
partialling out the cross-sectional averages, it checks whether the entire
model across all cross-sectional units exhibits multicollinearity.  The final
check is on a cross-sectional level.  The outcome of the checks influences
which method is used to invert matrices.  If a check fails, {cmd:xtdcce2}
posts a warning message.  The default is {helpb mata cholinv:cholinv()} and
{helpb mata invsym:invsym()} if a matrix is rank deficient.  For further
discussion, see {help xtdcce2##collinearity:collinearity issues}.

{pstd}
The following options are available to alter the behavior of {cmd:xtdcce2}
with respect to matrices not of full rank:

{phang2}
{cmd:useinvsym} calculates the generalized inverse via {helpb mata invsym}.

{phang2}
{cmd:useqr} calculates the generalized inverse via QR decomposition.  The
default is {cmd:mata cholinv}.  QR decomposition was the default for
rank-deficient matrices for {cmd:xtdcce2} preversion 1.35.

{phang2}
{cmd:noomitted} suppresses checks for collinearity.

{phang2}
{cmd:showomitted} displays a cross-sectional unit -- variable breakdown of
omitted coefficients.


{marker model}{title:Econometric and empirical models}

{marker EconometricModel}{...}
    {title:Econometric model}

{pstd}
Assume a dynamic panel-data model with heterogeneous
coefficients,{p_end}

{p 8 20 2}(1) {space 4}y(i,t) = b0(i) + b1(i)*y(i,t-1) + x(i,t)*b2(i) +
x(i,t-1)*b3(i) + u(i,t){p_end}
{p 16 18 2}u(i,t) = g(i)*f(t) + e(i,t)

{pstd}
where f(t) is an unobserved common factor loading, g(i) is a heterogeneous
factor loading, x(i,t) is a (1 x K) vector, and b2(i) and b3(i) are the
coefficient vectors.  The error e(i,t) is independent and identically
distributed, and the heterogeneous coefficients b1(i), b2(i), and b3(i) are
randomly distributed around a common mean.  It is assumed that x(i,t) is
strictly exogenous.  In the case of a static panel model [b1(i) = 0], Pesaran
(2006) shows that the mean of the coefficients 0, b2, and b3 [for example, for
b2(mg) = 1/N sum{b2(i)}] can be consistently estimated by adding
cross-sectional means of the dependent and all independent variables.  The
cross-sectional means approximate the unobserved factors.  In a dynamic
panel-data model [b1(i) <> 0], pT lags of the cross-sectional means are added
to achieve consistency (Chudik and Pesaran 2015).  The MG estimates for b1,
b2, and b3 are consistently estimated as long as N, T, and pT go to infinity.
This implies that the number of cross-sectional units and time periods is
assumed to grow with the same rate.  In an empirical setting, this can be
interpreted as N/T being constant.  A dataset with one dimension being large
compared with the other would lead to inconsistent estimates even if both
dimensions are large in number.  For example, a financial dataset on stock
market returns on a monthly basis over 30 years (T=360) of 10,000 firms would
not be sufficient.  While both dimensions can be individually interpreted as
large, they do not grow at the same rate, and the ratio would not be constant.
Therefore, an estimator relying on fixed T asymptotics and large N would be
appropriate.  On the other hand, a dataset with, say, N = 30 and T = 34 would
qualify as appropriate if N and T grow at the same rate.

{pstd}
The variance of the MG coefficient b1(mg) is estimated as{p_end}

{p 8 20 2}var{b(mg)} = 1/N sum(i=1,N) {b1(i) - b1(mg)}^2

{pstd}
or if the vector pi(mg) = {b0(mg),b1(mg)} as{p_end}

{p 8 20 2}var{pi(mg)} = 1/N sum(i=1,N) {pi(i) - pi(mg)}{p(i)-pi(mg)}'

{marker EmpiricalModel}{...}
    {title:Empirical model}

{pstd}
The empirical model of (1) without the lag of variable x is{p_end}

{p 8 20 2}(2) {space 5} y(i,t) = b0(i) + b1(i)*y(i,t-1) + x(i,t)*b2(i) + sum [d(i)*z(i,s)] + e(i,t)

{pstd}
where z(i,s) is a (1 x K+1) vector including the cross-sectional means at time
s and the sum is over s=t...t-pT.  {cmd:xtdcce2} supports several
specifications of (2).{p_end}

{pstd}
{cmd:xtdcce2} partials out the cross-sectional means internally.  For
consistency of the cross-sectional-specific estimates, the matrix z =
{z(1,1),...,z(N,T)} has to be of full-column rank.  This condition is checked
for each cross-section.  {cmd:xtdcce2} will return a warning if z is not
full-column rank.  It will, however, continue estimating the
cross-sectional-specific coefficients and then calculate the MG estimates; see
{help xtdcce2##collinearity:collinearity issues}.  The MG estimates will be
consistent.  For further reading, see Chudik and Pesaran (2015, assumption 6
and page 398).{p_end}

{pstd}
{cmd:xtdcce2} evaluates the rank condition further.  The rank condition can
fail if the constant is partialed out and one or more variables are binary.
In this case, {cmd:xtdcce2} restarts.  However, it forces the constant to be
calculated.{p_end}

{pstd}
The following models can be fit:{p_end}

    {title:1. MG}

{pstd}
If no cross-sectional averages are added [d(i) = 0], then the estimator is the
MG estimator as proposed by Pesaran and Smith (1995).  The estimated equation
is

{p 8 20 2}(3) {space 5} y(i,t) = b0(i) + b1(i)*y(i,t-1) + x(i,t)*b2(i) + e(i,t)

{pstd}
Equation (3) can be estimated by using the {cmd:nocrosssectional} option of
{cmd:xtdcce2}.  The model can be either static [b(1) = 0] or dynamic [b(1) <>
0].{p_end}

{pstd}{help xtdcce2##e_mg:See example.}{p_end}

    {title:2. CCE}

{pstd}
The model in (3) does not account for unobserved common factors between units.
To do so, add cross-sectional averages as in Pesaran (2006):{p_end}

{p 8 20 2}(4) {space 5} y(i,t) = b0(i) + x(i,t)*b2(i) + d(i)*z(i,t) + e(i,t)

{pstd}
Equation (4) is the default equation of {cmd:xtdcce2}.  Including the
dependent and independent variables in {cmd:crosssectional()} and setting
{cmd:cr_lags(0)} lead to the same result.  {cmd:crosssectional()} defines the
variables to be included in z(i,t).  Note that b1(i) is set to zero.{p_end}

{pstd}{help xtdcce2##example_cce:See example.}{p_end}

     {title:3. DCCE}

{pstd}
If a lag of the dependent variable is added, endogeneity occurs, so adding
solely contemporaneous cross-sectional averages is no longer sufficient to
achieve consistency.  However, Chudik and Pesaran (2015) show that consistency
is gained if pT lags of the cross-sectional averages are added,{p_end}

{p 8 20 2}(5) {space 5} y(i,t) = b0(i) + b1(i)*y(i,t-1) + x(i,t)*b2(i) + sum [d(i)*z(i,s)] + e(i,t)

{pstd}
where s = t,...,t-pT.  Equation (5) is estimated if the option {cmd:cr_lags()}
contains a positive number.{p_end}

{pstd}{help xtdcce2##example_dcce:See example.}{p_end}

    {title:4. Pooled estimators}

{pstd}
Equations (3)-(5) can be constrained so that the parameters are the same
across units.  Hence, the equations become{p_end}

{p 8 20 2}(3-p) {space 5} y(i,t) = b0 + b1*y(i,t-1) + x(i,t)*b2 + e(i,t){p_end}
{p 8 20 2}(4-p) {space 5} y(i,t) = b0 + x(i,t)*b2 + d(i)*z(i,t) + e(i,t){p_end}
{p 8 20 2}(5-p) {space 5} y(i,t) = b0 + b1*y(i,t-1) + x(i,t)*b2 + sum [d(i)*z(i,s)] + e(i,t)

{pstd}
Variables with pooled (homogeneous) coefficients are specified using the
{cmd:pooled()} option.  The constant is pooled by using the option
{cmd:pooledconstant}.{p_end}

{pstd}
In the case of a pooled estimation, {cmd:xtdcce2} offers the estimation of
three different types of standard errors.  The default is the nonparametric
variance estimator from Pesaran [2006, (67)-(69)].  The nonparametric
estimator accounts for the difference between the MG and individual
coefficients.  Therefore, an MG regression is performed in the background.
The first alternative estimator is the Newey-West-type
heteroskedasticity-robust standard errors from Pesaran [2006, (51), (52), and
(74)].  The length of the window size is defined as round{4*(T/100)^(2/9)} and
follows the convention for HAC standard errors (see Bai and Ng [2004]).
Another alternative is the fixed-T variance estimator from Westerlund, Perova,
and Norkute [2019, (10) and (11)].  This estimator is heteroskedasticity
robust and allows for panels with a fixed time dimension.{p_end}

{pstd}{help xtdcce2##example_pooled:See example.}{p_end}

    {title:5. IVs}

{pstd}
{cmd:xtdcce2} supports estimations of IVs by using the {helpb ivreg2} package.
Endogenous variables (to be instrumented) are defined in {it:varlist2}, and
their instruments are defined in {it:varlist_iv}.{p_end}

{pstd}{help xtdcce2##example_iv:See example.}{p_end}

{marker pmg}{...}
    {title:6. Error-correction models (PMG estimator)}

{pstd}
As an intermediate between the MG and a pooled estimation, Pesaran, Shin, and
Smith (1999) differentiate between homogeneous long-run effects and
heterogeneous short-run effects.  Therefore, the model includes MG and pooled
coefficients.  Equation (1) (without the lag of the explanatory variable x and
for a better readability without the cross-sectional averages) is transformed
into an ARDL model:{p_end}

{p 8 20 2}y(i,t) = phi(i)*{y(i,t-1) - w0(i) - x(i,t)*w2(i)} + g1(i)*[y(i,t)-y(i,t-1)] + [x(i,t) - x(i,t-1)] * g2(i) + e(i,t)

{pstd}
phi(i) is the cointegration vector, w(i) captures the long-run effects, and
g1(i) and g2(i) capture the short-run effects.  Pesaran, Shin, and Smith
(1999) estimate the long-run coefficients by maximum likelihood and the
short-run coefficients by ordinary least squares (OLS).  {cmd:xtdcce2}
estimates a slightly different version by OLS,{p_end}

{p 8 20 2}(6) {space 5}y(i,t) = o0(i) + phi(i)*y(i,t-1) + x(i,t)*o2(i) + g1(i)*[y(i,t)-y(i,t-1)] + [x(i,t) - x(i,t-1)] * g2(i) + e(i,t)

{pstd}
where w2(i) = - o2(i) / phi(i) and w0(i) = - o0(i)/phi(i).  Equation (6) is
estimated by including the levels of y and x as long-run variables using the
{cmd:lr()} and {cmd:pooled()} options and adding the first differences as
independent variables.  {cmd:xtdcce2} estimates (6) but automatically
calculates estimates for w(i) = {w0(i),...,wk(i)}.  The advantage of
estimating (6) by OLS is that one can use IV regressions and add
cross-sectional averages to account for dependencies between units.  The
variance-covariance matrix is calculated using the delta method.  For further
discussion, see Ditzen (2018).{p_end}

{pstd}{help xtdcce2##example_pmg:See example.}{p_end}

{marker csdl}{...}
    {title:7. Cross-section augmented distributed lag (CS-DL)}

{pstd}
Chudik et. al (2016) show that the long-run effect of variable x on variable y
in (1) can be directly estimated.  Therefore, they fit the following model,
based on (1):{p_end}

{p 8 20 2}(7) {space 5}y(i,t) = w0(i) + x(i,t) * w2(i)  + delta(i) * {x(i,t) -
x(i,t-1)} + sum [d(i)*z(i,s)] + e(i,t)

{pstd}
w2(i) is the long effect, and sum [d(i)*z(i,s)] are the cross-sectional
averages with an appropriate number of lags.  To account for the lags of the
dependent variable, add the corresponding number of first differences.  If the
model is an ARDL(1,1), then only the first difference of the explanatory
variable is added.  In the case of an ARDL(1,2) model, the first and the
second difference are added.  The advantage of the CS-DL approach is that no
short-run coefficients need to be estimated.

{pstd}
A general ARDL(py,px) model is fit by{p_end}

{p 8 20 2}y(i,t) = w0(i) + x(i,t) * w2(i)  + sum(l=1,px) delta(i,l) *
{x(i,t-l) - x(i,t-l-1)}  + sum [d(i)*z(i,s)] + e(i,t)

{pstd}
The MG coefficients are calculated as the unweighted averages of all
cross-sectional specific coefficient estimates.  The variance-covariance
matrix is estimated as in the case of a MG estimation.{p_end}

{pstd}{help xtdcce2##example_csdl:See example.}{p_end}

{marker ardl}{...}
    {title:8. Cross-section augmented ARDL (CS-ARDL)}

{pstd}
As an alternative approach, the long-run coefficients can be estimated by
first estimating the short-run coefficients and then estimating the long-run
coefficients.  For a general ARDL(py,px) model including cross-sectional
averages such as{p_end}

{p 8 20 2}y(i,t) = b0(i) + sum(l=1,py) b1(i,l) y(i,t-l) + sum(l=0,px) b2(i,l) x(i,t-l) +  sum [d(i)*z(i,s)] + e(i,t)

{pstd}
the long-run coefficients for the independent variables are calculated
as{p_end}

{marker eq_10}{p 8 20 2}(8) {space 5}w2(i) = sum(l=0,px) b2(i,l) / {1 - sum(l=1,py) b1(i,l)}

{pstd}
and for the dependent variable as{p_end}

{p 8 20 2}w1(i) = 1 - sum(l=1,py) b1(i,l)

{pstd}
This is the CS-ARDL estimator in Chudik et. al (2016).  The variables
belonging to w(1,i) need to be enclosed in parentheses, or {help tsvarlist}
needs to be used.  For example, coding {cmd:lr(y x L.x)} is equivalent to
{cmd:lr(y (x lx))}, where lx is a variable containing the first lag of x (lx =
L.x).  The disadvantage of this approach is that py and px need to be known.
The variance-covariance matrix is calculated using the delta method; see
Ditzen (2019).{p_end}

{pstd}{help xtdcce2##example_ardl:See example.}{p_end}

{marker R2}{...}
    {title:Coefficient of determination (R2)}

{pstd}
{cmd:xtdcce2} calculates up to three different coefficients of determination
(R2).  It calculates the standard unadjusted R2 and the adjusted R2 as is
common in the literature.  If all coefficients are either pooled or
heterogeneous, {cmd:xtdcce2} calculates an adjusted R2 following Holly,
Pesaran, and Yamagata [2010, (3.14) and (3.15)].  The R2 and adjusted R2 are
calculated even if the pooled or MG-adjusted R2 is calculated.  However, the
pooled or MG-adjusted R2 is displayed instead of the adjusted R2 if
calculated.{p_end}

{pstd}
In the case of a pure homogeneous model, the adjusted R2 is calculated as{p_end}

{p 8 20 2}R2(CCEP) = 1 - s(p)^2 / s^2

{pstd}
where s(p)^2 is the error-variance estimator from the pooled regressions and
s^2 the overall error-variance estimator.  They are defined as{p_end}

{p 8 20 2}s(p)^2 = sum(i=1,N) e(i)'e(i) / [N ( T - k - 2) - k]

{p 8 20 2}s^2 = 1/{N (T -1)} sum(i=1,N) sum(t=1,T) {y(i,t) - ybar(i) }^2

{pstd}
where k is the number of regressors, {cmd:e(i)} is a vector of residuals, and
{cmd:ybar(i)} is the cross-sectional specific mean of the dependent
variable.{p_end}

{pstd}
For MG regressions, the adjusted R2 is the mean of the cross-sectional
individual R2 weighted by the overall error variance:{p_end}

{p 8 20 2}R2(CCEMG) = 1 - s(mg)^2 / s^2

{p 8 20 2}s(mg)^2 = 1/N sum(i=1,N) e(i)'e(i) / [T - 2k - 2].

{marker collinearity}{...}
    {title:Collinearity issues}

{pstd}
(Multi)collinearity in a regression model means that two or more explanatory
variables are linearly dependent.  The individual effect of a collinear
explanatory variable on the dependent variable cannot be differentiated from
the effect of another collinear explanatory variable.  This implies it is
impossible to estimate the individual coefficient of the collinear explanatory
variables.  If the explanatory variables are stacked into matrix X and one or
more variables (columns) in X are collinear, then X'X is rank deficient.
Therefore, it cannot be inverted, and the OLS estimate of beta =
inverse(X'X)X'Y does not exist.{p_end}

{pstd}
In a model in which CD and in which dependence is approximated by
cross-sectional averages, collinearity can easily occur.  The empirical model
({help xtdcce2##EmpiricalModel:2}) can exhibit collinearity in four
ways:{p_end}

{p 8 12 2}
1.  In the cross-sectional averages, {z(i,s)} stacked in Z are collinear.

{p 8 12 2}
2.  The cross-sectional averages and the explanatory variables are collinear.

{p 8 12 2}
3.  In the global set of model of explanatory variables [the constant,
y(i,t-1), x(i,t), x(i,t-1) stacked in X] are collinear for {cmd:all i}.

{p 8 12 2}
4.  In a cross-sectional unit-specific model of explanatory variables [the
constant, y(i,t-1), x(i,t), x(i,t-1) stacked in X(i)] are collinear for
{cmd:some i}.

{pstd}
{cmd:xtdcce2} checks all types of collinearity and, according to the prevalent
type, decides how to continue and invert (X'X).  It uses as a default
{helpb mata cholinv:cholinv()}.  If a matrix is rank deficient, it uses
{helpb mata invsym:invsym()}, where variables (columns) are removed from the
right.  If X = (X1 X2 X3 X4) and X1 and X4 are collinear, then X4 will be
removed.  This is done by 
{help mf_invsym##remarks2:{bf:invsym()}, specifying the order in which columns are dropped}.
Older versions of {cmd:xtdcce2} used {helpb mata qrinv:qrinv()} for
rank-deficient matrices.  However, results can be unstable, and no order of
which columns are to be dropped can be specified.  The use of
{helpb mata qrinv:qrinv()} for rank-deficient matrices can be enforced with
the option {cmd:useqr}.{p_end}

{pstd}
{cmd:xtdcce2} takes the following steps if{p_end}

{p 8 12 2}1.  {cmd:Z'Z is not of full rank}{break}
Before partialling out, {cmd:xtdcce2} checks if Z'Z is of full rank.  When Z'Z
is rank deficient, then {cmd:xtdcce2} will return a warning.  Cross-section
unit-specific estimates are not consistent.  However, the MG estimates are.
See Chudik and Pesaran (2015, assumption 6 and page 398).{p_end}

{p 8 12 2}2.  {cmd:The cross-sectional averages and the explanatory variables are collinear.}{break}
In this case, regressors from the right are dropped.  This means the
cross-sectional averages are dropped.  This case corresponds to the first
because the cross-sectional averages are regressors for the partialling
out.{p_end}

{p 8 12 2}3.  {cmd:X'X is collinear for all i.}{break}
{cmd:xtdcce2} uses {helpb _rmcoll} to remove any variables that are collinear
on the global level.  A message with the list of omitted variables will be
posted.  A list of omitted variables is posted in {cmd:e(omitted_var)} and the
number in {cmd:e(K_omitted)}.

{p 8 12 2}4.  {cmd:X(i)'X(i) is collinear for some i.}{break}
{cmd:xtdcce2} automatically drops variables (columns) from the right for those
cross-sectional units with collinear variables (columns).  An error message
appears.  More details can be obtained using the option {cmd:showomitted} by
showing a matrix with a detailed breakdown on a cross-section variable level.
The matrix is stored in {cmd:e(omitted_var_i)} as well.{p_end}

{pstd}
Results obtained with {cmd:xtdcce2} can differ from those obtained with
{helpb regress} or {helpb xtmg}.  The reasons are that {cmd:xtdcce2} partialed
out the cross-sectional averages and enforced the use of doubles; both are not
done in {cmd:xtmg}.  In addition, it uses as a default a different algorithm
to invert matrices.{p_end}

{pstd}
The use of factor variables together with cross-sectional averages can lead to
collineaity issues.  For example, in a dataset with the time identifier
{cmd:year}, adding a time dummy using {cmd:i.year} implicitly creates a dummy
for each year.  These variables will be collinear with the cross-sectional
averages.  {cmd:xtdcce2} tries to control for collinearity but might fail when
using factor variables.  In general, care is required when combining factor
variables and cross-sectional averages.{p_end}



{marker postestimation}{title:Postestimation commands}

{pstd}
{cmd:predict} and {cmd:estat} can be used after {cmd:xtdcce2}.

    {title:predict}

{pstd}
The syntax for {cmd:predict} is

{p 8 15 2}
{cmd:predict} [{it:type}] {newvar} {ifin} 
[{cmd:,} {it:options}]

{synoptset 20}{...}
{synopthdr}
{synoptline}
{synopt :{cmd:xb}}calculate linear prediction on partialed-out variables{p_end}
{synopt :{cmd:xb2}}calculate linear prediction on nonpartialed-out variables{p_end}
{synopt :{cmd:stdp}}calculate standard error of the prediction{p_end}
{synopt :{cmdab:r:esiduals}}calculate residuals [e(i,t)]{p_end}
{synopt :{cmdab:cfr:esiduals}}calculate residuals, including the common factors [u(i,t)]{p_end}
{synopt :{cmdab:coeff:icient}}a variable with the estimated cross-section-specific
values for all coefficients is created; the name of the new variable
is {it:newvar}{cmd:_}{it:varname}{p_end}
{synopt :{cmd:se}}as {cmd:coefficient}, but with standard error
instead{p_end}
{synopt :{cmd:partial}}create new variables with the partialed-out
values{p_end}
{synopt :{cmd:replace}}replace the variable if existing{p_end}
{synoptline}

{pstd}
Option {cmd:xb2} is equivalent to calculating the coefficients and then
multiplying
the explanatory variables with it, while {cmd:xb} first partials out the
cross-sectional averages and then multiplies the coefficients.  The following
table summarizes the differences with the command line
{cmd:xtdcce2 y x, nocrosssectional}:{p_end}

{col 10}{cmd:xb} {col 43}{cmd:xb2}
{col 10}1. {bf:{stata predict coeff, coeff}} {col 43}1. {bf:{stata predict coeff, coeff}}
{col 10}2. {bf:{stata predict partial, partial}} {col 43}2. {bf:{stata gen xb2 = coeff_x * x}}
{col 10}3. {bf:{stata gen xb = coeff_x * partial_x}} {col 43}

{pstd}
{cmd:xtdcce2} can calculate both residuals from (1).  {cmd:predict}
{newvar}{cmd:,} {cmd:residuals} calculates e(i,t).  That is, the residuals of
the regression with the cross-sectional averages are partialed out.
{cmd:predict} {it:newvar}{cmd:,} {cmd:cfresiduals} calculates u(i,t) =
g(i)*f(g) + e(i,t), that is, the error including the cross-sectional averages.
Internally, the fitted values are calculated and then subtracted from the
dependent variable.  Therefore, note that if a constant is used, the constant
needs to be reported using the {cmd:xtdcce2} option {cmd:reportconstant}.
Otherwise, u(i,t) includes the constant as well [u(i,t) = b0(i) + g(i)*f(g) +
e(i,t)].{p_end}

{pstd}
The following table summarizes this, where y and x are the original variables
and ytilde and xtilde are y and x with the common factors partialed
out:{p_end}

{p 13 20 2} y(i,t) = x(i,t) * beta(i) + gamma(i)*f(t) +
e(i,t){p_end}
{p 8 20 2} ytilde(i,t) = xtilde(i,t)* beta(i) + gamma(i)*f(t) + e(i,t)

{col 10}Variable {col 35} predict option
{col 11} x(i,t)*beta(i) {col 37}{cmd:xb2}
{col 11} xtilde(i,t)*beta(i) {col 37}{cmd:xb}
{col 11} e(i,t) {col 37}{cmd:residuals}
{col 11} gamma(i)*f(t) + e(i,t) {col 37}{cmd:cfresiduals} 

    {title:estat}

{pstd}
{cmd:estat} can be used to create a box, bar, or range plot.  The syntax is

{p 8 13 2}
{cmd:estat} {it:graphtype} [{varlist}] {ifin}
[{cmd:,} {it:options}]

{synoptset 20}{...}
{synopthdr:graphtype}
{synoptline}
{synopt :{cmd:box}}box plot; see {helpb graph bar}{p_end}
{synopt :{cmd:bar}}bar plot; see {helpb graph box}{p_end}
{synopt :{cmd:rcap}}range plot; see {helpb twoway rcap}{p_end}
{synoptline}

{synoptset 20}{...}
{synopthdr}
{synoptline}
{synopt :{cmdab:i:ndividual(}{it:string}{cmd:)}}pass options for individual graphs (only {cmd:bar} and {cmd:rcap}); see {it:{help twoway_options}}{p_end}
{synopt :{cmdab:c:ombine(}{it:string}{cmd:)}}pass options for combined graphs; see {it:{help twoway_options}}{p_end}
{synopt :{cmd:nomg}}MG point estimate and confidence interval are not included in bar and range plot graphs{p_end}
{synopt :{cmdab:clearg:raph}}clear the option of the graph command; best used in combination with the {cmd:combine()} and {cmd:individual()} options{p_end}
{synoptline}

{pstd}
The name of the combined graph is saved in {cmd:r(graph_name)}.{p_end}


{marker examples}{title:Examples}

{pstd}
Load the example dataset of the Penn World Tables 8.  The dataset contains
yearly observations from 1960 until 2007 and is already {cmd:xtset}.

{phang2}{bf:. {stata use xtdcce2_sample_dataset}}{p_end}

{pstd}
To estimate a growth equation, use the following variables: {cmd:log_rgdpo}
(real gross domestic product), {cmd:log_hc} (human capital), {cmd:log_ck}
(physical capital), and {cmd:log_ngd} (population growth + break even
investments of 5%).{p_end}

{marker e_mg}{...}
    {title:MG estimation}

{pstd}
To estimate (3), use the option {cmd:nocrosssectional}.  To obtain estimates
for the constant, use the option {cmd:reportconstant}.

{phang2}{bf:. {stata xtdcce2 d.log_rgdpo L.log_rgdpo log_hc log_ck log_ngd, nocrosssectional reportconstant}}{p_end}

{pstd}
Omitting {cmd:reportconstant} leads to the same result.  However, the constant
is partialed out:{p_end}

{phang2}{bf:. {stata xtdcce2 d.log_rgdpo L.log_rgdpo log_hc log_ck log_ngd, nocrosssectional}}{p_end}

{marker example_cce}{...}
    {title:CCE}

{pstd}
CCE (static) models can be fit in several ways.  The first possibility is
without any options related to cross-sectional averages:{p_end}

{phang2}{bf:. {stata xtdcce2 d.log_rgdpo log_hc log_ck log_ngd, crosssectional(_all) reportconstant}}{p_end}

{pstd}
Note that because this is a static model, the lagged dependent variable does
not occur, and only contemporaneous cross-sectional averages are used.
Defining all independent and dependent variables in {cmd:crosssectional()}
leads to the same result:{p_end}

{phang2}{bf:. {stata xtdcce2 d.log_rgdpo log_hc log_ck log_ngd, reportconstant crosssectional(d.log_rgdpo log_hc log_ck log_ngd)}}{p_end}

{pstd}
The default for the number of cross-sectional lags is zero, implying only
contemporaneous cross-sectional averages are used.  Finally, the number of
lags can also be specified using the {cmd:cr_lags()} option.{p_end}

{phang2}{bf:. {stata xtdcce2 d.log_rgdpo log_hc log_ck log_ngd, reportconstant crosssectional(d.log_rgdpo log_hc log_ck log_ngd) cr_lags(0)}}{p_end}

{pstd}
All three command lines are equivalent and lead to the same estimation
results.{p_end}

{pstd}
To check if residuals still exhibit CD, the estimation of the exponent of CD
can be estimated as well.{p_end}

{phang2}
{bf:. {stata xtdcce2 d.log_rgdpo log_hc log_ck log_ngd, reportconstant crosssectional(d.log_rgdpo log_hc log_ck log_ngd) cr_lags(0) exponent}}{p_end}

{pstd}
Alternatively, the exponent can be estimated afterwards using
{helpb xtcse2}.{p_end}

{marker example_dcce}{...}
    {title:DCCE}

{pstd}
The lagged dependent variable is added to the model again.  To estimate the MG
coefficients consistently, set the number of lags to 3:{p_end}

{phang2}
{bf:. {stata xtdcce2 d.log_rgdpo L.log_rgdpo log_hc log_ck log_ngd, reportconstant crosssectional(d.log_rgdpo L.log_rgdpo log_hc log_ck log_ngd) cr_lags(3)}}{p_end}

    {title:Using predict}

{pstd}
{cmd:predict,} [{it:options}] can be used to predict the linear prediction,
the residuals, coefficients, and the partialed-out variables.  To predict the
residuals, use the option {cmd:residuals}:{p_end}

{phang2}
{bf:. {stata predict residuals, residuals}}

{pstd}
The residuals do not contain the partialed-out factors; that is, they are
e(i,t) in (1) and (2).  To estimate u(i,t), the error term containing the
common factors, use the option {cmd:cfresiduals}:{p_end}

{phang2}
{bf:. {stata predict uit, cfresiduals}}

{pstd}
Similarly, the linear prediction (option {cmd:xb}, the default) and the
standard error of the prediction can be obtained.  The unit-specific estimates
for each variable and the standard error can be obtained using the option
{cmd:coefficient} or {cmd:se}.  For example, obtain the coefficients for
{cmd:log_hc} from the regression above and calculate the mean, which should be
the same as the MG estimate:{p_end}

{phang2}
{bf:. {stata predict coeff, coefficient}}{p_end}
{phang2}
{bf:. {stata summarize coeff_log_hc}}{p_end}

{pstd}
The partialed-out variables can be obtained using{p_end}

{phang2}
{bf:. {stata predict partial, partial}}{p_end}

{pstd}
Then, a regression on the variables would lead to the same results as above.
If the option {cmd:replace} is used, then the {newvar} is replaced if it
exists.{p_end}

{marker example_pooled}{...}
    {title:Pooled estimations}

{pstd}
All coefficients can be pooled by including them in {cmd:pooled()}.  The
constant is pooled by using the {cmd:pooledconstant} option:{p_end}

{phang2}{bf:. {stata xtdcce2 d.log_rgdpo L.log_rgdpo log_hc log_ck log_ngd, reportconstant crosssectional(d.log_rgdpo L.log_rgdpo log_hc log_ck log_ngd) pooled(L.log_rgdpo log_hc log_ck log_ngd) cr_lags(3) pooledconstant}}{p_end}

{marker example_iv}{...}
    {title:IVs}

{pstd}
Endogenous variables can be instrumented by using the options
{cmd:endogenous_vars()} and {cmd:exogenous_vars()}.  Internally,
{helpb ivreg2} estimates the individual coefficients.  Using the lagged level
of physical capital as an instrument for the contemporaneous level leads
to{p_end}

{phang2}
{bf:. {stata xtdcce2 d.log_rgdpo L.log_rgdpo log_hc log_ck log_ngd  (log_ck = L.log_ck), reportconstant crosssectional(d.log_rgdpo L.log_rgdpo  log_hc log_ck log_ngd) cr_lags(3) ivreg2options(nocollin noid)}}{p_end}

{pstd}
Further {cmd:ivreg2} options can be passed through using
{cmd:ivreg2options()}.  Stored values in {cmd:e()} from {cmd:ivreg2options()}
can be posted using the option {cmd:fulliv}.

{marker example_pmg}{...}
    {title:Error-correction models (PMG estimator)}

{pstd}
Variables of the long-run cointegration vector are defined in {cmd:lr()},
where the first variable is the error-correction speed of the adjustment term.
To ensure homogeneity of the long-run effects, you must include the
corresponding variables in the {cmd:pooled()} option.{p_end}

{pstd}
Following the example from Blackburne and Frank (2007) with {cmd:jasa2.dta},

{phang2}
{bf:. {stata use jasa2, clear}}{p_end}
{phang2}
{bf:. {stata xtdcce2 d.c d.pi d.y if year >= 1962, lr(L.c pi y) p(L.c pi y) crosssectional(_all) cr_lags(2)}}{p_end}

{pstd}
{cmd:xtdcce2} internally estimates (6) and then recalculates the long-run
coefficients such that estimation results for (7) are obtained.  Equation (6)
can be estimated by adding {cmd:nodivide} to {cmd:lr_options()}.  A second
option is {cmd:xtpmgnames} to match the naming convention from {helpb xtpmg}.

{phang2}{bf:. {stata xtdcce2 d.c d.pi d.y if year >= 1962, lr(L.c pi y) p(L.c pi y) crosssectional(_all) cr_lags(2) lr_options(nodivide)}}{p_end}

{phang2}{bf:. {stata xtdcce2 d.c d.pi d.y if year >= 1962, lr(L.c pi y) p(L.c pi y) crosssectional(_all) cr_lags(2) lr_options(xtpmgnames)}}{p_end}

{marker example_csdl}{...}
    {title:Cross-section augmented distributed lag (CS-DL)}

{pstd}
Chudik et. al (2013) estimate the long-run effects of public debt on output
growth.  In the dataset, the dependent variable is {cmd:d.y}, and the
independent variables are the inflation rate ({cmd:dp}) and debt to GDP ratio
({cmd:d.gd}).  For an ARDL(1,1,1), only the first differences of {cmd:dp} and
{cmd:d.gd} are added as further covariates.  Only a contemporaneous lag of the
cross-sectional averages (that is, {cmd:cr_lags(0)}) of the dependent variable
and three lags of the independent variables are added.  The lag structure is
implemented by defining a {it:numlist} rather than a number in
{cmd:cr_lags()}.  For the example here, {cmd:cr_lags(0 3 3)} is used, where
the first number refers to the first variable defined in
{cmd:crosssectional()}, the second to the second, etc.{p_end}

{pstd}
To replicate the results in table 18, use the following command lines:{p_end}

{phang2}
{bf:. {stata use cmpr, clear}}{p_end}
{phang2}
{bf:. {stata xtset ccode year}}{p_end}
{phang2}
{bf:. {stata generate double y=ln(gdp)}}{p_end}
{phang2}
{bf:. {stata generate double dy=d.y}}{p_end}
{phang2}
{bf:. {stata generate double p=ln(cpi)}}{p_end}
{phang2}
{bf:. {stata generate double dp=d.p}}{p_end}
{phang2}
{bf:. {stata generate double gd=ln(gdebt)}}{p_end}
{phang2}
{bf:. {stata generate double dgd = d.gd}}{p_end}
{phang2}
{bf:. {stata xtdcce2 d.y dp d.gd d.(dp d.gd), crosssectional(d.y dp d.gd) cr_lags(0 3 3) fullsample}}{p_end}

{pstd}
For an ARDL(1,3,3) model, the first and second lags are of the first differences
that are added by putting {cmd:L(0/2)} in front of {cmd:d.(dp d.gd)}:{p_end}

{phang2}
{bf:. {stata xtdcce2 d.y dp d.gd L(0/2).d.(dp d.gd), crosssectional(d.y dp d.gd) cr_lags(0 3 3) fullsample}}{p_end}

{pstd}
Note that the {cmd:fullsample} option is used to reproduce the results in Chudik
et. al (2013).{p_end}

{marker example_ardl}{...}
    {title:Cross-section augmented ARDL (CS-ARDL)}

{pstd}
Besides the CS-DL model, Chudik et. al (2013) fit a CS-ARDL model.  To fit
this model, treat all variables as long-run coefficients and add them to
{varlist} in {cmd:lr()}.  {cmd:xtdcce2} first estimates the short-run
coefficients and then calculates the long-run coefficients, following
{help xtdcce2##eq_10:(8)}.  The option {cmd:lr_options(ardl)} is used to
invoke the estimation of the long-run coefficients.  Variables with the same
base (that is, forming the same long-run coefficient) need to be enclosed in
parentheses, or {help tsvarlist} operators need to be used.  In table 17, an
ARDL(1,1,1) model is fit with 3 lags of the cross-sectional averages:{p_end}

{phang2}
{bf:. {stata xtdcce2 d.y, lr(L.d.y dp L.dp d.gd L.d.gd) lr_options(ardl) crosssectional(d.y dp d.gd) cr_lags(3) fullsample}}{p_end}

{pstd}
{cmd:xtdcce2} calculates the long-run effects identifying the variables by
their base.  For example, it recognizes that {it:dp} and {it:L.dp} relate to
the same variable.  If the lag of {it:dp} is called {it:ldp}, then the
variables need to be enclosed in parentheses.{p_end}

{pstd}
Fitting the same model but as an ARDL(3,3,3) and with enclosed parentheses
reads{p_end}

{phang2}
{bf:. {stata xtdcce2 d.y, lr((L(1/3).d.y) (L(0/3).dp) (L(0/3).d.gd)) lr_options(ardl) crosssectional(d.y dp d.gd) cr_lags(3) fullsample}}{p_end}

{pstd}
which is equivalent to coding without parentheses:{p_end}

{phang2}
{bf:. {stata xtdcce2 d.y, lr(L(1/3).d.y L(0/3).dp L(0/3).d.gd) lr_options(ardl) crosssectional(d.y dp d.gd) cr_lags(3) fullsample}}{p_end}


{marker stored_results}{title:Stored results}

{pstd}
{cmd:xtdcce2} stores the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_g)}}number of groups (cross-sectional units){p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(df_r)}}residual degree of freedom{p_end}
{synopt:{cmd:e(T)}}number of time periods{p_end}
{synopt:{cmd:e(K_mg)}}number of regressors (excluding variables partialed out){p_end}
{synopt:{cmd:e(N_partial)}}number of partialed-out variables{p_end}
{synopt:{cmd:e(K_omitted)}}number of omitted variables (global level){p_end}
{synopt:{cmd:e(N_pooled)}}number of pooled (homogeneous) coefficients{p_end}
{synopt:{cmd:e(mss)}}model sum of squares{p_end}
{synopt:{cmd:e(rss)}}residual sum of squares{p_end}
{synopt:{cmd:e(F)}}F statistic{p_end}
{synopt:{cmd:e(rmse)}}root mean squared error{p_end}
{synopt:{cmd:e(r2)}}R-squared{p_end}
{synopt:{cmd:e(r2_a)}}R-squared adjusted{p_end}
{synopt:{cmd:e(r2_pmg)}}pooled or MG R-squared adjusted{p_end}
{synopt:{cmd:e(cd)}}CD test statistic{p_end}
{synopt:{cmd:e(cdp)}}p-value of CD test statistic{p_end}
{synopt:{cmd:e(Tmin)}}minimum time (only unbalanced panels){p_end}
{synopt:{cmd:e(Tbar)}}average time (only unbalanced panels){p_end}
{synopt:{cmd:e(Tmax)}}maximum time (only unbalanced panels){p_end}
{synopt:{cmd:e(cr_lags)}}number of lags of cross-sectional averages{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:xtdcce2}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(indepvar)}}name of independent variables{p_end}
{synopt:{cmd:e(tvar)}}name of time variable{p_end}
{synopt:{cmd:e(idvar)}}name of unit variable{p_end}
{synopt:{cmd:e(omitted)}}omitted variables{p_end}
{synopt:{cmd:e(lr)}}variables in long-run cointegration vector{p_end}
{synopt:{cmd:e(pooled)}}pooled (homogeneous) coefficients{p_end}
{synopt:{cmd:e(insts)}}instruments (exogenous) variables (only IV){p_end}
{synopt:{cmd:e(istd)}}instrumented (endogenous) variables (only IV){p_end}
{synopt:{cmd:e(omitted_var)}}variable list with omitted variables
(global){p_end}
{synopt:{cmd:e(omitted_var_i)}}matrix of omitted variables on cross-section --
variable level{p_end}
{synopt:{cmd:e(version)}}{cmd:xtdcce2} version if {bf:{stata xtdcce2, version}} used{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix{p_end}
{synopt:{cmd:e(bi)}}coefficient vector of individual and pooled coefficients{p_end}
{synopt:{cmd:e(Vi)}}variance-covariance matrix of individual and pooled coefficients{p_end}
{synopt:{cmd:e(alpha)}}estimates of the exponent of CD{p_end}
{synopt:{cmd:e(alphaSE)}}estimates of the standard-error exponent of CD{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}

{pstd}
Estimated long-run coefficients of the ARDL model are marked with the
prefix {cmd:lr_}.


{marker references}{...}
{title:References}

{phang}
Bai, J., and S. Ng. 2004.
A PANIC attack on unit roots and cointegration. {it:Econometrica} 72:
1127-1177.  {browse "https://doi.org/10.1111/j.1468-0262.2004.00528.x"}.

{phang}
Blackburne,  E. F., III, and M. W. Frank. 2007.
Estimation of nonstationary heterogeneous panels.
{it:Stata Journal} 7: 197-208. {browse "https://doi.org/10.1177/1536867X0700700204"}.

{phang}
Chudik, A., K. Mohaddes, M. Pesaran, and M. Raissi. 2013.
Debt, inflation and growth: Robust estimation of long-run effects in dynamic panel data models.
Federal Reserve Bank of Dallas, Globalization and Monetary Policy Institute
Working Paper No. 162. {browse "https://www.dallasfed.org/~/media/documents/institute/wpapers/2013/0162.pdf"}.
  
{phang}
------. 2016.
Long-run effects in large heterogeneous panel data models with
cross-sectionally correlated errors. In 
{it:Essays in Honor of Aman Ullah (Advances in Econometrics, Volume 36)}, ed.
G. Gonz{c a'}lez-Rivera, R. C. Hill, and T.-H. Lee, 85-135. Bingley, UK: Emerald.
{browse "https://doi.org/10.1108/S0731-905320160000036013"}.

{phang}
Chudik, A., and M. H. Pesaran. 2015.
Common correlated effects estimation of heterogeneous dynamic panel data
models with weakly exogenous regressors.
{it:Journal of Econometrics} 188: 393-420. 
{browse "https://doi.org/10.1016/j.jeconom.2015.03.007"}.

{phang}
Ditzen, J. 2018. Estimating dynamic common-correlated effects in Stata.
{it:Stata Journal} 18: 585-617.
{browse "https://doi.org/10.1177/1536867X1801800306"}.

{phang}
------. 2019. Estimating long run effects in models with cross-sectional dependence using xtdcce2. 
CEERP Working Paper No. 7.
{browse "https://ceerp.hw.ac.uk/RePEc/hwc/wpaper/007.pdf"}.

{phang}
Holly, S., M. H. Pesaran, and T. Yamagata. 2010.
A spatio-temporal model of house prices in the USA. 
{it:Journal of Econometrics} 158: 160-173.
{browse "https://doi.org/10.1016/j.jeconom.2010.03.040"}.

{phang}
Jann, B. 2005. 
moremata: Stata module (Mata) to provide various functions. 
Statistical Software Components S455001, Department of Economics, Boston
College. {browse "http://ideas.repec.org/c/boc/bocode/s455001.html"}.

{phang}
Pesaran, M. H. 2006.
Estimation and inference in large heterogeneous panels with a multifactor error structure.
{it:Econometrica} 74: 967-1012. {browse "https://doi.org/10.1111/j.1468-0262.2006.00692.x"}.

{phang}
Pesaran, M. H., Y. Shin, and R. P. Smith. 1999.
Pooled mean group estimation of dynamic heterogeneous panels.
{it:Journal of the American Statistical Association} 94: 621-634.
{browse "https://doi.org/10.2307/2670182"}.

{phang}
Pesaran, M. H., and R. Smith. 1995.
Estimating long-run relationships from dynamic heterogeneous panels.
{it:Journal of Econometrics} 68: 79-113.
{browse "https://doi.org/10.1016/0304-4076(94)01644-F"}.

{phang}
Westerlund, J., Y. Perova, and M. Norkute. 2019. CCE in fixed-T panels. 
{it:Journal of Applied Econometrics} 34: 746-761.
{browse "https://doi.org/10.1002/jae.2707"}.


{marker ack}{...}
{title:Acknowledgments}

{pstd}
I am grateful to Arnab Bhattacharjee, David M. Drukker, Markus Eberhardt,
Tullio Gregori, Erich Gundlach, Sean Holly, Mark Schaffer, the
participants of the 2016 Stata Users Group meeting in London, the participants
of the 2018 Stata Users
Group meeting in Zurich, and two anonymous referees of the {it:Stata Journal}
for many valuable comments and suggestions.  All remaining errors are my
own.{p_end}

{pstd}
The routine to check for positive-definite or singular matrices was provided
by Mark Schaffer, Heriot-Watt University, Edinburgh, UK.{p_end}

{pstd}
{cmd:xtdcce2} was formerly called {cmd:xtdcce}.

{pstd}
Please cite as follows:

{phang2}
Ditzen, J. 2021. Estimating long-run effects and the exponent of
cross-sectional dependence: An update to xtdcce2.
{it:Stata Journal} 21: 687-707.
{browse "https://doi.org/10.1177/1536867X211045560"}.

{phang2}
Ditzen, J. 2018. Estimating dynamic common-correlated effects in Stata.
{it:Stata Journal} 18: 585-617. {browse "https://doi.org/10.1177/1536867X1801800306"}.

{pstd}
The latest versions can be obtained via
{bf:net install xtdcce2, from("https://janditzen.github.io/xtdcce2/")}
and beta versions, including a full history of {cmd:xtdcce2} from 
{bf:net from https://janditzen.github.io/xtdcce2/}.{p_end}


{marker author}{title:Author}

{pstd}
Jan Ditzen{break}
Free University of Bozen-Bolzano{break}
Bozen, Italy{break}
{browse "mailto:jan.ditzen@unibz.it":jan.ditzen@unibz.it}{break}
{browse "https://sites.google.com/site/jandger87/home"}


{marker ChangeLog}{title:Changelog}

{pstd}
This version: 2.0 - 13. July 2019{p_end}
{phang2} - bug fix in calculation of minimal T dimension, added option {cmd:nodimcheck}.{p_end}
{phang2} - speed improvements (thanks to Achim Ahrens for the suggestions).{p_end}
{phang2} - bug fixes for jackknife (thanks to Collin Rabe for the pointer).{p_end}
{phang2} - bug fix in {cmd:predict} and {cmd:if} (thanks for Deniey A. Purwanto and Tullio Gregoi for the pointers).{p_end}
{phang2} - bug fix if binary variable used and constant partialed out.{p_end}
{phang2} - bug fixed in calculation of R2, added adjusted R2 for pooled and MG regressions.{p_end}
{phang2} - Newey-West and Westerlund, Petrova, Norkute standard errors for pooled regressions.{p_end}
{phang2} - {cmd:invsym()} for rank-deficient matrices.{p_end}
{phang2} - added {cmd:xtcse2} support.{p_end}
{pstd}Version 1.33 to Version 1.34{p_end}
{phang2} - small bug fixes in code and help file.{p_end}
{pstd}Version 1.32 to Version 1.33{p_end}
{phang2} - bug in if statements fixed.{p_end}
{phang2} - {cmd:noomitted} added, bug in {cmd:crosssectional(_all)} fixed.{p_end}
{phang2} - added option {cmd:replace} and {cmd:cfresiduals} to {cmd:predict}.{p_end}
{phang2} - CS-DL and CS-ARDL method added.{p_end}
{phang2} - output as in {it:Stata Journal} version.{p_end}
{pstd}Version 1.31 to Version 1.32{p_end}
{phang2} - bug number of groups fixed{p_end}
{phang2} - {cmd:predict, residual} produced different results within {cmd:xtdcce2} and after if panel unbalanced or trend used (thanks to Tullio Gregori for the pointer).{p_end}
{phang2} - check for rank condition.{p_end}
{phang2} - several bugs fixed.{p_end}
{pstd}Version 1.2 to Version 1.31{p_end}
{phang2} - code for regression in Mata{p_end}
{phang2} - corrected standard errors for pooled coefficients; option
{cmd:cluster} not necessary any longer. Please rerun estimations if used
option {cmd:pooled()}{p_end}
{phang2} - fixed errors in unbalanced panel{p_end}
{phang2} - option {cmd:post_full} removed; individual estimates are posted in {cmd:e(bi)} and {cmd:e(Vi)}{p_end}
{phang2} - added option {cmd:ivslow}.{p_end}
{phang2} - legacy control for {cmd:endogenous_var()}, {cmd:exogenous_var()},
and {cmd:residuals()}.{p_end}


{marker also_see}{title:Also see}

{p 4 14 2}
Article:  {it:Stata Journal}, volume 21, number 3: {browse "https://doi.org/10.1177/1536867X211045560":st0536_1},{break}
          {it:Stata Journal}, volume 18, number 3: {browse "https://doi.org/10.1177/1536867X1801800306":st0536}

{p 7 14 2}
Help:  {helpb xtcd2}, {helpb xtcse2}, {helpb ivreg2}, {helpb xtmg}, 
{helpb xtpmg}, {helpb moremata} (if installed){p_end}
