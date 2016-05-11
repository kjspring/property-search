# Method Name: Clean-Clean method design & pseudocode
# 

Purpose: To clean the data and turn it into a mailing list.

- We want to make sure the following information for the data is cleaned for the database:
    - Name
    - Address
    - City
    - State
    - Zip
- This information needs to be correct and checked so that mail is going to a real address
- Also want to convert any quantifiable data to the same units (lot size)

## Input
- open csv file
- read csv file

## Processing
- Set working directory
- if onwner occupied remove
- if no mailing address remove
    - First get a list of all missing values in the mailing address column.
    - check mailing address with USPS API
        - If not valid delete row
- Convert lot area to square feet if not already
- Create array/list for mailing list

## Output
- Output cleaned data
