data <- data.frame(read.csv('/Users/Samarthsumitrajani/Downloads/Auschwitz_Death_Certificates_1942-1943 - Auschwitz.csv'))
data
Birthplace_counts <- table(data$Birthplace)
Birthplace_counts_dataframe <- as.data.frame(Birthplace_counts)
names(Birthplace_counts_dataframe) <- c("Birthplace", "Count")
write_csv(Birthplace_counts_dataframe, "~/Mini-Essay-12---Shiny/mini_essay_data.csv")