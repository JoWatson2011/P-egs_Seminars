#make sure you have got the appropriate packages installed before using them
#to install a package type install.packages("replace.this.with.package.name")
rm(list= ls())
library(plyr)
library(ggplot2)
library(gridExtra) #this is the library that allows you to group plots
#Count the number of observations per species
t1<-count(iris, c("Species"))
t1

#Find the Mode, mean and Median

#Mode
# Create the function.
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Calculate the mode using the user function.
t2 <- getmode(iris$Petal.Length)
print(t2)

#Mean
mean(iris$Petal.Length)

#Median
median(iris$Petal.Length)


#Make a count to use in some plots
t3 = count(iris, c("Species", "Sepal.Width"))
t3

#easiest plot
plot(t3)

#Bar chart
ggplot(data=t3, aes(x=Sepal.Width, y=freq))+
  geom_bar(stat="identity")

#Line graph
ggplot(data=t3, aes(x=Sepal.Width, y=freq))+
  geom_line(stat="identity")

#Scatter plot
ggplot(data=t3, aes(x=Sepal.Width, y=freq))+
  geom_point(stat="identity")

#changing colours (and storing the plot to use later)
one<-ggplot(data=t3, aes(x=Sepal.Width, y=freq, col="red"))+
  geom_point(stat="identity")

#Shifting legends (and storing the plot to use later)
two<-ggplot(data=t3, aes(x=Sepal.Width, y=freq, col="red"))+
  geom_point(stat="identity")+
  theme(legend.position = c(0.8, 0.6))

#Changing text size (and storing the plot to use later)
three<-ggplot(data=t3, aes(x=Sepal.Width, y=freq, col="red"))+
  geom_point(stat="identity")+
  theme(axis.title.y=element_text(face = "bold", size=20))+
  theme(legend.position = c(0.8, 0.6))

#grouping plots
grid.arrange(arrangeGrob(one,three, ncol=2, nrow=1,layout_matrix = rbind(c(1,2))))

#Testing two proportions

s2<-data.frame(1000, 2000)   #taking the test value and total
s3<-data.frame(7000,15000)   #taking the comparison value and total
s2<-t(s2) #reshaping the data
s3<-t(s3)
s2 <- as.matrix(s2) #making it a readable datatype
s3 <- as.matrix(s3)
res <- prop.test(x = s2[c(1, 2)], n = s3[c(1, 2)]) #running the test

res #Printing the results
