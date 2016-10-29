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

// loop 1

// open auto.dta dataset preinstalled with Stata
sysuse auto.dta

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

local sourceVars "mpg weight length turn"
local i = 1

foreach var of newlist mpgBin weightBin lengthBin turnBin {
	local source : word `i' of `sourceVars'
	generate `var' = .
	quietly summarize `source'
	replace `var' = 0 if `source' <= r(mean)
	replace `var' = 1 if `source' > r(mean)
	local ++i
}

// ==========================================================================

// loop 2

sysuse auto.dta, clear

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

local sourceVars "mpg weight length turn"
local labels "mileage weight length turn"
local i = 1

foreach var of newlist mpgBin weightBin lengthBin turnBin {
	local source : word `i' of `sourceVars'
	local label : word `i' of `labels'
	generate `var' = .
	quietly summarize `source'
	replace `var' = 0 if `source' <= `r(mean)'
	replace `var' = 1 if `source' > `r(mean)'
	label variable `var' "Binary measure of `label'"
	local ++i
}

// ==========================================================================

// loop 3

sysuse auto.dta, clear

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

local sourceVars "mpg weight length turn"
local labels `""miles per gallon" "weight" "length" "turn""'
local i = 1

foreach var of newlist mpgBin weightBin lengthBin turnBin {
	local source : word `i' of `sourceVars'
	local label : word `i' of `labels'
	generate `var' = .
	quietly summarize `source'
	replace `var' = 0 if `source' <= `r(mean)'
	replace `var' = 1 if `source' > `r(mean)'
	label variable `var' "Binary measure of `label'"
	local ++i
}

// ==========================================================================

exit
