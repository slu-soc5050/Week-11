// ==========================================================================

// Lab 11 Data analysis

// ==========================================================================

// standard opening options

set more off
set linesize 80

// ==========================================================================

/*
file name - analysis.do

project name - SOC5050: Quantitative Analysis, Fall 2016

purpose - Analysis for lab 11

created - 05 Nov 2016

updated - 05 Nov 2016

author - CHRIS
*/

// ==========================================================================

/*
full description -
This do-file completes all analyses for Lab 11.
*/

/*
updates -
none
*/

// ==========================================================================

/*
superordinates  -
- 34434-0001-Data.dta
- master.do
*/

/*
subordinates -
none
*/

// ==========================================================================
// ==========================================================================
// ==========================================================================

// start MarkDoc log
quietly log using "$projName/$projName-markdoc.smcl", ///
  replace smcl name(markdoc)

// OFF
// ==========================================================================
// ON

/***
# Lab-11
  - SOC 5050: Quantitative Analysis
  - 05 Nov 2016
  - CHRIS

### Descriptive Statistics
***/

tabulate race, sort

/***
Since `race` is a categorical variable, the only appropriate descriptive
statistic is mode. The modal category is 'White'.
***/

tabulate latino, sort

/***
Since `latino` is a categorical variable, the only appropriate descriptive
statistic is mode. The modal category is 'no' - i.e. non-Latino respondents.
***/

tabulate raceEthnic, sort

/***
Since `raceEthnic` is a categorical variable, the only appropriate descriptive
statistic is mode. The modal category is 'White, NonLatino'.
***/

summarize whiteBin blackBin latinoBin nativeBin asianBin hawaiiBin multiRaceBin hrsMain hrsSecond hrsTotal

/***
Since all of the variables created from `raceEthnic` are dummy variables,
the mean can be used to identify the modal category and the percent of cases
that are coded as '1'. This is also true for all variables created to
represent hours worked.
***/

// OFF
// ==========================================================================

// end MarkDoc log
quietly log close markdoc

// convert MarkDoc log to Markdown
markdoc "$projName/$projName-markdoc", ///
  replace export(md) install

// ==========================================================================
// ==========================================================================
// ==========================================================================

// exit
