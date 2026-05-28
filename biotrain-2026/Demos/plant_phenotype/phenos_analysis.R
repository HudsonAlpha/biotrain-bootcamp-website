#### data obtained from https://onlinelibrary.wiley.com/doi/10.1111/pbr.13165
####loading the data####
rm(list = ls());ls ()
data <- read.csv("aa_all_env_master.csv", header = T, na.strings = "NA")
head(data)
str(data)

#adjusting the factors
data[,1:11] <- lapply(data[,1:11], factor)
data[,17:83] <- lapply(data[,17:83], as.numeric)
str(data)

####Visualization####

#boxplot divides your data into four equal quarters, each representing 25% of the observations
boxplot(data$protein, col = "red", main = "Protein")
boxplot(data$oil, col = "red", main = "Oil")
boxplot(data$hsw, col = "red", main = "HSW")

#histogram
hist(data$protein, main = "protein")
hist(data$oil, main = "oil")
hist(data$hsw, main = "hsw")

####ANOVA####

m1 <- lm(protein ~ rep + (name + env)^2, data = data)
anova(m1)

m2 <- lm(oil ~ rep + (name + env)^2, data = data)
anova(m2)

m3 <- lm(hsw ~ rep + (name + env)^2, data = data)
anova(m3)

####variance component analysis and heritability####
library (lmerTest)
data$ge<-paste0(data$name,data$env)

#trait variance components
prot_h<-lmer(protein~ 1 + (1|env) + (1|env:rep) + (1|name) + (1|ge), data=data) 
oil_h<-lmer(oil~ 1 + (1|env) + (1|env:rep) + (1|name) + (1|ge), data=data)
hsw_h<-lmer(hsw~ 1 + (1|env) + (1|env:rep) + (1|name) + (1|ge), data=data)

vcs<-list(VarCorr(prot_h),VarCorr(oil_h),VarCorr(hsw_h))

vas<-data.frame(print(vcs,comp=c("Variance")))
vas<-cbind(vas[,c(1,4,9,14)])
colnames(vas)<-c("component","protein","oil","hsw")

##simple formula = vG/vP
##Entry-mean based heritability equation: h2=v_G/[v_G + (v_G*E/E) + (v_e/RE)] 

#heritability protein
he_pro<-vas[2,2]/(vas[2,2]+(vas[1,2]/6 + vas[5,2]/12))
he_pro

#heritability oil
he_oil<-vas[2,3]/(vas[2,3]+(vas[1,3]/6 + vas[5,3]/12))
he_oil

#hundred seed weight
he_hsw<-vas[2,4]/(vas[2,4]+(vas[1,4]/6 + vas[5,4]/12))
he_hsw

#heritability table
her<-c("heritability",he_pro,he_oil,he_hsw)
her_table<-rbind(vas,her)
write.csv(her_table, file = "heritability_table.csv")
