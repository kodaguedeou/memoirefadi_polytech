##########################  Specification repertoire du travail  #######################

#Dependencies imports
require(foreign)
require(nnet)
require(ggplot2)
require(reshape2)
library(ordinal)
library(brant)
library(MASS)
library(questionr)

#setwd("D:/donneeEDS/CMHR71SV")
setwd("D:/donneeEDS/work")
list.files(".")

#Read data
base = read.spss("CMHR71SV/CMHR71FL.SAV",to.data.frame=TRUE)

#filter data sets
filtered_data = base[c("HV270","HV219","HV220","HV009","HV106.01","HV022","HV041", "HV024")]


#Rename column names to meaningful words
colnames(filtered_data) = c("pauvrete", "sexe", "age", "taillemenage", "education", "lieu_residence", "nbadulte", "region")

#Data conversion
filtered_data$age = as.numeric(filtered_data$age)

#logistic regression 
#using cumulative Link Models(clm) from the ordinal package
#reason: logit is  based on proportionality 

# drop either lieu_residence or region because of perfect collinearity
#m1 <- clm(pauvrete ~ age + sexe + taillemenage + education + lieu_residence + nbadulte + region ,data = filtered_data, link = "logit", doFit = TRUE)

model <- clm(pauvrete ~ age + sexe + taillemenage + education + nbadulte + region ,data = filtered_data, link = "logit", doFit = TRUE)
#model

m3=polr(pauvrete ~ age + sexe + taillemenage + education + nbadulte + region ,data = filtered_data, Hess  = TRUE)
#m3
#save the model to disk
if(!dir.exists("models")){
  dir.create("models")
}

save(model, file = "./models/model_no_lieu.bin")


modele1 = glm(data=filtered_data,pauvrete ~ age + sexe + taillemenage + education + nbadulte + region ,family = binomial(logit))

#modele2 = ordered(pauvrete ~ age + sexe + taillemenage + education + nbadulte + region, data=filtered_data, Hess=TRUE)
#modele2
#predictions for random user ru(age, sexe, taillemenage,education,nbadulte,region)
#class/category prediction
#NB: the predict function is defined in the ordinal package for clm, ie. predict.clm
#predict(modele1, ru, type="class")
#probability prediction
#predict(modele1, ru, type="prob")

drop1(modele1,test="Chisq")
drop(modele1)
#drop1(chisq.test(modele1))
#drop1(model,test="Fisher")
#drop(model, test = "Brant")
#drop1(model, test = "wald")
#fisher.test("pauvrete")
#fisher.test(filtered_data$pauvrete)
#fisher.test()

#brant(model,by.var=F)
#pauvrete 


#filtered_data = MASS::survey
#filtered_data$pauvrete = ordered(filtered_data$pauvrete,levels = c("age","sexe","taillemenage","education","nbadulte","region"))
#model = polr(pauvrete ~ age + sexe + taillemenage + education + nbadulte + region, data=filtered_data, Hess=TRUE)
#summary(model)
#brant(model)

#linear.predict = predict(model, type = "response", newdata = filtered_data)

#calcul de p-value
mm= coef(summary(m3))
mm
p = pnorm(abs(mm[,"t value"]), lower.tail = FALSE)*2
p





