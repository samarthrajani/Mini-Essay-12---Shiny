dataset <- data.frame(read.csv('/Users/Samarthsumitrajani/Downloads/Auschwitz_Death_Certificates_1942-1943 - Auschwitz.csv'))
unique_nationalities <- table(dataset$Birthplace)
sorted_nationality_counts <- sort(unique_nationalities, decreasing = TRUE)
sorted_nationality_counts