#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ordinal)

#load the fitted model
load("../models/model_no_lieu.bin")


#prepare user data

build_user_features <- function(in_feats) {
  user_feats  = expand.grid(sexe=in_feats$sexe, 
                            age=in_feats$age,
                            taillemenage=in_feats$taillemenage,
                            education=in_feats$education,
                            nbadulte=in_feats$nbadulte,
                            region=in_feats$region)
  return(user_feats)
}

#Probabilities and category predictions

predict_probabilities <- function(in_feats){
  user_feats = build_user_features(in_feats)
  res.probs = predict(model, user_feats, type="prob")
  df = as.data.frame(res.probs$fit)
  
  return(df)
}

predict_class <- function(in_feats){
  user_feats = build_user_features(in_feats)
  res.class = predict(model, user_feats, type="class")
  levl = (as.character(res.class$fit))
  
  return(levl)
}


predict_user_prob <- function(in_feats) {
  user_feats  = expand.grid(sexe=in_feats$sexe, 
                            age=in_feats$age,
                            taillemenage=in_feats$taillemenage,
  education=in_feats$education,
  nbadulte=in_feats$nbadulte,
  region=in_feats$region)
  
  #View(user_feats)
  print(user_feats)
  
  
  
  res.probs = predict(model, user_feats, type="prob")
  res.class = predict(model, user_feats, type="class")
  return(list("probs" = res.probs, "class" = res.class))
  #return res
}

render_predictions_text <- function(res){
  res = paste("Probs:", res$probs, " | ", "Class: ", res$class)
}


# Define server logic required to draw a histogram
server <- function(input, output, session) {

    #Textual results
    
    output$predProbs <- renderTable(predict_probabilities(input))
    output$predClass <- renderText(predict_class(input))
    
    output$predictionResults <- renderText(
      render_predictions_text(
        predict_user_prob(input)  
      )
    )

}
