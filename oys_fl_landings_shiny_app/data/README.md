This is the `data` folder.   
 
- `landings_data.csv` - this file is created using the script `create_landings_data.R`  
- `ReportCreatorResults-County.csv` - this file is downloaded through FWC directly, this is the original data before it is processed using `create_landings_data.R`  to create `landings_data.csv`  
  
This data set is manually updated by the oyster landings data located here: https://public.myfwc.com/FWRI/PFDM/ReportCreator.aspx.  The Commercial Fisheries Landings Summaries allows the user to select the date year range and oysters (as the Species).  

Select the option for "County, Pounds, Average Price, and Estimated Value" for the Suwannee and Apalachicola areas.  
The Suwannee counties used in the `data.csv` file are TAYLOR, DIXIE, and LEVY.  
The Apalachicola counties used in the `data.csv` are FRANKLIN and WAKULLA.  
  
  
The State of Florida data are all of the counties, and this is selected in the FWC Commercial Fisheries Landings Summaries website in the Additional Output Columns as "Statewide: Pounds, Average Price, and Estimated Value". 

