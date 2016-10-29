// ==========================================================================

// Minimal Working Example - Simple forvalues Loops

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

forvalues i = 1/5 {
	display `i'
}

// ==========================================================================

// loop 2

forvalues i = 1(2)9 {
	display `i'
}

// ==========================================================================

// loop 3

// open auto.dta dataset preinstalled with Stata
sysuse auto.dta

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

forvalues i = 1/5 {
	histogram mpg if rep78 == `i', scheme(s2mono)
	graph export fig`i'.png, as(png) width(800) height(600) replace
 }


// ==========================================================================

graph drop _all

exit
