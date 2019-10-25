#' @title Helps Create Demographic Information Graphs easily
#'
#' @description This package provides a demographic function. It only works if your demographic variables are called a certain way.
#'
#' @param data.frame
#'
#' @return combined
#'
#' @examples demo.graphs(yourdatasetname)
#'
#' @export


demo.graphs <- function(dataset){

  library(ggplot2)
  library(gridExtra)

  # Age

  dataset <- as.data.frame(dataset)

  age <- ggplot(data = dataset, aes(x = Age)) +
    geom_histogram(color="white", fill="dimgrey", bins = 20) +
    ggthemes::theme_hc(base_size = 22)  +
    scale_x_continuous(breaks = seq(10, 100, 10)) +
    theme(axis.title.y = element_blank()) +
    geom_vline(xintercept = mean(dataset[,"Age"], na.rm = T), colour = "red", linetype = 2, size = 1.5) + theme(axis.text = element_text(size = 16))

  # Education

  educ.labels <- c("< High \nschool", "High \nschool", "Some \ncollege", "Vocational \nor technical", "Bachelor's \ndegree", "Master's \ndegree", "Doctoral \ndegree", "Professional \ndegree \n(MD, JD, etc)")

  educ <- ggplot(data = dataset, aes(x = Education)) +
    geom_histogram(color="white", fill="dimgrey", binwidth = 1)   +
    ggthemes::theme_hc(base_size = 22) +
    theme(axis.title.y = element_blank()) +
    geom_vline(xintercept = mean(dataset[,"Education"], na.rm = T), colour = "red", linetype = 2, size = 1.5) + theme(axis.text = element_text(size = 16)) +
    scale_x_continuous(breaks = seq(1, 8, 1),  limits = c(0,9), labels = educ.labels)

  # Income

  income.labels <- c("< $15,000", "$15,001 - \n25,000","$25,001 - \n35,000","$35,001 - \n50,000","$50,001 - \n75,000","$75,001 - \n100,000","$100,001 - \n150,000","$150,000 + ")

  income <- ggplot(data = dataset, aes(x = Income)) +
    geom_histogram(color="white", fill="dimgrey", binwidth = 1) +
    ggthemes::theme_hc(base_size = 22)  +
    ggpubr::theme_cleveland() +
    scale_x_continuous(breaks = seq(1, 8, 1), limits = c(0, 9), labels = income.labels) +
    theme(axis.title.y = element_blank()) +
    geom_vline(xintercept = mean(dataset[,"Income"], na.rm = T), colour = "red", linetype = 2, size = 1.5) + theme(axis.text = element_text(size = 16))

  # Political

  political.labels <- c("1 \nLiberal", "2", "3", "4 \nNeutral", "5", "6", "7 \nConservative")

  political <- ggplot(data = dataset, aes(x = Politics_1)) +
    geom_histogram(color="white", fill="dimgrey", binwidth = 1) +
    ggthemes::theme_hc(base_size = 22)  +
    scale_x_continuous(breaks = seq(1, 7, 1), labels = political.labels, limits = c(0, 8)) +
    theme(axis.title.y = element_blank()) +
    geom_vline(xintercept = mean(dataset[,"Politics_1"], na.rm = T), colour = "red", linetype = 2, size = 1.5) + xlab("Political orientation") + theme(axis.text = element_text(size = 16))

  # Primary Residence

  resid.count <- data.frame(table(dataset$Residential_Area))
  resid.count$Prop <- round(resid.count$Freq / sum(resid.count$Freq), 2) * 100

  resid.count <- resid.count[order(resid.count$Var1, decreasing = T) , ]

  resid.count$lab.ypos <- cumsum(resid.count$Prop) - 0.5*resid.count$Prop

  colnames(resid.count)[1:2] <- c("Residence", "n")

  residence.labels <- c("Urban", "Suburban", "Rural")

  residence.index <- as.numeric(names(table(resid.count$Residence)))

  residence.graph.labels <- residence.labels[residence.index]

  resid <- ggplot(resid.count, aes(x = 2, y = Prop, fill = Residence)) +
    geom_bar(stat = "identity", color = "white") +
    coord_polar(theta = "y", start = 0)  +
    geom_text(aes(y = lab.ypos, label = paste(Prop, "%", sep = "")), color = "white", size = 5.5) + xlim(0.5, 2.5) + theme_void(base_size = 20) + scale_fill_brewer(palette = "Dark2", labels = residence.graph.labels)+ theme(legend.position = "right")

  # Gender

  gender.count <- data.frame(table(dataset$Sex))
  gender.count$Prop <- round(gender.count$Freq / sum(gender.count$Freq), 3) * 100

  gender.count <- gender.count[order(gender.count$Var1, decreasing = T) , ]

  gender.count$lab.ypos <- cumsum(gender.count$Prop) - 0.5*gender.count$Prop

  colnames(gender.count)[1:2] <- c("Gender", "n")

  gender.labels <- c("Male", "Female", "Prefer not to Say")

  gender.index <- as.numeric(names(table(gender.count$Gender)))

  gender.graph.labels <- gender.labels[gender.index]

  gender <- ggplot(gender.count, aes(x = 2, y = Prop, fill = Gender)) +
    geom_bar(stat = "identity", color = "white") +
    coord_polar(theta = "y", start = 0)  +
    geom_text(aes(y = lab.ypos, label = paste(Prop, "%", sep = "")), color = "white", size = 5.5) + xlim(0.5, 2.5) + theme_void(base_size = 20) + scale_fill_brewer(palette = "Dark2", labels = gender.graph.labels) + theme(legend.position = "right")



  # Ethnicity

  ethn.count <- data.frame(table(dataset$Ethnicity))
  ethn.count$Prop <- round(ethn.count$Freq / sum(ethn.count$Freq), 3) * 100

  ethn.count <- ethn.count[order(ethn.count$Var1, decreasing = T) , ]

  ethn.count$lab.ypos <- cumsum(ethn.count$Prop) - 0.5*ethn.count$Prop

  colnames(ethn.count)[1:2] <- c("Ethnicity", "n")

  ethn.labels <- c("Aboriginal", "Asian", "Black", "White", "Middle \nEastern", "Hispanic", "East Indian", "Mixed \nRace", "Other")

  ethn.index <- as.numeric(names(table(ethn.count$Ethnicity)))

  ethn.graph.labels <- ethn.labels[ethn.index]

  ethnicity <- ggplot(ethn.count, aes(x = Ethnicity, y = Prop)) +
    geom_bar(stat = "identity", color = "white")  + scale_fill_brewer(palette = "Dark2") + scale_x_discrete(labels = ethn.graph.labels) +
    geom_text(aes(y = Prop, label = paste(Prop, "%", sep = "")), color = "black", size = 7, vjust = -0.5) +
    theme(legend.position = "right") + ggthemes::theme_hc(base_size = 22) + ylim(c(0,100)) +
    labs(x = "Ethnicity", y = "Percentage")




  # Religion

  religion.count <- data.frame(table(demo.test$Religion))
  religion.count$Prop <- round(religion.count$Freq / sum(religion.count$Freq), 3) * 100

  religion.count <- religion.count[order(religion.count$Var1, decreasing = T) , ]

  religion.count$lab.ypos <- cumsum(religion.count$Prop) - 0.5*religion.count$Prop

  colnames(religion.count)[1:2] <- c("Religion", "n")

  religion.labels <- c("Buddhist", "Christian \n(Catholic)", "Christian \n(Protestant)", "Christian \n(Other)", "Hindu", "Jewish", "Muslim", "Sikh", "Other", "Non \n(Religious)")

  religion.index <- as.numeric(names(table(religion.count$Religion)))

  religion.graph.labels <- religion.labels[religion.index]

  religion <- ggplot(religion.count, aes(x = Religion, y = Prop)) +
    geom_bar(stat = "identity", color = "white")  +
    geom_text(aes(y = Prop, label = paste(Prop, "%", sep = "")), color = "black", size = 7, vjust = -0.5) +  theme(legend.position = "right") + ggthemes::theme_hc(base_size = 22) + ylim(c(0,100)) + labs(x = "Religion", y = "Percentage") + scale_x_discrete(labels = religion.graph.labels)



  # Combine into 1 graph

  combined <- grid.arrange(
    grobs = list(educ, income,age, gender, ethnicity,  political, resid, religion),
    widths = c(2, 1, 1),
    heights = c(2, 2, 1.5, 1.5, 2, 2),
    layout_matrix = rbind(c(1, 1, 1),
                          c(2, 2, 2),
                          c(3, 4, 4),
                          c(6, 7, 7),
                          c(5, 5, 5),
                          c(8, 8, 8))
  )


  return(combined)

}

