 
#	Import the Bollywood data set in Rstudio in a variable named bollywood

  setwd("C:/pgdds/Course 1/Module 2/R/Assignment")
  bollywood <- read.csv("bollywood.csv")
  View(bollywood) 

#	When you import a data set, R stores character vectors as factors (by default)
# You can check the structure of the data frame by using str()
  str(bollywood)

# You can change the attribute 'Movie' from factor to character type using the given command
  bollywood$Movie <- as.character(bollywood$Movie)
	 

#Q1.
#	Access the last 10 movies (from the bottom of the Bollywood data frame) using column bollywood$Movie
# Store the names of those movies in last_10 vector (in the same order)
  tail(bollywood$Movie,10)   
	last_10 <- tail(bollywood$Movie,10)
	
#Q2.
#	Find out the total number of  missing values (NA) in the bollywood data frame.
# Store the result in na_bollywood vector
  
	length(which(is.na(bollywood)))
	na_bollywood <- length(which(is.na(bollywood)))
	  
#Q3
#	Write the command to find out which movie tops the list in terms of Total Collections
# Store the movie name in variable named top_movie
	  
	bollywood[which.max(bollywood$Tcollection),1]
	top_movie <-bollywood[which.max(bollywood$Tcollection),1]

  
#Q4
#	Write the command to find out which movie comes second on the list in terms of Total Collections
# Store the movie name in variable named top_2_movie
  
	#find the length of the Tcollection column
	n <- length(bollywood$Tcollection)
	#sort the Tcollection and pick the second one using partial keyword.Then use the which to identify
	# the position of the second highest Tcollection.Then identify the movie name (Column 1) using 
	# the position identified. 
	top_2_movie <- bollywood[which(bollywood$Tcollection == sort(bollywood$Tcollection,partial=n-1)[n-1]),1]
	
# Now let's find out the movies shot by Shahrukh, Akshay and Amitabh separately.
# subset() function is used for that. The code has already been written for you. 
	
	shahrukh <- subset(bollywood, Lead == "Shahrukh")
	akshay <- subset(bollywood, Lead == "Akshay")
	amitabh <- subset(bollywood, Lead  == "Amitabh")

# You can view what the above data frames look like

		   
#Q5
#	What is the total collection of Shahrukh, Akshay and Amitabh movies individually?
# You can use	a column named 'Tcollection' for this 
 
  shahrukh_collection <- sum(shahrukh$Tcollection)
    
	akshay_collection <- sum(akshay$Tcollection)
    
	amitabh_collection <- sum(amitabh$Tcollection)
    
	
#Q6  
# Write command/s to find out how many movies are in Flop, Average, Hit and Superhit categories in the entire Bollywood data set.
length(which(bollywood$Verdict == 'Flop'))
length(which(bollywood$Verdict == 'Average'))
length(which(bollywood$Verdict == 'Hit'))
length(which(bollywood$Verdict == 'Super Hit'))

   
#You can use SAPPLY function if you want to apply a function specific columns in a data frame 
#You can write a command to find the maximum value of Ocollection, Wcollection, Fwcollecion and Tcollection using sapply
  
#Q7 
# Write a command to find the names of the movies which have the maximum Ocollection, Wcollection, Fwcollecion & Tcollection
# Store the names of 4 movies in same sequence in movie_result vector

  #max_pos vector would contain the positions of the rows where the respective
  # maximum values for the various collections are present
  max_pos <- sapply(bollywood[,4:7], which.max)
  # movie_result vector would contain the movie names with highest collections
  # in the same sequence.
  movie_result <-bollywood[max_pos,1]

   
    


    
    
    