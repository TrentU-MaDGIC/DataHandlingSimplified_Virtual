# Data Handling Simplified: Discover the Power of R
# Presented by Trent University Library's Maps, Data and Government Information Center
# Contact: madgichelp@trentu.ca 

#### Review of R Fundamentals ####

##### Comments #####
# The # in R creates a comment
# Comments are not executable script, used to annotate script 
# or prevent execution

# Comments are also used to create headers (4 #) and sub headers (5 #)
# Headers and sub headers can be used to quickly navigate your code

# Comments can be quickly added or removed with:
# Ctrl + Shift + C on PC
# Cmd + Shift + C on Mac

##### Running Script #####
# Run script from the source pane with:
# Ctrl + Enter (Cmd + Enter on Mac)
# Alt + Enter
# or pressing Run button with your cursor on the line

sqrt(16)

# Putting your cursor on a line and using one of the above methods will run
# command in entirety, even if broken onto different lines

data.frame(ID = sample(LETTERS[1:10], 5),
           Value = rnorm(5))

##### Creating objects #####

# R is an object based environment. Objects are created with the assignment 
# operator, <-.
# object_name <- value(s)

data <- data.frame(ID = sample(LETTERS[1:10], 5),
                   Value = rnorm(5))

# Once an object is assigned to a name, the values can be accessed by calling
# the name. 

data

##### Running Multiple Commands ##### 

# If you wish to run multiple commands at once, 
# you can highlight all the associated lines then run the commands

data <- data.frame(ID = sample(LETTERS[1:10], 5),
           Value = rnorm(5))
mean_value <- mean(data$Value)
mean_value

# R will only run the highlighted text, therefore ensure you highlight all 
# intended commands in their entirety!

##### Text data #####

# All text inputs MUST be between "" or ''
# In the default RStudio colour scheme these values should be green

file_path <- "C:/Users/User/Documents/Data.txt"
file_path

# For this workshop, it is vital that all file paths are between "" or ''!

#### Import Text files (.txt) ####

# Before importing a file to R, let's look at the file in its original state. 
# Using File Explorer, open and examine: 
# ChristmasBirdCount_2019_SelectCities

# Take note if ChristmasBirdCount_2019_SelectCities.txt has column names and
# how the columns are deliminated, also known as separated.

# Text files (.txt) are imported with read.table().
# read.table()'s main arguments include:
# file: the file which the data are to be imported from
# header: does the file contain column names (TRUE) or not (FALSE) 
# sep: the field separator character. Values on each line of the file
#       are separated by this character
# For more information, please see ?read.table()

##### file.choose() #####

# file.choose() is a great method for beginners to import data
# Using file.choose() within any import function (e.g. read.table)
# opens a file selection window, as seen with most other software.
# However, file.choose() is not ideal to automate any process.

# Import ChristmasBirdCount_2019_SelectCities.txt using file.choose()

# IMPORTANT: If you did NOT download, ChristmasBirdCount_2019_SelectCities.txt
# please skip lines 99-101 or run and cancel them

# FileChoose_CBC_2019 <- read.table(file = file.choose(),
#                                   header = TRUE,
#                                   sep = "\t")

# Note: file.choose() opens R's file selection window. Sometimes, this
# does not appear on top of all other windows automatically. 
# If you do not see it, look on your task bar for it
# or minimize RStudio to find it.

##### File path #####

# Instead of manually selecting the file each time, we can provide R the exact 
# location of the file, through its full path. Using the file path improves 
# reproducibility and automation when files are from a variety of directories

# On **Windows Systems**, in File Explorer select the file you want then
#   select "Copy path" from the ribbon.
# For **Mac** users, select the file and press CMD + Option + C

# Once you have copied the file path, it can be pasted into R.
# **Be sure file paths are provided in "" or '' **

# Windows users, will have to replace all "\" in the file path with "/"
# The quickest method to do this is, using RStudios's Find and Replace
# 1. Highlight the file path
# 2. Select the magnifying glass icon at the top of the source pane
# 3. Check the box beside "In selection"
# 4. In the find field, enter \
# 5. In the replace field, enter /
# 6. Select the "All" button to the right of Replace

# Determine the file path ChristmasBirdCount_2019_SelectCities.txt
# Then import it accordingly by its file path
FilePath_CBC_2019 <- read.table(
  file =url("https://raw.githubusercontent.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/main/Data/ChristmasBirdCount_2019_SelectCities.txt"), 
  sep = "\t",  
	header = TRUE) 

##### Working Directory #####

# Lastly, we can import files through the working directory.
# The working directory is the default location of any files that are imported 
# from or exported to. The working directory simplifies all data imports and 
# exports, but assumes all files are within the same directory.

# One can still use the full file path to import other files once the working 
# directory is set.

# To check what the current working directory is, use getwd()
getwd()

# If this is not where your files are, use setwd() to set the working directory
# For this workshop, we will use the working directory of:
# "E:/DataHandlingR/Data/"
# If you are using your personal computer, change the path to where you saved
# the /DataHandlingR/Data/ directory

# On a local PC, you set the working directory. 
# However, if all files are not downloaded we must use the URLs for each file.
# We will use a base URL (url0) to load all the files in
url0 <- "https://raw.githubusercontent.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/main/Data/"

# If setwd() is run with the wrong directory, errors will be returned 
# setwd("D:/DataHandlingR/Data/")

# Import ChristmasBirdCount_2019_SelectCities.txt through the working directory
CBC_2019 <- read.table(file = paste0(url0,"ChristmasBirdCount_2019_SelectCities.txt"), 
                        sep = "\t",  
                       header = TRUE) 
						
#### Inspect the data ####

# Running the data's name will return the entire data (up to R's printing max)
CBC_2019

# With larger data sets, it can be hard to view the data within the console
# Instead, we can use common functions to view the data

# head() returns the first 6 rows or values
# Also see tail() which returns the last 6 rows or values
head(CBC_2019) 

# str() displays the data's structure including: data structure, column names,
#   number of rows, number of columns, data types per column, and first few 
#   values per column.
# Note: str() and glimpse() are synonymous functions
str(CBC_2019)

# If you need to see the data in its entirety, your best option is to use View().
# Note View(), with a capital V, opens the data frame in a new tab.
# Alternatively, examine the data in another software (e.g. Excel)
View(CBC_2019)

#### Import Comma Separated values (.csv) ####

# Another common file format for tabular data is comma separated values (.csv).
# CSVs are imported with read.csv(). 
# read.csv()'s main arguments include:
# file: the .csv file which the data are to be imported from
# header: does the file contain column names (TRUE) or not (FALSE) 
# For more information, please see ?read.table()

# Open and examine ChristmasBirdCount_2020_SelectCities.csv in Excel or a 
# similar software
# Use read.csv() to import ChristmasBirdCount_2020_SelectCities.csv
CBC_2020 <- read.csv(file = paste0(url0,"ChristmasBirdCount_2020_SelectCities.csv"), 
                      header = FALSE) 

# After importing the data, inspect it to ensure it was imported correctly
str(CBC_2020) 

# Notice the column names were automatically assigned
# We can assign the proper column names with names().
names(CBC_2020) <- c("Location",	"Year",	"Common_Name",	"Count", "Flags")

# Re-inspect the data to ensure the column names were properly assigned
head(CBC_2020) 

#### Import Microsoft Excel Workbooks (.xlsx) ####

# The last common file type we will look at today is Microsoft Excel Workbooks.
# R imports a single worksheet from each workbook as a new data frame.

# To import excel workbooks, we use the openxlsx package.

# Check if openxlsx is installed, if not, install and load it.
if (require(openxlsx) == FALSE) {
  install.packages("openxlsx") # install package
  library(openxlsx) # load package
}

# We want to import the 2021 Christmas Bird Counts from 
# ChristmasBirdCount_2019to2022_SelectCities.xlsx. Open and examine 
# this file in File Explorer.

# R will only import a single excel worksheet at one time. 
# To specify the sheet, we need to provide read.xlsx with the 
# sheet number or name 

# openxlsx::read.xlsx requires us to define:
# xlsxFile: the .xlsx file and/or path 
# sheet: the sheet number (where the first sheet is 1) or name to be imported

# Import the 2021 count from ChristmasBirdCount_2019to2022_SelectCities.xlsx
# using the sheet number
CBC_2021 <- read.xlsx(
  xlsxFile = paste0(url0,"ChristmasBirdCount_2019to2022_SelectCities.xlsx"),  
  sheet = 3) 

# or using the sheet name
CBC_2021 <-read.xlsx(
  xlsxFile = paste0(url0,"ChristmasBirdCount_2019to2022_SelectCities.xlsx"),  
  sheet = "Y2021") 

head(CBC_2021)


#### Import R data (.rda) ####

# All data within an R environment can be saved and exported, then
# imported into a new R session. Unlike other data imports, object names do 
# not need to be defined. They are set when the data was initially added to R.

# We import a previous R environment with load()
load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/rda_load.rda"))
rda_file_load_message

# Note, if there is an object in the current environment with the same name
# as one in the loaded R environment, R will over write it without warning.
# To check if there are objects of the same name between a current environment
# and one being loaded:

# First, create a test environment with new.env()
test_env <- new.env(parent = emptyenv())
# Second, load the rda file into the test environment
load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/rda_load.rda"), envir=test_env)
# Third, check what names the test environment matches the current environment
ls() == ls(test_env)  
# If a name matches, check if the data is the same
ls()[ls.str() == ls.str(test_env)] 
# The name and value of rda_file_load_message is the same
# Therefore, overriding it will have no impact

# If the name was the same, but not the structure.
# We can simply rename the object in the current environment before loading
# the .rda file. 

rda_file_load_message0 <- rda_file_load_message
load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/rda_load.rda"))
# Delete the example load data with rm()
rm(rda_file_load_message, rda_file_load_message0, test_env)

# Use the provided load() scripts to load the expected R environment at the 
# beginning of each section from the working directory

##### Challenge 1 #####

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/Challenge1.rda"))

# Open and examine ChristmasBirdCount_2022_SelectCities.txt from file explorer
# Which of the following will successfully import (from the working directory)
# ChristmasBirdCount_2022_SelectCities.txt into R?

# CBC_2022 <- read.table(paste0(url0,"ChristmasBirdCount_2022_SelectCities.txt"), 
#                          header = FALSE, sep = "-")
# CBC_2022 <- read.csv(paste0(url0,"ChristmasBirdCount_2022_SelectCities.txt"), 
#                        header = FALSE)
# CBC_2022 <- read.xlsx("E:/Data/ChristmasBirdCount_2022_SelectCities.txt", 
#                          sheetName = "Count_2019")
# CBC_2022 <- read.table(paste0(url0,"ChristmasBirdCount_2022_SelectCities.txt"),
#                           header = TRUE, sep = "|")

# Be sure to inspect your data!
head(CBC_2022)
str(CBC_2022)

#### Combining Data Frames ####

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/Combining_Data_Frames.rda"))

# We will explore data manipulation through the dplyr package.
# dplyr is a popular package for data manipulation.
# Source: https://dplyr.tidyverse.org/

# Check if dplyr is installed. 
# If not, install dplyr
if (require(dplyr) == FALSE) {
  install.packages("dplyr") # install package
  library(dplyr)  
  }

# Combining data in R has specific requirements.
# First, the basic way to combine data is to stack one data frame on top
# of another with bind_rows().

# To combine by rows, data frames must have:
# * the same number of columns
# * columns with the same names
# If these requirement are not stratified,
# the data will not be combined properly

# Let's combine CBC_2019 and CBC_2020
# To check if the data frames have the same number of columns with 
# the same names, we can inspect them (e.g. head())
head(CBC_2019) 
head(CBC_2020) 

# Alternatively, we can check each criteria specifically:
# Does each data frame have the same number of columns?
ncol(CBC_2019)
ncol(CBC_2020)

# Do the data frames have the same column names?
names(CBC_2019)
names(CBC_2020) 

# Once we have confirmed all both data frames have the same number of and named
# columns, we can combine them with bind_rows.
# bind_rows() only takes the data frames to be combined
# bind_rows() is synonymous with rbind()

CBC_2019_2020 <- bind_rows(CBC_2020, CBC_2019) 

# Inspecting the result of binding by row of CBC_2020 and CBC_2019,
# We can see the data frame provided first in bind_rows() is the top rows:
head(CBC_2019_2020) 
# While the data frame provided second in bind_rows() is the bottom rows:
tail(CBC_2019_2020) 

# bind_rows() can consider as many data frames that meet the criteria.
# Let's add all loaded Christmas Bird Count data frames
# quickly check if CBC_2021 and CBC_2022 meet the necessary criteria
ncol(CBC_2019_2020)
ncol(CBC_2021) 
ncol(CBC_2022)

names(CBC_2019_2020)
names(CBC_2021) 
names(CBC_2022)

CBC_2019_2022 <- bind_rows(CBC_2019_2020, CBC_2021, CBC_2022) 

#### Combine columns ####
rm(list = setdiff(ls(), c("CBC_2019_2022", "url0"))) # Clear unnecessary data

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/Combine_columns.rda"))

# We can also combine data by column, with bind_cols().
# This method only requires two or more data frames have:
# * the same number of rows.

# Suppose we have data set up indicating the counts of a bird as columns.
Birdspecific_1 <- read.csv(paste0(url0,"ChristmasBirdCount_WideFormat_1.csv"), header = TRUE)
head(Birdspecific_1)

Birdspecific_2 <- read.csv(paste0(url0,"ChristmasBirdCount_WideFormat_2.csv"), header = TRUE)
head(Birdspecific_2)

# These data frames have a similar set up, 
# but do not have the same number of columns or named columns
# Therefore, we could consider binding them with bind_cols()
# bind_cols will one data frame to the right of the other, 
# thus matching rows by position. 
# Note: bind_cols() only considers the number of rows then matches the first
# row of one data frame to the first row of the second or more data frame.
# R cannot check if the rows should be matched or not. That is up to you.

# As bind_cols() matches rows, we check if the two data frames have the same 
# number of rows.
nrow(Birdspecific_1)
nrow(Birdspecific_2)

# They do have the same number of rows, 
# therefore we can combine them with bind_cols
Birdspecific <- bind_cols(Birdspecific_1, Birdspecific_2)
head(Birdspecific)

# Notice, the data frame defined first is on the left,
# and the data frame defined second is on the right of Birdspecific.
# This matches the order each data frame was listed.

#### Combine data by values ####
rm(list = setdiff(ls(), c("CBC_2019_2022", "url0"))) 

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/Combine_values.rda"))

# If row values between data frames do not match, 
# one must combine by value using a join
# Rather than matching the number of rows, columns, or column names names
# Joining requires matching of one or more shared columns to associate the 
# value from one data frame to another.

# For example, let's add the corresponding scientific name to CBC_2019_2022
Scinames <- read.csv(file = paste0(url0,"ChristmasBirdCount_ScientificNames.csv"), 
                     header = TRUE) 

# Inspect the two data frames to see how we could join them
head(Scinames) 
head(CBC_2019_2022)

# Common_Name is a shared column between these two data frames
# Therefore, can can join on this column

CBC_wScinames <- left_join(CBC_2019_2022, Scinames, by = "Common_Name")
head(CBC_wScinames) 
# Notice, Scientific names were added as the last column in CBC_wScinames

# Sometimes we have multiple fields that match between data frames.
# For example, let's add the total number of species 
# per CBC count to CBC_wScinames
CBC_Totals <- read.csv(file = paste0(url0,"ChristmasBirdCounts_NumberSpeciesreported.csv"), 
                       header = TRUE) 

# What field(s) match between these data frames?
head(CBC_Totals) 
head(CBC_wScinames)

# Two fields shared, therefore we must join by both
# If all shared fields are not used in the merge, values will be replicated
CBC_data_join1 <- left_join(CBC_wScinames, CBC_Totals, by = "Location") 
nrow(CBC_wScinames)
nrow(CBC_data_join1)
# There are four times more rows than expected
# Because there are four years in the original data per location
# Similarly, if we join just by year, there are 6 unique locations
# joining by year will result in 6x more rows

# Therefore, to join the data properly, we must join by all shared fields.
# This is done by combining, c(), the shared column names in the by argument
CBC_data_joined <- left_join(CBC_wScinames, CBC_Totals, 
                         by = c("Location", "Year")) 
head(CBC_data_joined)

nrow(CBC_wScinames)
nrow(CBC_data_joined)
# No replicated rows from mis-matched values

##### Challenge 2 #####
rm(list = setdiff(ls(), c("CBC_data_joined", "url0"))) 

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/Challenge2.rda")) 

# The AVONET data set 
# (https://onlinelibrary.wiley.com/doi/full/10.1111/ele.13898) 
# details morphological and ecological details for all birds
# How would one add AVONET to CBC_data_merged?

AVONET <- read.csv(paste0(url0,"AVONET_Simplified.csv"))
head(AVONET)
head(CBC_data_joined)

# CBC_wAvonet <- bind_rows(CBC_data_joined, AVONET)
# CBC_wAvonet <- bind_cols(CBC_data_joined, AVONET)
# CBC_wAvonet <- left_join(CBC_data_joined, AVONET, by  = "Scientific_Name")

# Check resulting data frame
head(CBC_wAvonet)

#### Data Frame Manipulation ####
rm(list = setdiff(ls(), c("CBC_wAvonet", "url0"))) # Remove unnecessary data 

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/Dataframe_Manipulation.rda")) 

#### Subsets and sorting ####

##### Select, re-arrange, and remove columns #####

# Our data frame is getting bigger with more columns
# Let's use select() to subset, remove, and/or re-arrange these columns.

# select() takes the data frame to which the columns belong,
# followed by either:
# * the columns to subset
# * the columns to remove
# * and the order of columns to be returned

# Columns may be specified by name (with or without quotations) 
# or by position (e.g. the second column is 2)

head(CBC_wAvonet)
CBC_data <- select(CBC_wAvonet, # Data frame to subset columns from
                   # Columns selected by name
                   Year, Location, Common_Name, 
                   Scientific_Name,Habitat,
                   Trophic.Level,Beak.Width,Count, Flags)
head(CBC_data)
# Notice, only the columns specified were returned. 

# Instead of selecting what columns we want, sometimes it is easier to remove
# unwanted columns. With select(), columns can be removed by placing
# a minus (-) sign in front of the column name

columm_remove <- select(CBC_wAvonet, # Data frame to remove columns from
    # Columns removed by name, as defined by the minus sign (-) before each name
                            -Scientific_Name, -Num_Species_Reported,
                            -starts_with("Beak")) 
# starts_with() is a selection helper, and selects all columns the start with
# the specified letter or phrase.

head(columm_remove)

# If you do not want to remove any columns, and only re-arrange the columns
# We simply need to list all columns in the order desired


##### Subset rows #####
rm(list = setdiff(ls(), c("CBC_data", "url0"))) # Remove unnecessary data 

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/Dataframe_Subsetrows.rda")) # Load the expected R environment for the Data frame manipulation section

# One of the most common operations when handling data, 
# is to subset observations based on one or more criteria to answer a question.
# With dplyr, we accomplish this with filter().

# For example, perhaps we wanted to know which rows observed 5 or more counts
filter_numeric <- filter(CBC_data, # Data frame to subset rows from
                         Count >=  5) # Subset criteria

# Now the data frame only consists of birds that saw counts equal or greater than 5
head(filter_numeric)
nrow(filter_numeric)

# We can also filter by character (aka text or string) values
# For example, include only the Peterborough Christmas Bird Counts
filter_text1 <- filter(CBC_data,
                       Location == "Peterborough")
head(filter_text1)

# Character values filtered with regular expressions using 
# the stringr package and str_detect function

# Install/load the stringr package to allow for more text criteria
if (require(stringr) == FALSE) {
  install.packages("stringr") # install package
  library(stringr) # load package 
}


# Using str_detect() we can search for:
# * Any text that contains a set string:
#     str_detect(column, "string")
# * Any text that begins with a set string:
#     str_detect(column, "^string")
# * Any text that ends with a set string:
#     str_detect(column, "string$")
# * Any string that contains numbers
#     str_detect(column, "\\d")

# For example, let's isolate all scientific names that begin with "Falco".
#  This represents falcons.
filter_text2 <- filter(CBC_data, # Data frame to subset rows from
						str_detect(Scientific_Name, "^Falco")) # Subset criteria, all scientific names that begin with Faclo
head(filter_text2)

# We can also combine criteria within filter() using AND (&) or OR (|) statements

# Subset for values less than 5 AND flagged counts (not NA)
filter_and <- filter(CBC_data, # Data frame to subset rows from
						Count < 5 & !is.na(Flags)) # Subset criteria
head(filter_and)

# Subset for values less than 5 OR flagged counts (not NA)
CBC_data_filter_or <- filter(CBC_data, # Data frame to subset rows from
							Count < 5 | !is.na(Flags)) # Subset criteria
head(CBC_data_filter_or)

##### Sort rows #####

# Often, we want to sort values within a data frame
# This could be to put things in terms of the highest or lowest value
# alphabetically, or chronologically.

# Through dplyr, sorting rows is achieved by arrange()
# arrange() required the data frame, followed by the column(s) to sort by
# By default, arrange() will sort in ascending order (A to Z, 1 to 100)
arrange_1 <- arrange(CBC_data, # Data frame to sort
						Count) # Column to sort by
head(arrange_1)

# If you want to sort a column in descending order (Z to A, 100 to 1).
# specify desc() per column

# We can sort by multiple columns.
# The order each column is provided indicated they are sorted by,
# such that, the data frame is sorted by the first column provided,
#  then the second, and so on.
# R will sort each column in ascending order. If you want to sort by one or more 
# columns in descending order, desc() will have to be specified for each column.
CBC_data_arranged <- arrange(CBC_data, # Data frame to sort
							Year, Location, desc(Count)) # Column to sort by
head(CBC_data_arranged)

##### Sub-setting and sorting: Putting it together #####
rm(list = setdiff(ls(), c("CBC_data_arranged", "url0"))) 

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/SubsettingSort_Steps.rda")) 

# select(), filter(), and arrange() can be used together to answer 
# a wide range of questions. 
# For example, what and how many coastal habitat bird species
# received non-zero counts, 
# during the 2020 Peterborough Christmas Bird Count.

# To answer this questions: we need to filter() for our criteria of interest,
# Simplify the data frame to only variables (columns) of interest with select()
# Then use arrange() to re-order the rows logically

# Step 1: Reduce data set to 
# counted birds (Count > 0 or !is.na(Count))  
# with Coast habitats (Habitat == "Coastal") 
# in Peterborough (Location == "Peterborough")
# during 2020 (Year == 2020)
Step1 <- filter(CBC_data_arranged, Habitat ==  "Coastal" & Year ==  2020 & 
                  Location == "Peterborough" & Count > 0)

# Step 2: Reduce the data frame to only columns of interest
Step2 <- select(Step1, Scientific_Name, Common_Name, Count)

# Step 3: Arrange by descending count
Step3 <- arrange(Step2, desc(Count))
Step3


##### Challenge 3 #####
rm(list = setdiff(ls(), "CBC_data_arranged", "url0")) # Remove unnecessary data 

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/Challenge3.rda")) # Load the necessary R environment for Challenge 3

# Match filter(), select(), and arrange() with their proper application

# Sort rows
# Subset, re-arrange, and remove columns
# Subset rows


#### Add or alter columns ####
rm(list = setdiff(ls(), c("CBC_data_arranged", "url0"))) # Remove unnecessary data

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/Add_alter_col.rda")) # Load the necessary R environment for the Add or alter columns section

# Often we need to create new columns from existing columns.
# This is done with mutate(), which adds new columns or alters an existing 
# column based on function or mathematical operator. 

# To add a column, we use mutate() to specify the data frame to manipulate, 
# then the column to add and how it will be calculated.
# For example, add a new column called Common_Name_CAPS created by
# using the toupper() function on Common_Name.

mutate_newcol0 <- mutate(CBC_data_arranged, 
              # New column name = function or formula based on existing column
              Common_Name_CAPS = toupper(Common_Name)) 

head(mutate_newcol0)


# By default, mutate() places new columns to the right of the last column
# Other positions can be specified with the .before or .after arguments
mutate_newcol1 <- mutate(CBC_data_arranged, # Data frame to add column to
						 # New column name = function or formula based on existing column
						 Beak.Width_cm = Beak.Width/10, 
                            .after = Beak.Width) 
# Use .after to indicate the column which the new column will 
# appear to the right of

head(mutate_newcol1)

# Often we need to alter a column to replace NAs or another value.
# Notice, the CBC data has lots of NAs for species that were observed in 
# other cities and years, but not within a single count.
tail(CBC_data_arranged)

# We can replace these values using ifelse()
# ifelse(test, yes, no) can be read as:
# Test if Count is NA
# If Count is NA, change the value to 0
# If the Count is not NA, keep the original value

CBC_data_cleaned <- mutate(CBC_data_arranged, # Data frame to alter column in
							# Existing col = function or formula based on existing column
							Count = ifelse(test = is.na(Count), yes = 0, no = Count)) 

tail(CBC_data_cleaned)

###### Challenge 4 ##### 
rm(list = setdiff(ls(), c("CBC_data_cleaned", "url0"))) # Remove unnecessary data

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/Challenge4.rda")) # Load the necessary R environment for Challenge 4

# Using mutate(), which code would a new column, **Count_Sq**, 
# which represents the Count value squared to the right of
# Count and left of Flags?

# mutate(CBC_data_cleaned, Count_Sq = Count^2)
# mutate(CBC_data_cleaned, Count_Sq = Count^2, .before = Count)
# mutate(CBC_data_cleaned, Count_Sq = Count^2, .after = Count)


#### Piping ####
rm(list = setdiff(ls(), c("CBC_data_cleaned", "url0")))

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/Piping.rda"))

# Recall the filter-select-arrange example from earlier:
# Step 1: Reduce data set to counted omnivore birds counted in 2020
Step1 <- filter(CBC_data_cleaned, Trophic.Level ==  "Omnivore" & Year ==  2020 & 
                  Location == "Peterborough" & Count > 0)
# Step 2: Simplify the data frame to only columns of interest
Step2 <- select(Step1, Scientific_Name, Common_Name, Count)
# Step 3: Arrange by descending Count
Step3 <- arrange(Step2, desc(Count))

# Piping is a commonly applied method to improve the efficiency and readability
# of R code. The piping operator, %>%, passes object on the left hand side as 
# the data to the function on the right hand side.
# f(data = x, y) is the same as x %>% f(y)

# Therefore, using piping allows us to accomplish multiple data manipulations
# in a single step, without creating a to of objects.

# Using Piping, we can do this in a single step
Step3_pipe <- CBC_data_cleaned %>% 
  # Reduce data set to counted Omnivore birds counted in 2020
  # filter() is applied to CBC_data_cleaned
  filter(Trophic.Level ==  "Omnivore" & Year ==  2020 & 
           Location == "Peterborough" & Count > 0) %>% 
  # Simplify the data frame to only columns of interest
  # select() from the data frame created from filter() above
  select(Scientific_Name, Common_Name, Count) %>%  
  # Arrange by descending Count
  # arrange() applied to the data frame created from select() above
  arrange(desc(Count)) 
Step3_pipe
Step3

#### Aggregating data ####
rm(list = setdiff(ls(), c("CBC_data_cleaned", "url0"))) # Remove unnecessary data

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/Aggregating.rda")) # Load the necessary R environment for the Aggregating section)

# Aggregating data allows us to calculate metrics across or within groups.
# This is common practice in many fields. 

# Within a pipe, data is aggregated (grouped) with the group_by() function. 
# Aggregated values are then calculated using:
# mutate() : compute new variables by group
# or
# summarise() : compute a separate summary row for each group

# Using group_by() %>%  mutate() and group_by() %>% summarise():
# Determine the total number of species observed each year per location,
# and the total number of birds observed

# Using group_by(...) %>%  mutate(....) will add the computed values 
# to each corresponding row
CBC_data_cleaned %>%
  # Calculate values per group: Location_name AND Year
  group_by(Location, Year) %>% 
  # group_by() %>% mutate(): compute new variables by group
  mutate(Total_Count = sum(Count, na.rm = TRUE)) %>% # total number of birds observed 
  data.frame() %>% head()

# Using group_by(...) %>%  summarise(....) reduce the data frame on only the unique groups and calculated values
CBC_data_cleaned %>% 
  # Calculate values per group: Location_name AND Year
  group_by(Location, Year) %>% 
  # group_by() %>% summarise(): compute a separate summary row for each group
  summarise(Total_Count = sum(Count, na.rm = TRUE)) %>% # total number of birds observed
  data.frame() %>% head()

# Applying group_by() %>% summarise() is similar to computing 
# a pivot table in Microsoft Excel

###### Challenge 5 ##### 
rm(list = setdiff(ls(), c("CBC_data_cleaned", "url0"))) # Remove unnecessary data

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/Challenge5.rda")) # Load the necessary R environment for Challenge 6)

# What is the correct code to produce a summary table of average 
# beak width per habitat?
# The table should only show Habitat and Avg_BeakWidth

# CBC_data_cleaned %>% summarise(Avg_BeakWidth = mean(Beak.Width))
# CBC_data_cleaned %>% mutate(Avg_BeakWidth = mean(Beak.Width))
# CBC_data_cleaned %>% 
#   group_by(Habitat) %>% 
#   summarise(Avg_BeakWidth = mean(Beak.Width))
# CBC_data_cleaned %>% 
#   group_by(Habitat) %>% 
#   mutate(Avg_BeakWidth = mean(Beak.Width))


#### Export files ####

rm(list = setdiff(ls(), c("CBC_data_cleaned", "url0")))

load(url("https://github.com/TrentU-MaDGIC/DataHandlingSimplified_Virtual/raw/main/Data/Load_files/Export.rda"))

# Let's create a data frame detailing a summary of:
# 1. Total number of species observed
# 2. Total birds observed
# 3. Mean and standard deviation (sd) 
# of bird counts in Peterborough per year and habitat
# The data frame should only return the grouped values and those calculated,
# not all original values

CBC_summary <- CBC_data_cleaned %>% 
  group_by(Location, Year, Habitat) %>% 
  summarise(Total_Count = sum(Count, na.rm = TRUE),
            Mean_Count = mean(Count, na.rm = TRUE),
            SD_Count = sd(Count, na.rm = TRUE)) %>% 
  arrange(Year, Location, Habitat) %>% 
  data.frame() # Change from a tibble to data frame to make exporting easier



# Now that we have some data calculated, let's export it for future reference.
# All the file types we imported, can be exported as well.

# To keep files organized, let's create an export folder 
# within the working directory. We can do this from R with dir.create()
dir.create("Export") 

# This directory is created in the working directory unless another 
# file path is provided.

# All file export functions (write.XXX) require you to specify the output data 
# set and file name (with extension).

##### Text (.txt) files #####

# Text (.txt) files are created with write.table()
# write.table() requires one to specify:
# 1. x: the object to be written
# 2. file: the path, file name, and file extension to be created
# 3. sep: how the file will be deliminated 
# 4. col.names: If column names are present (TRUE or FALSE)
# 5. row.names: If row names are present (TRUE or FALSE)

head(CBC_summary)
rownames(CBC_summary)

write.table(x = CBC_summary, 
            file = "Export/Counts_per_Habitat_2017_2020.txt", 
            col.names = TRUE, row.names = FALSE, sep = "\t")

# Comma separated values (.csv) files are created with write.csv()
# write.csv() requires one to specify:
# 1. x: the object to be written
# 2. file: the path, file name, and file extension to be created
# 3. row.names: If row names are present (TRUE or FALSE)
# Note: write.csv assumes col.names = TRUE and cannot be altered

##### Comma separated value (.csv) files #####

write.csv(x = CBC_summary, 
          file = "Export/Counts_per_Habitat_2017_2020.csv", 
          row.names = FALSE)

##### Excel Workbooks (.xlsx) #####

# A workbook with a single sheet can be exported with write.xlsx() from openxlsx.
# write.xslx has the arguments of:
# x: the data frame to be exported
# file: the file path to save the xlsx file to

write.xlsx(x = CBC_summary, file = "Export/CBC_summary.xlsx")

# If you want to create a workbook with multiple worksheets,
# we need to combine all data frames into a list:
xlsx_export <- list(Summary = CBC_summary, # List item name = data
                    RawData = CBC_data_cleaned)

str(xlsx_export)

# Assign the list as the data to be exported
write.xlsx(x = xlsx_export, file = "Export/CBC_summary_rawdata.xlsx")
# This will create a single sheet with the name provided in the list
# per data frame

##### R data files (.rda) #####

# To save the R environment, we use save().
# save requires us to specify the objects to save and the file to save them as.

# Using list = ls() saves the entire environment
save(list = ls(), file = "Export/R_Environment.rda")

# Otherwise, indicate what objects you want to save
save(CBC_data_cleaned, CBC_summary, file = "Export/R_objects.rda")
