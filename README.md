# ProgrammingAssignmentWeek4Course3

This README file explains the analysis file run_analysis.R where data is dowloaded from the website, cleaned and merges into a combined data set

The run_analysis.R script can be read as follows:
1. First the working directory is set
2. The website adress is obtained where the avaibable data can be downloaded from
3. A directory is created where the data is stored (if this directory already exsist, this step is skipped)
4. The data is unzipped
5. Load the different train and test data sets
6. Load the subject train and test data sets
7. Load the activity labels and give them appropiate column names
8. Load the features
9. Find the features indices where only the mean and std are given
10. Define the feature labels where only the mean and std's are given and rename them in appropiate label names
11. Extract only the mean and std values from the train and test data sets
12. First merge the train and test data sets with the labels and activitynames
13. Combine the train and test data sets into a total data set
14. Melt the data over activity and subject to create a combined dataset 
15. Cast the data for each activity for each subject to obtain the average for each variable
16. Write the output to a .txt file using write.table()
