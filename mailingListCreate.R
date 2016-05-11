#' File name: mailingListCreate.R
#' Author: Kevin Spring
#' Author email: kevinjspring@gmail.com
#' Purpose: To clean data from the source
#' =============================================

library(RMySQL)

# Open connection to the database
con <- dbConnect(MySQL(),
                 user = 'aws_kevin',
                 password = '328lasso',
                 host = 'propertyinvest.czjacmsygubx.us-east-1.rds.amazonaws.com',
                 dbname='property')

# Get the entire MailingList table from the property database

# Remove any duplicate mailing addresses

# Remove any corporate sounding companies

# Save mailing list as CSV
#' - We want to make sure the following information for the data is cleaned for the database:
#' - Name
#' - Address
#' - City
#' - State
#' - Zip

write.csv('')