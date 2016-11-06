Lab-11
======

-   SOC 5050: Quantitative Analysis
-   05 Nov 2016
-   CHRIS

### Descriptive Statistics
```stata
.  tabulate race, sort

 Simplified |
       Race |      Freq.     Percent        Cum.
------------+-----------------------------------
      White |    107,712       81.13       81.13
      Black |     13,906       10.47       91.60
      Asian |      6,254        4.71       96.31
MultiRacial |      2,779        2.09       98.40
     Native |      1,450        1.09       99.49
   Hawaiian |        671        0.51      100.00
------------+-----------------------------------
      Total |    132,772      100.00
```

Since `race` is a categorical variable, the only appropriate descriptive
statistic is mode. The modal category is 'White'.

```stata
.  tabulate latino, sort

 Simplified |
     Latino |
  Ethnicity |      Freq.     Percent        Cum.
------------+-----------------------------------
         no |    134,732       89.04       89.04
        yes |     16,576       10.96      100.00
------------+-----------------------------------
      Total |    151,308      100.00

```

Since `latino` is a categorical variable, the only appropriate descriptive statistic is mode. The modal category is 'no' - i.e. non-Latino respondents.

```stata
.  tabulate raceEthnic, sort

        Combined |
  Race/Ethnicity |      Freq.     Percent        Cum.
-----------------+-----------------------------------
White, nonLatino |     92,421       69.61       69.61
          Latino |     16,576       12.48       82.09
Black, nonLatino |     13,311       10.03       92.12
           Asian |      6,127        4.61       96.73
     MultiRacial |      2,521        1.90       98.63
          Native |      1,208        0.91       99.54
        Hawaiian |        608        0.46      100.00
-----------------+-----------------------------------
           Total |    132,772      100.00

```

Since `raceEthnic` is a categorical variable, the only appropriate descriptive statistic is mode. The modal category is 'White, NonLatino'.

```stata
.  summarize whiteBin blackBin latinoBin nativeBin asianBin hawaiiBin multiRaceBin hrsMain hrsSecond hrsTotal

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
    whiteBin |    132,772     .696088    .4599468          0          1
    blackBin |    132,772    .1002546    .3003403          0          1
   latinoBin |    132,772    .1248456     .330545          0          1
   nativeBin |    132,772    .0090983    .0949505          0          1
    asianBin |    132,772    .0461468    .2098037          0          1
-------------+---------------------------------------------------------
   hawaiiBin |    132,772    .0045793    .0675155          0          1
multiRaceBin |    132,772    .0189874     .136481          0          1
     hrsMain |    151,308    .3607278    .4802133          0          1
   hrsSecond |    151,308     .019424    .1380101          0          1
    hrsTotal |    151,308    .3586525    .4796065          0          1
```

Since all of the variables created from `raceEthnic` are dummy variables, the mean can be used to identify the modal category and the percent of cases that are coded as '1'. This is also true for all variables created to represent hours worked.
