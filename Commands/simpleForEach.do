// ==========================================================================

// Minimal Working Example - Complex foreach Loops

// ==========================================================================

// standard opening options

version 14
log close _all
graph drop _all
clear all
set more off
set linesize 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// change directory

if "`c(os)'" == "MacOSX" {
  cd "/Users/`c(username)'/Desktop"
}
else if "`c(os)'" == "Windows" {
  cd "E:/Users/`c(username)'/Desktop"
}

// ==========================================================================

// open auto.dta dataset preinstalled with Stata
sysuse auto.dta

// ==========================================================================

// loop 1

foreach var of varlist mpg length weight {
	summarize `var'
}

// ==========================================================================

// loop 2

local coreVars "mpg length weight" 

foreach var of local coreVars {
	summarize `var'
}

describe `coreVars'

// ==========================================================================

// loop 3

foreach var of newlist x y z {
	generate `var' = .
}

// ==========================================================================

exit
