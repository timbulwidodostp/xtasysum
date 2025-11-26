{smcl}
{* *! v. 1.02 - 11. January 2021}{...}
{cmd:help xtcse2}{right: ({browse "https://doi.org/10.1177/1536867X211045560":SJ21-3: st0536_1})}
{hline}

{title:Title}

{p2colset 5 15 17 2}{...}
{p2col :{cmd:xtcse2} {hline 2}}Estimating the exponent of cross-sectional dependence in large panels{p_end}


{title:Syntax}

{p 8 14 2}
{cmd:xtcse2} [{varlist}] [{it:{help if}}] [{cmd:,}
{opt pca(integer)}
{cmdab:stand:ardize}
{opt nocenter}
{opt nocd}
{opt res:idual}
{opt r:eps(integer)}
{opt size(real)}
{opt tuning(real)}
{opt lags(integer)}]

{pstd}
Data must be {cmd:xtset} before using {cmd:xtcse2}; see {helpb xtset}.
{it:varlist} may contain time-series operators; see {help tsvarlist}.  If
{it:varlist} is left empty, {cmd:xtcse2} predicts residuals from the last
estimation command; see {helpb predict}.  {cmd:xtcse2} restricts the panel to
the same number of time series per cross-sectional unit if the panel is
unbalanced.{p_end}


{title:Contents}

{pstd}{help xtcse2##description:Description}{p_end}
{pstd}{help xtcse2##options:Options}{p_end}
{pstd}{help xtcse2##model:Econometric model and estimation of the exponent}{p_end}
{pstd}{help xtcse2##examples:Examples}{p_end}
{pstd}{help xtcse2##stored_results:Stored results}{p_end}
{pstd}{help xtcse2##references:References}{p_end}
{pstd}{help xtcse2##ack:Acknowledgments}{p_end}
{pstd}{help xtcse2##author:Author}{p_end}
{pstd}{help xtcse2##ChangeLog:Changelog}{p_end}
{pstd}{help xtcse2##also_see:Also see}{p_end}


{marker description}{title:Description}

{pstd}
{cmd:xtcse2} estimates the exponent of cross-sectional dependence (CD) in a
panel with many observations over time (T) and cross-sectional units (N).  The
estimation method follows Bailey, Kapetanios, and Pesaran (2016, 2019).  A
variable or a residual is cross-sectionally dependent if it exhibits a common
factor across cross-sectional units.{p_end}

{pstd}
{cmd:xtcse2} estimates the strength of the factor for a residual or one or
more variables.  It outputs a standard error and confidence interval in the
usual estimation output fashion.  However, it does not show a t or z statistic
and p-value. Generally speaking, strong CD occurs if alpha is above 0.5.
Testing this is done by a separate test of weak CD.  Therefore, a confidence
interval is more informative when estimating alpha.

{pstd}
{cmd:xtcse2} is intended to support the decision of whether to include
cross-sectional averages when using {helpb xtdcce2} and accompanies
{helpb xtcd2} in testing for weak CD.  As a default, it uses {helpb xtcd2} to
test for weak CD.  For discussions of {cmd:xtdcce2} and {cmd:xtcd2}, see
Ditzen (2018) and Ditzen (2019), respectively.

{pstd}
If the panel is unbalanced or observations are missing for a specific
cross-section unit-time combination, then the sample is restricted to the
union of all time periods across cross-sectional units.  For unbalanced panels
with many missing or a variable with many missing, many observations might be
lost.


{marker options}{title:Options}

{phang}
{opt pca(integer)} sets the number of principal components for the calculation
of cn.  The default is to use the first four components.

{phang}
{cmd:standardize} standardizes variables.

{phang}
{cmd:nocenter} specifies not to center variables (that is, the cross-sectional
mean is zero).

{phang}
{cmd:nocd} suppresses the test for weak CD using {helpb xtcd2}.

{phang}
{cmd:residual} estimates the exponent of CD in residuals, following Bailey,
Kapetanios, and Pesaran (2019).

{phang}
{opt reps(integer)} specifies the number of repetitions for bootstrap for the
calculation of the standard error and confidence interval for the exponent in
residuals.  The default is {cmd:reps(0)}.

{phang}
{opt size(real)} specifies the size of the test.  The default is
{cmd:size(0.1)} (10%).

{phang}
{opt tuning(real)} specifies the tuning parameter for estimation of the
exponent in residuals.  The default is {cmd:tuning(0.5)}.

{phang}
{opt lags(integer)} specifies the number of lags (or training periods) for
calculation of recursive residuals when estimating the exponent after a
regression with weakly exogenous regressors.


{marker model}{title:Econometric model and estimation of the exponent}

    {title:Econometric model}

{pstd}
For the following, assume a general factor model with m factors,

{phang2}
x(i,t) = sum(j=1,m) b(j,i) f(j,t) + u(i,t){p_end}
{phang2}
i = 1,...,N and t = 1,...,T

{pstd}
where x(i,t) depends on unobserved m common factors f(j,t) with loading b(j,i)
and a cross-sectionally independent error term u(i,t).  The time dimension (T)
and the number of cross-sectional units (N) increases to infinity; (N,T) ->
infinity.

{pstd}
Chudik, Pesaran, and Tosetti (2011) specify the factors as weak or strong
using a constant 0<=alpha<=1 such that

{phang2}
lim N^(-alpha) sum(j=1,m) abs{b(j,i)} = K < infinity

{pstd}
The type of dependence of the factors and thus the series then depends on the
characteristics of b(j,i):

{col 12}alpha {col 40} dependence
{col 12}{hline 40}
{col 12}alpha = 0 {col 40} weak
{col 12}0 < alpha < 0.5 {col 40} semiweak
{col 12}0.5 <= alpha < 1 {col 40} semistrong
{col 12}alpha = 1 {col 40} strong

{pstd}
Weak CD can be thought of as the following: Even if the number of
cross-sectional units increases to infinity, the sum of the effect of the
common factors on the dependent variable remains constant.  In the case of
strong CD, the sum of the effect of the common factors becomes stronger with
an increase in the number of cross-sectional units.

{pstd}
In an estimation, ignoring (semi)strong dependence in the dependent or
independent variables can cause an omitted-variable bias and therefore lead to
inconsistent estimates.  Pesaran (2015) proposes a test to test for weak CD;
see {helpb xtcd2}.  Pesaran (2006) and Chudik and Pesaran (2015) develop a
method to fit models with CD by adding time averages of the dependent and
independent variables (cross-sectional averages).  This estimator is
implemented in Stata by {helpb xtdcce2}.

{pstd}
{cmd:xtcse2} estimates alpha in the equation above.  An alpha above 0.5
implies strong CD, and the appropriate alpha when using a variable is
required.

    {title:Exponent estimation (alpha)}

{pstd}
Bailey, Kapetanios, and Pesaran (2016) propose a method for the estimation of
the exponent.  This section summarizes their approach; a careful reading of
the assumptions and theorems is strongly encouraged.

{pstd}
Bailey, Kapetanios, and Pesaran derive a bias-adjusted estimator for alpha in
a panel with N_g cross-sectional units [see (13)]:

{phang2}
alpha = 1 + 1/2 ln(sigma_x^2)/ln(N_g) - 1/2 ln(mu^2)/ln(N_g) - 1/2 cn
/ {N_g * ln(N_g) * sigma_x^2}

{pstd}
sigma_x^2 is the variance of the cross-sectional averages.  mu^2 is average
variance of significant regression coefficients of x(i,t) on standardized
cross-sectional averages with a prespecified size of the test.  cn is the
variance of scaled errors from a regression of the x(i,t) on its first K(PC)
principal components.  The number of principal components can be set using the
option {cmd:pca()}.  The default is to use the first four principal
components.

{pstd}
{cmd:xtcse2} outputs a standard error for alpha and a confidence interval in
the usual Stata estimation fashion.  A t or z test statistic with p-value is,
however, omitted because the test is done by the test for weak CD; see
{helpb xtcd2}.  {cmd:xtcse2} automatically calculates the CD-test statistic
and posts its results.  For the estimation of alpha, a confidence interval is
therefore more informative.

{pstd}
The calculation of the standard error of alpha follows (B47), section VI of 
the online appendix of Bailey, Kapetanios, and Pesaran, available 
{browse "https://onlinelibrary.wiley.com/doi/abs/10.1002/jae.2476":here}:

{phang2}
sigma(alpha) = {1/T V(q) + 4/N^(alpha)}^(1/2) * 1/2 * 1/ln(N)

{pstd}
V(q) is the regression standard error over the square of the sum of q
coefficients of an AR(q) process of the square of the deviation of
standardized cross-sectional averages.  q is the third root of T.  S is the
squared sum divided by N^(alpha-1) of ordinary least-squares coefficients of
x(it) on standardized cross-sectional averages sorted according to their
absolute value.

{pstd}
In the case of estimating the exponent of CD in residuals, Bailey, Kapetanios,
and Pesaran (2019) propose using pairwise correlations to estimate the
exponent. For the calculation, only significant correlations are taken into
account.  The exponent is estimated according to (25) in Bailey, Kapetanios,
and Pesaran (2019),

{phang2}
alpha = ln(tau' delta tau) / {2 ln(N)}

{pstd}
tau is an Nx1 vector of 1s, and delta is a matrix that contains the
significant pairwise correlations.  For the significance, the size of the test
and a tuning parameter need to be set a priori.  {cmd:xtcse2} uses a size of
10% and a tuning parameter of 0.5 as a default.  Both can be changed with the
options {cmd:size()} and {cmd:tuning()}, respectively.

{pstd}
In the case of a panel with weakly exogenous regressors, the pairwise
correlations are based on recursive residuals; see Bailey, Kapetanios, and
Pesaran (2019, sec. 5.2).  {cmd:xtcse2} allows for this if the option
{cmd:lags()} is used.

{pstd}
Bailey, Kapetanios, and Pesaran (2019) do not derive a closed-form solution
for standard errors.  Therefore, standard errors and confidence intervals are
calculated using a simple bootstrap, where the cross-sectional units are
sampled with replacement.  This approach is outlined in Bailey, Kapetanios,
and Pesaran (2019, sec. 5.3).


{marker examples}{title:Examples}

{pstd}
Load the example dataset of the Penn World Tables 8.  The dataset contains
yearly observations from 1960 until 2007 and is already {cmd:xtset}.

{phang2}{bf:. {stata use xtdcce2_sample_dataset}}

{pstd}
To estimate a growth equation, use the following variables: {cmd:log_rgdpo}
(real GDP), {cmd:log_hc} (human capital), {cmd:log_ck} (physical capital), and
{cmd:log_ngd} (population growth + break-even investments of 5%).

{pstd}
Before running the growth regression, estimate the exponent of the
cross-sectional dependence for the variables:

{phang2}
{bf:. {stata xtcse2 d.log_rgdpo L.log_rgdpo log_hc log_ck log_ngd}}

{pstd}
All variables are highly cross-sectionally dependent with alphas close or even
above 1.  Therefore, an estimation method taking CD is required.  
{helpb xtdcce2} uses such an estimation method by adding cross-sectional
averages to the model.  After running {cmd:xtdcce2}, you can use {cmd:xtcse2}
to estimate the strength of the exponent of the residual using the option
{cmd:residuals}.

{phang2}
{bf:. {stata xtdcce2 log_rgdpo L.log_rgdpo log_ck log_ngd  log_hc, cr(log_rgdpo log_ck log_ngd  log_hc)}}{p_end}
{phang2}
{bf:. {stata xtcse2, res}}{p_end}

{pstd}
{cmd:xtcse2} automatically predicts the residuals using {cmd:predict}
({helpb xtdcce2#postestimation:predict} after {cmd:xtdcce2}).  The CD
statistic is still in a rejection region.  Therefore, the residuals exhibit
strong CD.

{pstd}
The fitted model above is misspecified because it is a dynamic model, but no
lags of the cross-sectional averages are added.  The number of lags should be
in the region of T^(1/3), so with 47 periods, 3 lags are added.  Then,
{cmd:xtcse2} is used to estimate alpha again; this time, the CD test is
omitted:

{phang2}
{bf:. {stata xtdcce2 log_rgdpo L.log_rgdpo log_ck log_ngd  log_hc, cr(log_rgdpo log_ck log_ngd  log_hc) cr_lags(3) }}{p_end}
{phang2}
{bf:. {stata xtcse2, nocd residual lags(3) reps(200)}}{p_end}

{pstd}
The value of the CD test statistic is 1.32 and in a nonrejection region.  The
estimate of alpha is considerably small; the confidence interval does not
overlap with 0.5.

{pstd}
As a second exercise, the first row of table 1 in Bailey, Kapetanios, and
Pesaran is reproduced.

{phang2}
{bf:. {stata use cmpr}}{p_end}
{phang2}
{bf:. {stata xtset ccode year}}

{pstd}
After the data are loaded, reshaped (they come in a matrix), and renamed as
variable {cmd:gdp}, the option {cmd:standardize} is used to standardize the
variable as done in Bailey, Kapetanios, and Pesaran:

{phang2}
{bf:. {stata xtcse2 gdp, standardize}}{p_end}


{marker stored_results}{title:Stored results}

{pstd}
{cmd:xtcse2} stores the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(alpha)}}matrix with estimated alphas{p_end}
{synopt:{cmd:r(alphaSE)}}matrix with estimated standard errors of alphas{p_end}
{synopt:{cmd:r(alphas)}}matrix with estimated alpha tilde, alpha hat, and alpha{p_end}
{synopt:{cmd:r(N_g)}}matrix with number of cross-sectional units{p_end}
{synopt:{cmd:r(T)}}matrix with number of time periods{p_end}
{synopt:{cmd:r(CD)}}matrix with values of CD test statistic (if requested){p_end}
{synopt:{cmd:r(CDp)}}matrix values of p-value of CD test statistic (if requested){p_end}


{marker references}{title:References}

{phang}
Bailey, N., G. Kapetanios, and M. H. Pesaran. 2016.
Exponent of cross-sectional dependence: Estimation and inference.
{it:Journal of Applied Econometrics} 31: 929-960.
{browse "https://doi.org/10.1002/jae.2476"}.

{phang}
------. 2019.
Exponent of cross-sectional dependence for residuals.
{it:Sankhy{c a~}} 81: 46-102.
{browse "https://doi.org/10.1007/s13571-019-00196-9"}.

{phang}
Chudik, A., and M. H. Pesaran. 2015.
Common correlated effects estimation of heterogeneous dynamic panel data
models with weakly exogenous regressors.
{it:Journal of Econometrics} 188: 393-420.
{browse "https://doi.org/10.1016/j.jeconom.2015.03.007"}.

{phang}
Chudik, A., M. H. Pesaran, and E. Tosetti. 2011. 
Weak and strong cross-section dependence and estimation of large panels.
{it:Econometrics Journal} 14: C45-C90.
{browse "https://doi.org/10.1111/j.1368-423X.2010.00330.x"}.

{phang}
Ditzen, J. 2018. Estimating dynamic common-correlated effects in Stata.
{it:Stata Journal} 18: 585-617.
{browse "https://doi.org/10.1177/1536867X1801800306"}.

{phang}
------. 2019. Estimating long run effects in models with cross-sectional
dependence using xtdcce2. 
CEERP Working Paper No. 7.
{browse "https://ceerp.hw.ac.uk/RePEc/hwc/wpaper/007.pdf"}.

{phang}
Pesaran, M. H. 2006.
Estimation and inference in large heterogeneous panels with a multifactor
error structure.
{it:Econometrica} 74: 967-1012.
{browse "https://doi.org/10.1111/j.1468-0262.2006.00692.x"}.

{phang}
------. 2015. 
Testing weak cross-sectional dependence in large panels. 
{it:Econometric Reviews} 34: 1089-1117.
{browse "https://doi.org/10.1080/07474938.2014.956623"}.


{marker ack}{...}
{title:Acknowledgments}

{pstd}
I am grateful to Arnab Bhattacharjee, David M. Drukker, Markus Eberhardt,
Tullio Gregori, Erich Gundlach, Sean Holly, Mark Schaffer, the participants of
the 2016 Stata Users Group meeting in London, the participants of the 2018
Stata User Group meeting in Zurich, and two anonymous referees of the
{it:Stata Journal} for many valuable comments and suggestions.  All remaining
errors are my own.{p_end}

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
{it:Stata Journal} 18: 585-617.
{browse "https://doi.org/10.1177/1536867X1801800306"}.

{pstd}
The latest versions can be obtained via
{bf:net install xtdcce2, from("https://janditzen.github.io/xtdcce2/")}
and beta versions, including a full history of {cmd:xtdcce2}, from 
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
This version: 1.2 - 11. January 2021{p_end}
{phang2}- added support for residuals{p_end}
{phang2}- bug fixed{p_end}
{phang2}- added option {cmd:nocenter}{p_end}
{phang2}- added {cmd:xtbalance2} to balance panel dataset{p_end}


{marker also_see}{...}
{title:Also see}

{p 4 14 2}
Article:  {it:Stata Journal}, volume 21, number 3: {browse "https://doi.org/10.1177/1536867X211045560":st0536_1},{break}
          {it:Stata Journal}, volume 18, number 3: {browse "https://doi.org/10.1177/1536867X1801800306":st0536}{p_end}

{p 7 14 2}
Help:  {helpb xtdcce2}, {helpb xtcd2} (if installed){p_end}
