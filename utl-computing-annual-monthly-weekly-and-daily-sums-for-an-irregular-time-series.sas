%let pgm=utl-computing-annual-monthly-weekly-and-daily-sums-for-an-irregular-time-series;

Note there are many missing months and days

Computing Annual, Monthly, Weekly and Daily Sums for an irregular time series

Problem: compute food and gas costs given nm irregular time seties

github
https://tinyurl.com/32t22x3s
https://github.com/rogerjdeangelis/utl-computing-annual-monthly-weekly-and-daily-sums-for-an-irregular-time-series

related repos on end

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/


/**************************************************************************************************************************/
/*                              |                                                                                         */
/* INPUT (RULES EXAMPLES)       |        OUTPUT (SUMS)                                                                    */
/*                              |                                                                                         */
/*       DATETIME    FOOD  GAS  |     PERIOD  GRPDTE   FOOD  GAS                                                          */
/*                              |                                                                                         */
/*     02/27/201408:19  5   31  |  yearly.4   2014       15   43  (2014 has only two input records)                       */
/*     02/27/201412:19 10   12  |                                                                                         */
/*                     ==   ==  |                                                                                         */
/*                     15   43  |                                                                                         */
/*                              |                                                                                         */
/*     03/21/20110:00   1   96  |  monthly.1  2011-03   140  317                                                          */
/*     03/24/20110:05  23   97  |                                                                                         */
/*     03/27/20110:10  42   42  |                                                                                         */
/*     03/30/20110:15  74   82  |                                                                                         */
/*                    ===  ===  |                                                                                         */
/*                    140  327  |                                                                                         */
/*                              |                                                                                         */
/*                              |                                                                                         */
/*     03/21/20110:00   1   96  |   weekly.1  2011-03-27 66  235                                                          */
/*     03/24/20110:05  23   97  |                                                                                         */
/*     03/27/20110:10  42   42  |                                                                                         */
/*                     ==  ===  |                                                                                         */
/*                     66  235  |                                                                                         */
/*                              |                                                                                         */
/*                              |   daily.47  2014-02-27 15   43                                                          */
/*     02/27/201408:19  5   31  |                                                                                         */
/*     02/27/201412:19 10   12  |                                                                                         */
/*                     ==   ==  |                                                                                         */
/*                     15   43  |                                                                                         */
/*                              |                                                                                         */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/
options validvarname=upcase;
libname sd1 "d:/sd1";
DATA sd1.have;
  informat date $15.;
  input date food gas @@;
cards4;
03/21/20110:00 1 96 03/24/20110:05 23 97
03/27/20110:10 42 42 03/30/20110:15 74 82
04/02/20110:20 47 42 04/05/20110:25 55 7
04/08/20110:30 41 21 04/11/20110:35 85 46
04/14/20110:40 33 86 04/17/20110:45 21 84
04/20/20110:50 100 11 04/23/20110:55 67 13
04/26/20111:00 56 55 04/29/20111:05 14 3
05/02/20111:10 56 31 05/05/20111:15 85 94
05/08/20111:20 23 80 05/11/20111:25 13 17
05/14/20111:30 78 45 05/17/20111:35 43 24
05/20/20111:40 70 3 05/23/20111:45 95 33
05/26/20111:50 18 58 05/29/20111:55 70 94
06/01/20112:00 95 4 06/04/20112:05 8 54
06/07/20112:10 54 4 06/10/20112:15 5 31
06/13/20112:20 52 84 06/16/20112:25 27 2
06/19/20112:30 55 100 06/22/20112:36 84 9
06/25/20112:41 34 63 06/28/20112:46 71 18
07/01/20112:51 16 76 07/04/20112:56 58 30
07/07/20113:01 50 28 07/10/20113:06 66 58
07/14/20116:52 43 24 11/11/20114:26 70 3
03/10/20121:59 95 33 07/07/201223:32 18 58
11/04/201221:06 70 94 03/04/201318:39 95 4
07/02/201316:12 8 54 10/30/201313:46 54 4
02/27/201408:19 5 31 02/27/201412:19 10 12
;;;;
run;quit;
sd1.have total obs=48 26MAR2024:13:00:16

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Obs         DATE          FOOD    GAS                                                                                 */
/*                                                                                                                        */
/*    1    03/21/20110:00        1     96                                                                                 */
/*    2    03/24/20110:05       23     97                                                                                 */
/*    3    03/27/20110:10       42     42                                                                                 */
/*   ....                                                                                                                 */
/*   46    10/30/201313:46      54      4                                                                                 */
/*   47    02/27/201408:19       5     31                                                                                 */
/*   48    02/27/201412:19      10     12                                                                                 */
/*                                                                                                                        */
/**************************************************************************************************************************/


/*          _
 _ __ _   _| | ___  ___
| `__| | | | |/ _ \/ __|
| |  | |_| | |  __/\__ \
|_|   \__,_|_|\___||___/

*/

/**************************************************************************************************************************/
/*                              |                                                                                         */
/*     RULES  (examples)        |           OUTPUT (SUMS)                                                                 */
/*                              |                                                                                         */
/*       DATETIME    FOOD  GAS  |        PERIOD  GRPDTE   FOOD  GAS                                                       */
/*                              |                                                                                         */
/*     02/27/201408:19  5   31  |  4   yearly.4  2014       15   43                                                       */
/*     02/27/201412:19 10   12  |                                                                                         */
/*                     ==   ==  |                                                                                         */
/*                     15   43  |                                                                                         */
/*                              |                                                                                         */
/*     03/21/20110:00   1   96  |  5  monthly.1  2011-03   140  317                                                       */
/*     03/24/20110:05  23   97  |                                                                                         */
/*     03/27/20110:10  42   42  |                                                                                         */
/*     03/30/20110:15  74   82  |                                                                                         */
/*                    ===  ===  |                                                                                         */
/*                    140  327  |                                                                                         */
/*                              |                                                                                         */
/*                              |                                                                                         */
/*     03/21/20110:00   1   96  |  18  weekly.1  2011-03-27 66  235                                                       */
/*     03/24/20110:05  23   97  |                                                                                         */
/*     03/27/20110:10  42   42  |                                                                                         */
/*                     ==  ===  |                                                                                         */
/*                     66  235  |                                                                                         */
/*                              |                                                                                         */
/*                              |  89  daily.47  2014-02-27 15   43                                                       */
/*     02/27/201408:19  5   31  |                                                                                         */
/*     02/27/201412:19 10   12  |                                                                                         */
/*                     ==   ==  |                                                                                         */
/*                     15   43  |                                                                                         */
/*                              |                                                                                         */
/**************************************************************************************************************************/
 /*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

%utl_rbegin;
parmcards4;
library(haven);
library(dplyr);
library(xts);
library(sqldf);
source("c:/temp/fn_tosas9.R");
have<-as.data.frame(read_sas("d:/sd1/have.sas7bdat"));
res <- xts(have[,-1], as.POSIXct(have[,1], format="%m/%d/%Y %H:%M"));
grp<-c("Daily", "Weekly", "Monthly");
yearly <-apply.yearly(res, colSums);
monthly<-apply.monthly(res, colSums);
weekly <-apply.weekly(res, colSums);
daily  <-apply.daily(res, colSums);
lsts<-list(yearly=yearly, monthly=monthly, weekly=weekly, daily=daily);
dfs<-lapply(lsts,function(x) {data.frame(date=index(x), coredata(x))});
want<-do.call("rbind", dfs);
want$GRP <- rownames(want);
want$date <- as.character(want$date);
str(want);
want<-sqldf('
   select
     grp as period
    ,case
       when substr(grp,1,4)="year" then substr(date,1,4)
       when substr(grp,1,4)="mont" then substr(date,1,7)
       when substr(grp,1,4)="week" then substr(date,1,10)
       when substr(grp,1,4)="dail" then substr(date,1,10)
       else "XX"
    end grpdte
    ,food
    ,gas
   from
     want
   ');
want;
str(want);
fn_tosas9(dataf=want);
;;;;
%utl_rend;

libname tmp "c:/temp";
proc print data=tmp.want width=min;
format data datetime18.0;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* Obs    ROWNAMES      PERIOD      GRPDTE        FOOD     GAS                                                            */
/*                                                                                                                        */
/*   1        1       yearly.1      2011          1998    1752                                                            */
/*  ...                                                                                                                   */
/*   5        5       monthly.1     2011-03        140     317                                                            */
/*  ...                                                                                                                   */
/*  18       18       weekly.1      2011-03-27      66     235                                                            */
/*  ...                                                                                                                   */
/*  43       43       daily.1       2011-03-21       1      96                                                            */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __ ___ _ __   ___  ___
| `__/ _ \ `_ \ / _ \/ __|
| | |  __/ |_) | (_) \__ \
|_|  \___| .__/ \___/|___/
         |_|
*/


--------------------------------------------------------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/utl-calculating-a-weighted-or-moving-sum-for-a-window-of-size-three
https://github.com/rogerjdeangelis/utl-calculating-three-year-rolling-moving-weekly-and-annual-daily-standard-deviation
https://github.com/rogerjdeangelis/utl-forecast-the-next-four-months-using-a-moving-average-time-series
https://github.com/rogerjdeangelis/utl-forecast-the-next-seven-days-using-a--moving-average-model-in-R
https://github.com/rogerjdeangelis/utl-moving-ten-month-average-by-group
https://github.com/rogerjdeangelis/utl-parallell-processing-a-rolling-moving-three-month-ninety-day-skewness-for-five-thousand-variabl
https://github.com/rogerjdeangelis/utl-rolling-moving-sum-and-count-over-3-day-window-by-id
https://github.com/rogerjdeangelis/utl-tumbling-goups-of-ten-temperatures-similar-like-rolling-and-moving-means-wps-r-python
https://github.com/rogerjdeangelis/utl-weight-loss-over-thirty-day-rolling-moving-windows-using-weekly-values
https://github.com/rogerjdeangelis/utl-weighted-moving-sum-for-several-variables
https://github.com/rogerjdeangelis/utl_R_moving_average_six_variables_by_group
https://github.com/rogerjdeangelis/utl_calculate-moving-rolling-average-with-gaps-in-years
https://github.com/rogerjdeangelis/utl_moving_average_of_centered_timeseries_or_calculate_a_modified_version_of_moving_averages
https://github.com/rogerjdeangelis/utl-Rolling-four-month-median-by-group
https://github.com/rogerjdeangelis/utl-betas-for-rolling-regressions
https://github.com/rogerjdeangelis/utl-calculating-three-year-rolling-moving-weekly-and-annual-daily-standard-deviation
https://github.com/rogerjdeangelis/utl-compute-the-partial-and-total-rolling-sums-for-window-of-size-of-three
https://github.com/rogerjdeangelis/utl-controlling-the-order-of-transposed-variables-using-interleave-set
https://github.com/rogerjdeangelis/utl-creating-rolling-sets-of-monthly-tables
https://github.com/rogerjdeangelis/utl-how-to-compare-price-observations-in-rolling-time-intervals
https://github.com/rogerjdeangelis/utl-parallell-processing-a-rolling-moving-three-month-ninety-day-skewness-for-five-thousand-variable
https://github.com/rogerjdeangelis/utl-rolling-moving-sum-and-count-over-3-day-window-by-id
https://github.com/rogerjdeangelis/utl-rolling-sum_of-six-months-by-group
https://github.com/rogerjdeangelis/utl-timeseries-rolling-three-day-averages-by-county
https://github.com/rogerjdeangelis/utl-tumbling-goups-of-ten-temperatures-similar-like-rolling-and-moving-means-wps-r-python
https://github.com/rogerjdeangelis/utl-weight-loss-over-thirty-day-rolling-moving-windows-using-weekly-values
https://github.com/rogerjdeangelis/utl_calculate-moving-rolling-average-with-gaps-in-years
https://github.com/rogerjdeangelis/utl_calculating_rolling_3_month_skewness_of_prices_by_stock
https://github.com/rogerjdeangelis/utl_calculating_the_rolling_product_using_wps_sas_and_r
https://github.com/rogerjdeangelis/utl_comparison_sas_v_r_increment_a_rolling_sum_with_the_first_value_for_each_id
https://github.com/rogerjdeangelis/utl_count_distinct_ids_in_rolling_overlapping_date_ranges
https://github.com/rogerjdeangelis/utl_excluding_rolling_regressions_with_one_on_more_missing_values_in_the_window
https://github.com/rogerjdeangelis/utl_nice_hash_example_of_rolling_count_of_dates_plus-minus_2_days_of_current_date
https://github.com/rogerjdeangelis/utl_rolling_means_by-quarter_semiannual_and_yearly
https://github.com/rogerjdeangelis/utl_standard_deviation_of_90_day_rolling_standard_deviations


/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/



