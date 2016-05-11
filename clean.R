#' File name: clean-datasource.R
#' Author: Kevin Spring
#' Author email: kevinjspring@gmail.com
#' Purpose: To clean data from the source
#' =============================================

# Import libraries
library(data.table)
# library(RSQLite)
library(RMySQL)

# Determine if Windows or Unix based system
if(.Platform$OS.type == "unix") {
    # Set working directory for Linux based system
    cat("Unix")
    setwd("/home/kevin/Dropbox/work/business/KTD/del_list/TX/Brazoria")
} else {
    # Set Working Directory for Windows based system
    cat("Windows")
    setwd("C:\\data")
}

# Read all the files in the working directory
files = list.files(pattern="*.csv")

# Import the files into a data.table
# dat = do.call(rbind, lapply(files, fread))
dat = fread(files[1], header=TRUE )
# dat = read.table(files[1], header=TRUE)

# Remove some columns
## Tax Year
dat[,TaxYear:=NULL]

## Delinquent
dat[,Delinquent:=NULL]

## Distress
dat[,Distress:=NULL]

## Zip+4
dat[,MZip4:=NULL]

# Change any blanks and <NA> to NA
dat[dat == "" | dat == "NA"] <- NA

# Look for any missing Owner Mailing Address
dat = dat[complete.cases(dat[,MailAddress])]

# Use USPS API to check that the address and ZIP code (if available) is valid


## subset data table for data that have ZIP codes and those that do not have Zip codes
datWithZip = dat[complete.cases(dat[,MZip])]
datWithOutZip = dat[is.na(dat[,MZip])]

# For valid addresses that do not have ZIP code, use UPSP API to find ZIP code
if (is.data.table(datWithOutZip && nrow(datWithOutZip) == 0)) {
    cat("Finding Zip Codes")
    
    # merge the two data tables
    merge(datWithZip, datWithOutZip)
}

# Save Data in ToMail database tabe

# drv <- dbDriver("SQLite")
# con <- dbConnect(drv, dbname = "mail.db")
# dbWriteTable(con, "ToMail", datWithZip, overwrite=TRUE)
# dbGetQuery(con, "SELECT * FROM ToMail")
# dbDisconnect(con)

con <- dbConnect(MySQL(),
                 user = 'aws_kevin',
                 password = '328lasso',
                 host = 'propertyinvest.czjacmsygubx.us-east-1.rds.amazonaws.com',
                 dbname='property')
dbWriteTable(conn = con, name = 'mailingList', value = datWithZip, overwrite=TRUE)
dbDisconnect(con)