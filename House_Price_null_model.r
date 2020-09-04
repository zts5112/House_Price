library(data.table)

train <- fread("./project/volume/data/raw/Stat_380_train.csv")

test <- fread("./project/volume/data/raw/Stat_380_test.csv")

sample <- fread("./project/volume/data/raw/Stat_380_sample_submission.csv")

train
test
sample

lmMod <- lm(SalePrice ~ LotFrontage + LotArea + OverallQual + OverallCond + FullBath + HalfBath + TotRmsAbvGrd + YearBuilt + TotalBsmtSF + BedroomAbvGr + GrLivArea + PoolArea + YrSold, data=train)

predictions = predict.lm(lmMod, test)
predictions

sample$SalePrice <- predictions
submission <- sample
submission <- as.data.frame(submission)

for (i in 1:ncol(submission)){
  submission[is.na(submission[,i]), i] <- mean(submission[,i], na.rm = TRUE)
}

submission <- as.data.table(submission)
fwrite(submission, "House_Price_submission1.csv")