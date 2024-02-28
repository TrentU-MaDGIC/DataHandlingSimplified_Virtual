# Data Handling Simplified: Discover the Power of R
# Presented by Trent University Library's Maps, Data and Government Information Center
# Contact: madgichelp@trentu.ca 

#### Review of R Fundamentals ####

##### Running Script #####
# Run script from the source pane with:
# Ctrl + Enter 
# Alt + Enter
# or pressing Run button with your cursor on the line

sqrt(16)

##### Creating objects #####

data <- data.frame(ID = sample(LETTERS[1:10], 5),
                   Value = rnorm(5))

data

##### Running Multiple Commands ##### 

data <- data.frame(ID = sample(LETTERS[1:10], 5),
           Value = rnorm(5))
mean_value <- mean(data$Value)
mean_value

##### Text data #####

# All text inputs MUST be between "" or ''

file_path <- "C:/Users/User/Documents/Data.txt"
file_path

# For this workshop, it is vital that all file paths are between "" or ''!

#### Import Text files (.txt) ####

# Text files (.txt) are imported with read.table().
# read.table()'s main arguments include:
# file: the file which the data are to be imported from
# header: does the file contain column names (TRUE) or not (FALSE) 
# sep: the field separator character. Values on each line of the file
#       are separated by this character
# For more information, please see ?read.table()

##### file.choose() #####

# Import ChristmasBirdCount_2019_SelectCities.txt using file.choose()

# Using file.choose() within any import function (e.g. read.table)
# opens a file selection window, as seen with most other software.

FileChoose_CBC_2019 <- read.table(file = file.choose(),
                                  header = TRUE,
                                  sep = "\t")

# Note: file.choose() opens R's file selection window. Sometimes, this
# does not appear on top of all other windows automatically. 
# If you do not see it, look on your task bar for it
# or minimize RStudio to find it.

##### File path #####

# **Windows Users**, in File Explorer select the file you want then
#   select "Copy path" from the ribbon.

# Windows users, will have to replace all "\" in the file path with "/"
# The quickest method to do this is, using RStudios's Find and Replace
# 1. Highlight the file path
# 2. Select the magnifying glass icon at the top of the source pane
# 3. Check the box beside "In selection"
# 4. In the find field, enter \
# 5. In the replace field, enter /
# 6. Select the "All" button to the right of Replace

# Determine the file path for ChristmasBirdCount_2019_SelectCities.txt
# Then import it accordingly by its file path
FilePath_CBC_2019 <- read.table(
# Change the file path to match your computer!!
  file = "C:/Users/User/Documents/DataHandlingR/Data/ChristmasBirdCount_2019_SelectCities.txt", 
  sep = "\t",  
	header = TRUE) 

##### Working Directory #####

# The working directory is the default location of any files that are imported 
# from or exported to. The working directory simplifies all data imports and 
# exports, but assumes all files are within the same directory.

# getwd() checks the current working directory
getwd()

# If this is not where your files are, use setwd() to set the working directory
# CHANGE THE PATH to where you saved the /DataHandlingR/Data/ directory
setwd("C:/Users/User/Documents/DataHandlingR/Data/")

# You can check all files and sub-directories within the directory with dir():
dir() 

# With the working directory set, we only need to define the file of interest.

# Import ChristmasBirdCount_2019_SelectCities.txt through the working directory
CBC_2019 <- read.table(file = "ChristmasBirdCount_2019_SelectCities.txt", 
                        sep = "\t",  
                       header = TRUE) 

# Through the remainder of this workshop, we will use the working directory
# to import and export data.
						
#### Inspect the data ####

CBC_2019

# head() returns the first 6 rows or values
# Also see tail() which returns the last 6 rows or values
head(CBC_2019) 

# str() displays the data's structure 
str(CBC_2019)

# View() opens the entire data set in a new tab
View(CBC_2019)

#### Import Comma Separated values (.csv) ####

# CSVs are imported with read.csv(). 
# read.csv()'s main arguments include:
# file: the .csv file which the data are to be imported from
# header: does the file contain column names (TRUE) or not (FALSE) 
# For more information, please see ?read.csv

# Use read.csv() to import ChristmasBirdCount_2020_SelectCities.csv
CBC_2020 <- read.csv(file = "ChristmasBirdCount_2020_SelectCities.csv", 
                      header = FALSE) 

# After importing the data, inspect it to ensure it was imported correctly
head(CBC_2020) 

# Use names() to assign new column names
names(CBC_2020) <- c("Location",	"Year",	"Common_Name",	"Count", "Flags")

head(CBC_2020) 

#### Import Microsoft Excel Workbooks (.xlsx) ####

# To import excel workbooks, we can use the openxlsx package.

# Check if openxlsx is installed, if not, install and load it.
if (require(openxlsx) == FALSE) {
  install.packages("openxlsx") # install package
  library(openxlsx) # load package
}

# Import ChristmasBirdCount_2019to2022_SelectCities.xlsx. 

# openxlsx::read.xlsx requires us to define:
# xlsxFile: the .xlsx file and/or path 
# sheet: the sheet number (where the first sheet is 1) or name to be imported

# Using sheet number
CBC_2021 <- read.xlsx(
  xlsxFile = "ChristmasBirdCount_2019to2022_SelectCities.xlsx",  
  sheet = 3) 

# or using the sheet name
CBC_2021 <-read.xlsx(
  xlsxFile = "ChristmasBirdCount_2019to2022_SelectCities.xlsx",  
  sheet = "Y2021") 

head(CBC_2021)


#### Import R data (.rda) ####

# All data within an R environment can be saved and exported, then
# imported into a new R session. Unlike other data imports, object names do 
# not need to be defined. They are set when the data was initially added to R.

# We import a previous R environment with load()
load("Load_files/rda_load.rda")
rda_file_load_message

# Note, if there is an object in the current environment with the same name
# as one in the loaded R environment, R will over write it without warning.
# To check if there are objects of the same name between a current environment
# and one being loaded:

# First, create a test environment with new.env()
test_env <- new.env(parent = emptyenv())
# Second, load the rda file into the test environment
load("Load_files/rda_load.rda", envir = test_env)
# Third, check what names the test environment matches the current environment
ls()[ls() == ls(test_env)]
# If a name matches, check if the data is the same
ls()[ls.str() == ls.str(test_env)] 
# The name and value of rda_file_load_message is the same
# Therefore, overriding it will have no impact

# If the name was the same, but not the structure.
# We can simply rename the object in the current environment before loading
# the .rda file. 

rda_file_load_message0 <- rda_file_load_message
load("Load_files/rda_load.rda")
# Delete the example load data with rm()
rm(rda_file_load_message, rda_file_load_message0, test_env)

# Use the provided load() scripts to load the expected R environment at the 
# beginning of each section from the working directory

##### Challenge 1 #####

load("load_files/Challenge1.rda") 

# What function would one use to import ChristmasBirdCount_2022_SelectCities.txt? 

# read.table()
# read.csv()
# read.xlsx()
# None of the above

#### Combining Data Frames ####

load("load_files/Combining_Data_Frames.rda") 

# We will explore data manipulation through the dplyr package.

# Check if dplyr is installed. If not, install dplyr
if (require(dplyr) == FALSE) {
  install.packages("dplyr") # install package
  library(dplyr)  
  } 

# To combine by rows, data frames must have:
# * the same number of columns
# * columns with the same names
# If these requirement are not stratified,
# the data will not be combined properly

# Let's combine CBC_2019 and CBC_2020
# Check if the data frames have the same number of columns with 
# the same names, we can inspect them (e.g. head())
head(CBC_2019) 
head(CBC_2020) 

# Does each data frame have the same number of columns?
ncol(CBC_2019) == ncol(CBC_2020)

# Do the data frames have the same column names?
names(CBC_2019) == names(CBC_2020)
all(names(CBC_2019) == names(CBC_2020))

# Combine the data frames with bind_rows()
CBC_2019_2020 <- bind_rows(CBC_2020, CBC_2019) 

# Inspecting the result of binding by row of CBC_2020 and CBC_2019,

head(CBC_2019_2020)  # CBC_2020 on top

tail(CBC_2019_2020) # CBC_2019 on bottom

# bind_rows() can consider as many data frames that meet the criteria.
# Add all loaded Christmas Bird Count data frames
CBC_2019_2021 <- bind_rows(CBC_2020, CBC_2019, CBC_2021)

#### Combine columns ####
rm(list = setdiff(ls(), "CBC_2019_2021")) # Clear unnecessary data

load("load_files/Combine_columns.rda") 

# We can also combine data by column, with bind_cols().
# This method only requires two or more data frames have:
# * the same number of rows.

Birdspecific_1 <- read.csv("ChristmasBirdCount_WideFormat_1.csv", header = TRUE)
head(Birdspecific_1)

Birdspecific_2 <- read.csv("ChristmasBirdCount_WideFormat_2.csv", header = TRUE)
head(Birdspecific_2)

# bind_cols() only considers the number of rows then matches the first
# row of one data frame to the first row of the second or more data frame.
# R cannot check if the rows should be matched or not. That is up to you.

nrow(Birdspecific_1) == nrow(Birdspecific_2)

# They do have the same number of rows, 
# therefore we can combine them with bind_cols
Birdspecific <- bind_cols(Birdspecific_1, Birdspecific_2)
head(Birdspecific)

# Notice, the data frame defined first is on the left,
# and the data frame defined second is on the right of Birdspecific.
# This matches the order each data frame was listed.

#### Combine data by values ####
rm(list = setdiff(ls(), "CBC_2019_2021")) 

load("load_files/Combine_values.rda") 

# If row values between data frames do not match, 
# one must combine by value using a join
# Joining requires matching of one or more shared columns to associate the 
# value from one data frame to another.

# For example, let's add the corresponding scientific name to CBC_2019_2021
Scinames <- read.csv(file = "ChristmasBirdCount_ScientificNames.csv", 
                     header = TRUE) 

# Inspect the two data frames to see how we could join them
head(Scinames) 
head(CBC_2019_2021)

# Common_Name is a shared column between these two data frames

CBC_wScinames <- left_join(CBC_2019_2021, Scinames, by = "Common_Name")
head(CBC_wScinames) 
# Notice, Scientific names were added as the last column in CBC_wScinames

# Joining with multiple matching fields:
CBC_Totals <- read.csv(file = "ChristmasBirdCounts_NumberSpeciesreported.csv", 
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

# Join by all shared fields:
CBC_data_joined <- left_join(CBC_wScinames, CBC_Totals, 
                         by = c("Location", "Year")) 
head(CBC_data_joined)

nrow(CBC_wScinames)
nrow(CBC_data_joined)
# No replicated rows from mis-matched values

# Lastly, let's add morphological and ecological details to our dataset,
# provided by the AVONET data set (https://onlinelibrary.wiley.com/doi/full/10.1111/ele.13898) 
AVONET <- read.csv("AVONET_Simplified.csv")

head(AVONET)
head(CBC_data_joined)

##### Challenge 2 #####
rm(list = setdiff(ls(), c("CBC_data_joined", "AVONET"))) 

load("load_files/Challenge2.rda") 

# How would one add AVONET to CBC_data_merged?

# bind_rows(CBC_data_joined, AVONET)
# bind_cols(CBC_data_joined, AVONET)
# left_join(CBC_data_joined, AVONET, by  = "Scientific_Name")

#### Data Frame Manipulation ####

load("load_files/Dataframe_Manipulation.rda") 

CBC_wAvonet <- left_join(CBC_data_joined, AVONET, by  = "Scientific_Name")

#### Subsets and sorting ####

##### Select, re-arrange, and remove columns #####

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
rm(list = setdiff(ls(), "CBC_data")) # Remove unnecessary data 

load("load_files/Dataframe_Subsetrows.rda") # Load the expected R environment for the Data frame manipulation section

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
rm(list = setdiff(ls(), "CBC_data_arranged")) 

load("load_files/SubsettingSort_Steps.rda") 

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
rm(list = setdiff(ls(), "CBC_data_arranged")) # Remove unnecessary data 

load("load_files/Challenge3.rda") # Load the necessary R environment for Challenge 3

# Match filter(), select(), and arrange() with their proper application

# Sort rows
# Subset, re-arrange, and remove columns
# Subset rows

#### Add or alter columns ####
rm(list = setdiff(ls(), "CBC_data_arranged")) # Remove unnecessary data

load("load_files/Add_alter_col.rda") # Load the necessary R environment for the Add or alter columns section

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
rm(list = setdiff(ls(), "CBC_data_cleaned")) # Remove unnecessary data

load("load_files/Challenge4.rda") # Load the necessary R environment for Challenge 4

# Using mutate(), which code would a new column, **Count_Sq**, 
# which represents the Count value squared to the right of
# Count and left of Flags?

# mutate(CBC_data_cleaned, Count_Sq = Count^2)
# mutate(CBC_data_cleaned, Count_Sq = Count^2, .before = Count)
# mutate(CBC_data_cleaned, Count_Sq = Count^2, .after = Count)


#### Piping ####
rm(list = setdiff(ls(), "CBC_data_cleaned"))

load("load_files/Piping.rda") 

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
rm(list = setdiff(ls(), "CBC_data_cleaned")) # Remove unnecessary data

load("load_files/Aggregating.rda") # Load the necessary R environment for the Aggregating section

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
rm(list = setdiff(ls(), "CBC_data_cleaned")) # Remove unnecessary data

load("load_files/Challenge5.rda") # Load the necessary R environment for Challenge 6

# What use of group_by(), mutate(), and/or summarise() would return the following output:

# Habitat        Avg_BeakWidth
# 1 Coastal                 8.66
# 2 Forest                  7.40
# 3 Grassland              11.2 
# 4 Human Modified          8.45
# 5 Marine                 12.4 
# 6 Riverine                9.95
# 7 Shrubland               6.15
# 8 Wetland                14.5 
# 9 Woodland                7.31

# CBC_data_cleaned %>% summarise(Avg_BeakWidth = mean(Beak.Width))
# CBC_data_cleaned %>% mutate(Avg_BeakWidth = mean(Beak.Width))
# CBC_data_cleaned %>%
#   group_by(Habitat) %>%
#   summarise(Avg_BeakWidth = mean(Beak.Width))
# CBC_data_cleaned %>% 
#   group_by(Habitat) %>% 
#   mutate(Avg_BeakWidth = mean(Beak.Width))


#### Export files ####
rm(list = setdiff(ls(), c("CBC_data_cleaned")))

load("load_files/Export.rda") 

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
