// ==========================================================================

// Lab 11 Data manipulations

// ==========================================================================

// standard opening options

set more off
set linesize 80

// ==========================================================================

/*
file name - data.do

project name - SOC5050: Quantitative Analysis, Fall 2016

purpose - Creates variables needed for lab 11

created - 05 Nov 2016

updated - 05 Nov 2016

author - CHRIS
*/

// ==========================================================================

/*
full description -
This do-file completes all data cleaning and variable creation for Lab 11.
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

// open data
use "$projName/$newData"

// ==========================================================================
// ==========================================================================
// ==========================================================================

// 1. Create a new race variable
generate race = PTDTRACE
recode race (-1=.) (1=1) (2=2) (3=4) (4=5) (5=6) (6/21=7)
label define race 1 "White" 2 "Black" 4 "Native" 5 "Asian" ///
  6 "Hawaiian" 7 "MultiRacial"
label values race race
label variable race "Simplified Race"

notes race: [SOURCE] This is a recode of the variable PTDTRACE
notes race: [DATA] All values for multi-racial individuals are collapsed ///
  into a single category for analytical purposes.
notes race: [DATA] Value 3 omitted - will be used for latinos in ///
  subsequent versions of this variable.
notes race: [CHANGES] Variable created by CHRIS on 05 Nov 2016

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 2. Practice using assert statements
assert race == . if PTDTRACE == -1
assert race == 1 if PTDTRACE == 1
assert race == 2 if PTDTRACE == 2
assert race == 4 if PTDTRACE == 3
assert race == 5 if PTDTRACE == 4
assert race == 6 if PTDTRACE == 5
assert race == 7 if PTDTRACE >= 6 & PTDTRACE <= 21

// ==========================================================================

// 3. Create a new latino variable
generate latino = PRDTHSP
recode latino (-1=0) (1/4=1) (5=0)
label define noYes 0 no 1 yes
label values latino noYes
label variable latino "Simplified Latino Ethnicity"

notes latino: [SOURCE] This is a recode of the variable PRDTHSP
notes latino: [DATA] This variable excludes individuals who identify ///
  as spanish to reflect differences between identifying as ///
  latino and hispanic.
notes latino: [CHANGES] Variable created by CHRIS on 05 Nov 2016

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 4. Practice using assert statements
assert latino == 0 if PRDTHSP == -1 | PRDTHSP == 5
assert latino == 1 if PRDTHSP >= 1 & PRDTHSP <= 4

// ==========================================================================

// 5. Crate combined race ethnicity variable
generate raceEthnic = race
replace raceEthnic = 3 if latino == 1
label define raceEthnic 1 "White, nonLatino" 2 "Black, nonLatino" ///
  3 "Latino" 4 "Native" 5 "Asian" 6 "Hawaiian" 7 "MultiRacial"
label values raceEthnic raceEthnic
label variable raceEthnic "Combined Race/Ethnicity"

notes raceEthnic: [SOURCE] This is a combination of the variables race ///
  and latino
note raceEthnic: [DATA] Individuals are assigned as latino if the ///
  variable latino is equal to 1, otherwise they retain their value ///
  in the variable race.
note raceEthnic: [CHANGES] Variable created by CHRIS on 05 Nov 2016

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 6. Practice using assert statements
assert raceEthnic == 1 if race == 1 & latino == 0
assert raceEthnic == 2 if race == 2 & latino == 0
assert raceEthnic == 3 if latino == 1
assert raceEthnic == 4 if race == 4 & latino == 0
assert raceEthnic == 5 if race == 5 & latino == 0
assert raceEthnic == 6 if race == 6 & latino == 0
assert raceEthnic == 7 if race == 7 & latino == 0

// ==========================================================================

// 7. Create dummy variables based on the variable raceEthnic

tabulate raceEthnic, generate(raceDum)

local newNames "whiteBin blackBin latinoBin nativeBin asianBin hawaiiBin multiRaceBin"
local varLabels `""White, NonLatino" "Black, NonLatino" "Latino" "Native American" "Asian" "Native Hawaiian & Pacific Islander" "Multi-Racial" "'

forvalues i = 1/7 {
  local x : word `i' of `newNames'
  local y : word `i' of `varLabels'

  rename raceDum`i' `x'
  label values `x' noYes
  label variable `x' "Race/Ethnicity - `y'"
  notes `x': [SOURCE] This is created from raceEthnic.
  notes `x': [CHANGES] Variable created by CHRIS on 05 Nov 2016
}

// ==========================================================================

// 8. Create binary versions of continuous variables

local newNames "hrsMain hrsSecond hrsTotal"
local varLabels `""Main Job" "Second Job" "Total" "'
local i = 1

foreach var of varlist PEHRUSL1 PEHRUSL2 PEHRUSLT {
  local x : word `i' of `newNames'
  local y : word `i' of `varLabels'

  summarize `var'
  local mean = r(mean)

  generate `x' = .
  replace `x' = 0 if `var' <= `mean'
  replace `x' = 1 if `var' > `mean'
  label values `x' noYes
  label variable `x' "Hours Worked > Mean - `y'"
  notes `x': [SOURCE] This is created from `var'.
  notes `x': [CHANGES] Variable created by CHRIS on 05 Nov 2016

  local ++i
}

// ==========================================================================

// 9. Drop all unneeded variables
keep race-hrsTotal

// ==========================================================================

// 10a. Label dataset
label data "CPS analysis dataset - Lab 11 - 05 Nov 2016"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 10b. Dataset notes
notes _dta: [SOUCE] Created from the original 2011 CPS dataset
notes _dta: [DATA] Contains data on race, ethnicity, and hours worked
notes _dta: [CHANGES] Dataset created by CHRIS on 05 Nov 2016

// ==========================================================================

// 11a. Create variable index
quietly log using "$projName/$projName-Index.txt", text replace name(index)
describe
quietly log close index

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 11b. Create codebook
quietly log using "$projName/$projName-CodeBook.txt", text replace ///
  name(codebook)
codebook, header notes
quietly log close codebook

// ==========================================================================
// ==========================================================================
// ==========================================================================

// save altered data
save "$projName/$newData", replace

// ==========================================================================

// exit
