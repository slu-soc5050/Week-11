// ==========================================================================

// Minimal Working Example - Complex forvalues Loop

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

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


local j = 5 
forvalues i = 1/5 {
	histogram mpg if rep78 == `i', scheme(s2mono)
	graph export fig`j'.png, as(png) width(800) height(600) replace
	local j = `j'+2
 }
  
graph close _all

// ==========================================================================

exit
