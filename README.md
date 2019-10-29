
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PsyHelp

PsyHelp helps you to easily visualize demographic information for your
survey: <https://app.box.com/s/h72rmmnt76k1ht7j043weq24cho60bt6>.

For the main function to work you need to use the following qualtrics
block in your survey: . Alternatively, you can create your own survey
with the following variables labelled as indicated below in your study:

1.  Age (must be numeric, 15 - 100)
2.  Sex
      - 1 - Male
      - 2 - Female
      - 3 - Prefer not to say
3.  Education
      - 1 - Less than high school
      - 2 - High school graduate
      - 3 - Some college
      - 4 - Vocational or Technical Degree
      - 5 - Bachelor’s Degree
      - 6 - Master’s Degree
      - 7 - Doctorate
      - 8 - Professional Degree (MD, JD, etc.)
4.  Ethnicity
      - 1 - Aboriginal/Native
      - 2 - Asian
      - 3 - Black
      - 4 - White
      - 5 - Middle Eastern
      - 6 - Hispanic
      - 7 - East Indian
      - 8 - Mixed Race
      - 9 - Other/Not Listed
5.  Religion
      - 1 - Buddhist
      - 2 - Christian - Catholic
      - 3 - Christian - Protestant
      - 4 - Christian - Other
      - 5 - Hindu
      - 6 - Jewish
      - 7 - Muslim
      - 8 - Sikh
      - 9 - Other
      - 10 - Non-Religious
6.  Politics\_1 (1 - 7)
      - 1 - Progressive
      - 4 - Neutral
      - 7 - Conservative
7.  ResidentialArea
      - 1 - Urban
      - 2 - Suburban
      - 3 - Rural
8.  Income
      - 1 - \> 15,000
      - 2 - 15001 - 25000
      - 3 - 25001 - 35000
      - 4 - 35001 - 50000
      - 5 - 50001 - 75000
      - 6 - 75001 - 100000
      - 7 - 100001 - 150000
      - 8 - 150000 +

## Installation

You can install the latest version of PsyHelp from Github:

``` r

devtools::install_github("ksharpinskyi/PsyHelp")
```

## Example

To create a collection of demograpic graphs for your dataset use the
following code:

``` r

library(PsyHelp)

demo.graphs(yourdataset)
```
