/* 42050 SAS Predictive Business Analytics - Assessment 1
   Student: Aditya Maurya
   Public portfolio copy
   Subject: 42050 SAS Predictive Business Analytics
   Assessment: Assessment 1 - Data Exploration
   Dataset: UCI Bank Marketing bank.csv (4,521 observations)

   This program reproduces the import verification and descriptive
   calculations used in the report. Point-and-click Model Studio settings
   are documented separately by the saved project and genuine screenshots;
   this program does not claim to recreate settings it does not implement. */

options validvarname=any;

%let source_url=https://raw.githubusercontent.com/stefan1condeescu/bank-marketing-sas-analytics/main/sas_project/bank.csv;

cas mySession;
caslib _all_ assign;

filename bankurl url "&source_url" termstr=crlf;

data casuser.BANK_MARKETING_A1;
    infile bankurl dsd dlm=';' firstobs=2 truncover lrecl=32767;
    length job $20 marital $10 education $10 default $3 housing $3 loan $3
           contact $10 month $3 poutcome $10 y $3;
    input age job :$20. marital :$10. education :$10. default :$3.
          balance housing :$3. loan :$3. contact :$10. day month :$3.
          duration campaign pdays previous poutcome :$10. y :$3.;
run;

title "Bank Marketing Import Verification";
proc contents data=casuser.BANK_MARKETING_A1 varnum;
run;

title "Observation and Target Checks";
proc sql;
    select count(*) as observations,
           sum(case when lowcase(y)='yes' then 1 else 0 end) as subscribed_yes,
           calculated subscribed_yes / calculated observations
               as subscription_rate format=percent8.2
    from casuser.BANK_MARKETING_A1;
quit;

title "Target Distribution";
proc freq data=casuser.BANK_MARKETING_A1;
    tables y / missing;
run;

title "Numeric Profile";
proc means data=casuser.BANK_MARKETING_A1 n nmiss min mean std max;
    var age balance day duration campaign pdays previous;
run;

/* Verify exact duplicate rows without modifying the validated CAS table. */
proc sort data=casuser.BANK_MARKETING_A1
          out=work.BANK_MARKETING_A1_DEDUP nodupkey;
    by _all_;
run;

title "Exact Duplicate Row Check";
proc sql;
    select a.source_rows,
           b.distinct_rows,
           a.source_rows-b.distinct_rows as exact_duplicate_rows
    from (select count(*) as source_rows
          from casuser.BANK_MARKETING_A1) as a,
         (select count(*) as distinct_rows
          from work.BANK_MARKETING_A1_DEDUP) as b;
quit;

title "Categorical Quality Check";
proc freq data=casuser.BANK_MARKETING_A1;
    tables job marital education default housing loan contact month poutcome / missing;
run;

/* Create analysis-only flags after the 17-variable source table is verified.
   The base CAS/PUBLIC table therefore remains consistent with the report. */
data casuser.BANK_MARKETING_A1_ANALYSIS;
    set casuser.BANK_MARKETING_A1;
    subscribed_flag = (lowcase(y)='yes');
    never_contacted_before = (pdays=-1);
    label subscribed_flag='Subscribed to term deposit (1=yes)'
          never_contacted_before='No previous campaign contact (1=yes)';
run;

title "Subscription Rate by Key Business Segments";
proc tabulate data=casuser.BANK_MARKETING_A1_ANALYSIS;
    class poutcome job month housing loan;
    var subscribed_flag;
    tables (poutcome job month housing loan),
           subscribed_flag*(n mean*f=percent8.2);
run;

/* Persist the validated 17-variable source table for Visual Analytics. */
proc casutil;
    droptable casdata='BANK_MARKETING_A1_MAURYA' incaslib='PUBLIC' quiet;
    load data=casuser.BANK_MARKETING_A1
         outcaslib='PUBLIC'
         casout='BANK_MARKETING_A1_MAURYA'
         promote;
    save casdata='BANK_MARKETING_A1_MAURYA'
         incaslib='PUBLIC'
         outcaslib='PUBLIC'
         replace;
quit;

title;
filename bankurl clear;

/* Saved SAS Viya artifacts
   Project: A1_Bank_Marketing_Maurya
   Model Studio Exchange pipeline: A1_Bank_Marketing_Maurya_Preparation_Model
   Visual Analytics report: A1_Bank_Marketing_Visuals_Maurya

   Data-quality and modelling decisions:
   - Negative balance values are preserved because they can represent
     overdrawn customer balances.
   - pdays=-1 is preserved as a documented no-previous-contact sentinel.
   - Character level 'unknown' is retained as an explicit nominal level;
     it is not treated as SAS missing.
   - duration is available only after the call and is therefore rejected
     for realistic pre-call targeting to avoid information leakage.
   - Target y, event level yes
   - Stratified partition: 60% training / 30% validation / 10% testing
   - Event-based sampling disabled

   Verified Model Studio settings (configured in the UI, not by this code):
   - Data Exploration: all data; Importance criterion; maximum 50 variables;
     8 bins. Important Inputs ranked poutcome, month and job highest.
   - Replacement: interval limits are 3 standard deviations from the mean,
     replacement value is the computed limit, and unknown class replacement
     is Ignore. REP_ fields were created for age, balance, campaign, day,
     pdays and previous. Valid negative balances and pdays=-1 fall within
     the computed limits and are retained.
   - Transformations: default interval method=(none), default class
     method=(none), and missing treatment=Separate. No transformed outputs
     were created.
   - Imputation: impute non-missing variables=OFF; missing cutoff=50%;
     class method=Count; interval method=Mean; data limits=All data (5%).
     All inputs had zero missing and zero imputable values, so the node made
     no material replacements.
   - Variable Selection, Variable Clustering and optional Logistic
     Regression are also Model Studio steps. This program validates and
     promotes the source table; it does not reproduce point-and-click nodes.
*/
