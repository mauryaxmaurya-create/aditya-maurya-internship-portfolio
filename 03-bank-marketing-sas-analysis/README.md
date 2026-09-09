# Bank Marketing Data Exploration in SAS

## Overview

This project explores the UCI Bank Marketing dataset in SAS Viya to identify customer and campaign characteristics associated with term-deposit subscription. The emphasis is on data quality, interpretable segmentation and defensible preparation for later predictive modelling.

## Dataset

The analysis uses `bank.csv`, a 4,521-row sample containing 16 candidate predictors and the binary outcome `y`. The dataset combines customer attributes, financial variables, current-campaign information and previous-campaign history.

The dataset is not redistributed in this repository. See [data/README.md](data/README.md) for the source and setup instructions.

## Methods

- CSV import and schema validation in SAS
- Duplicate and missing-value checks
- Numeric and categorical profiling
- Target-rate analysis by customer and campaign segment
- Creation of analysis flags and a persisted prepared table
- Explicit separation of pre-call features from post-call information

## Key findings

- The target is imbalanced: 521 subscriptions (11.52%) and 4,000 non-subscriptions (88.48%).
- Semantic `unknown` categories are material even though there are no technical numeric missing values.
- Customers with a successful previous campaign outcome subscribed at 64.34%, compared with 9.10% where the outcome was unknown.
- Housing and personal loan holders had lower observed subscription rates than customers without those loans.
- Retired and student groups had the highest substantial job-group conversion rates, while blue-collar customers had the lowest among large groups.

Call duration was excluded from the proposed pre-call feature set because it is only known after a call ends and would introduce leakage into a targeting model.

## Repository contents

- `src/bank_marketing_analysis.sas` — complete SAS analysis program
- `docs/report.pdf` — analysis report
- `data/README.md` — dataset source and setup notes

## Project context

Individual university project completed for SAS Predictive Business Analytics.
