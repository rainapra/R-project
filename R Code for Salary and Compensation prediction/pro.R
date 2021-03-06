getwd()
setwd("C://Users//raina//Downloads//527-Data Analytics")
data=read.csv("analytics_project.csv", header = T)
data=read.csv("samp.csv", header = T)
dim(data)
# sampling
set.seed(5)
sample_size=150000
sdata = sample(1:nrow(data),sample_size,replace=F)
subdata=data[sdata,]
names(subdata)
subdata=data
dim(subdata)
write.csv(subdata,"C://Users//raina//Downloads//527-Data Analytics//samp.csv", row.names = FALSE)
install.packages("janitor")
library(janitor)
subdata=clean_names(subdata)
names(subdata)

# removal of extra columns


install.packages("dplyr")
library(dplyr)

install.packages("plyr")
library(plyr)
subdata=select(subdata,-c(organization_group_code))
subdata=select(subdata,-c(department))
subdata=select(subdata,-c(union_code))
subdata=select(subdata,-c(job_family_code))
subdata=select(subdata,-c(job_code))
subdata=select(subdata,-c(employee_identifier))
names(subdata)

# negative values numeric columns checking

nrow(subdata[subdata$salaries<0,])
subdata$salaries[subdata$salaries < 0]=mean(subdata$salaries)
nrow(subdata[subdata$overtime <0,])
subdata$overtime[subdata$overtime < 0]=mean(subdata$overtime)
nrow(subdata[subdata$other_salaries <0,])
subdata$other_salaries[subdata$other_salaries < 0]=mean(subdata$other_salaries)
nrow(subdata[subdata$total_salary <0,])
subdata$total_salary[subdata$total_salary < 0]=mean(subdata$total_salary)
nrow(subdata[subdata$retirement <0,])
subdata$retirement[subdata$retirement < 0]=mean(subdata$retirement)
nrow(subdata[subdata$health_and_dental <0,])
subdata$health_and_dental[subdata$health_and_dental < 0]=mean(subdata$health_and_dental)
nrow(subdata[subdata$other_benefits <0,])
subdata$other_benefits[subdata$other_benefits < 0]=mean(subdata$other_benefits)
nrow(subdata[subdata$total_benefits <0,])
subdata$total_benefits[subdata$total_benefits < 0]=mean(subdata$total_benefits)
nrow(subdata[subdata$total_compensation <0,])
subdata$total_compensation[subdata$total_compensation < 0]=mean(subdata$total_compensation)

#check and replace missing na
sum(subdata$year_type == "")
sum(is.na(subdata$year_type))

sum(subdata$year == "")
sum(is.na(subdata$year))
sum(subdata$year == "__NOT_APPLICABLE__")

sum(is.na(subdata$organization_group))
sum(subdata$organization_group == "")
sum(subdata$organization_group == "__NOT_APPLICABLE__")

sum(is.na(subdata$department_code))
sum(subdata$department_code == "")
sum(subdata$department_code == "__NOT_APPLICABLE__")


sum(is.na(subdata$union))
sum(subdata$union == "")
sum(subdata$union == "__NOT_APPLICABLE__")

sum(is.na(subdata$job_family))
sum(subdata$job_family == "")
sum(subdata$job_family == "__NOT_APPLICABLE__")


sum(is.na(subdata$job))
sum(subdata$job == "")
sum(subdata$job == "__NOT_APPLICABLE__")


sum(is.na(subdata$salaries))
sum(subdata$salaries == "")
sum(is.na(subdata$overtime))
sum(subdata$overtime == "")
sum(is.na(subdata$other_salaries))
sum(subdata$other_salaries == "")
sum(is.na(subdata$total_salary))
sum(subdata$total_salary == "")
sum(is.na(subdata$retirement))
sum(subdata$retirement == "")
sum(is.na(subdata$health_and_dental))
sum(subdata$health_and_dental == "")
sum(is.na(subdata$other_benefits))
sum(subdata$other_benefits == "")
sum(is.na(subdata$total_benefits))
sum(subdata$total_benefits == "")
sum(is.na(subdata$total_compensation))
sum(subdata$total_compensation == "")

# check crf
opt=count(subdata$department_code)
crf=table(subdata$department_code)/nrow(subdata)

labels=opt$x
pie(crf,labels)

subdata$department_code[subdata$department_code == ""] = "DPH"
subdata$department_code[subdata$department_code == "__NOT_APPLICABLE__"] = "DPH"
sum(subdata$department_code == "")
sum(subdata$department_code == "__NOT_APPLICABLE__")

opt=count(subdata$union)
crf=table(subdata$union)/nrow(subdata)

labels=opt$x
pie(crf,labels)


sum(is.na(subdata$union))
sum(subdata$union == "")
subdata$union[subdata$union == ""] = "Employees"

cleandata=subdata
names(subdata)

#normalization of numeric columns

normalize = function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

subdata$salaries=normalize(subdata$salaries)
subdata$overtime=normalize(subdata$overtime)
subdata$other_salaries=normalize(subdata$other_salaries)
subdata$total_salary=normalize(subdata$total_salary)
subdata$retirement=normalize(subdata$retirement)
subdata$health_and_dental=normalize(subdata$health_and_dental)
subdata$other_benefits=normalize(subdata$other_benefits)
subdata$total_benefits=normalize(subdata$total_benefits)
subdata$total_compensation=normalize(subdata$total_compensation)
head(subdata)

normdata=subdata
subdata=normdata
# ANOVA
anov=lm(subdata$salaries~subdata$job)
summary(anov)
anova(anov)
names(subdata&job)


anov=lm(subdata$salaries~subdata$union)
summary(anov)
anova(anov)

anov=lm(subdata$salaries~subdata$job_family)
summary(anov)
anova(anov)

anov=lm(subdata$salaries~subdata$department_code)
summary(anov)
anova(anov)

anov=lm(subdata$salaries~subdata$organization_group)
summary(anov)
anova(anov)

# removal of col

# creation of dummies
install.packages("dummies")
library(dummies) 

View(subdata)
head(subdata)

names(subdata)
subdata=dummy.data.frame(subdata,names="year")
subdata=select(subdata,-c(year2013))


subdata=dummy.data.frame(subdata,names="year_type")

subdata=clean_names(subdata)

subdata=dummy.data.frame(subdata,names="organization_group")


subdata=dummy.data.frame(subdata,names="department_code")


subdata=dummy.data.frame(subdata,names="union")


subdata=dummy.data.frame(subdata,names="job_family")


subdata=dummy.data.frame(subdata,names="job")

names(subdata)
           

subdata=select(subdata,-c(jobAquatics))
library(janitor)
subdata=clean_names(subdata)
subdata=select(subdata,-c(job_architecture_bldgs_bdcomm))
subdata=select(subdata,-c(job_cashier_and_fare_collector))
subdata=select(subdata,-c(job_employment_training))
subdata=select(subdata,-c(job_executive_officer))
subdata=select(subdata,-c(job_probation_and_protection_service))
subdata=select(subdata,-c(job_typist_and_support))


# for job family

subdata=select(subdata,-c(job_family_energy_environment))
subdata=select(subdata,-c(job_family_officers))

# for dept code

subdata=select(subdata,-c(department_code203644))
subdata=select(subdata,-c(department_code228855))
subdata=select(subdata,-c(department_code228883))
subdata=select(subdata,-c(department_code228886))
subdata=select(subdata,-c(department_code229010))
subdata=select(subdata,-c(department_code229017))
subdata=select(subdata,-c(department_code229024))
subdata=select(subdata,-c(department_code229259))
subdata=select(subdata,-c(department_code229261))
subdata=select(subdata,-c(department_code229264))
subdata=select(subdata,-c(department_code229987))
subdata=select(subdata,-c(department_code229992))
subdata=select(subdata,-c(department_code229994))
subdata=select(subdata,-c(department_code229997))
subdata=select(subdata,-c(department_code232021))
subdata=select(subdata,-c(department_code232041))
subdata=select(subdata,-c(department_code232051))
subdata=select(subdata,-c(department_code232076))
subdata=select(subdata,-c(department_code232328))
subdata=select(subdata,-c(department_code232362))
subdata=select(subdata,-c(department_code232395))
subdata=select(subdata,-c(department_code291644))
subdata=select(subdata,-c(department_code_adm))
subdata=select(subdata,-c(department_code_art))
subdata=select(subdata,-c(department_code_bos))
subdata=select(subdata,-c(department_code_chf))
subdata=select(subdata,-c(department_code_cii))
subdata=select(subdata,-c(department_code_csc))
subdata=select(subdata,-c(department_code_dpa))
subdata=select(subdata,-c(department_code_env))
subdata=select(subdata,-c(department_code_hom))
subdata=select(subdata,-c(department_code_hrc))
subdata=select(subdata,-c(department_code_hss))
subdata=select(subdata,-c(department_code_juv))
subdata=select(subdata,-c(department_code_llb))
subdata=select(subdata,-c(department_code_sci))

# for org grp
subdata=select(subdata,-c(organization_group_general_administration_finance))

dim(subdata)

dim(dumdata)
dumdata=subdata
compdata=dumdata
# check cor for numeric variables

cor(subdata$salaries,subdata$total_salary, method = "pearson")
cor(subdata$salaries,subdata$overtime, method = "pearson")
# for transformation on var overtime
t=subdata$overtime*subdata$overtime
cor(subdata$salaries,t, method = "pearson")
t=log(subdata$overtime)
t=1/(subdata$overtime)

subdata=select(subdata,-c(overtime))

cor(subdata$salaries,subdata$other_salaries, method = "pearson")
# for transformation on var other_salaries
t=subdata$other_salaries*subdata$other_salaries
cor(subdata$salaries,t, method = "pearson")
t=log(subdata$other_salaries)
t=1/(subdata$other_salaries)
subdata=select(subdata,-c(other_salaries))

cor(subdata$salaries,subdata$retirement, method = "pearson")
cor(subdata$salaries,subdata$health_and_dental, method = "pearson")

# for transformation on var health_and_dental
t=subdata$health_and_dental*subdata$health_and_dental
cor(subdata$salaries,t, method = "pearson")
t=log(subdata$health_and_dental)
t=1/(subdata$health_and_dental)
subdata=select(subdata,-c(health_and_dental))

cor(subdata$salaries,subdata$other_benefits, method = "pearson")

cor(subdata$salaries,subdata$total_compensation, method = "pearson")

cor(subdata$salaries,subdata$total_salary, method = "pearson")

cor(subdata$salaries,subdata$total_benefits, method = "pearson")

#correlation for total_compensation
cor(subdata$salaries,subdata$total_salary, method = "pearson")
cor(subdata$salaries,subdata$overtime, method = "pearson")

# for hold out evaluation
subdata=subdata[sample(nrow(subdata)),]

select.data = sample(1:nrow(subdata),0.7*nrow(subdata))
train.data=subdata[select.data,]
test.data=subdata[-select.data,]

dim(train.data)
dim(test.data)
names(train.data)

#salaries
m1=lm(train.data$salaries ~ .,data=train.data)
summary(m1)

m2=step(m1, direction = "backward", trace = T)

summary(m2)

res=rstandard(m2)
plot (fitted(m2), res, main = "Predicted vs residuals plot")


qqnorm(res)
qqline(res,col=2)

install.packages("normtest")
library(normtest)
install.packages("tseries")
library(tseries)
jarque.bera.test(res)

names(test.data)

y1=predict.glm(m2,test.data)
y=test.data[,165]
rmse_1 = sqrt((y-y1)%*%(y-y1)/nrow(test.data))
rmse_1

install.packages("car")
library(car)
vif(m2)


cor(train.data$total_compensation,train.data$total_benefits, method="pearson") remove total_benefits
cor(train.data$total_compensation,train.data$other_benefits, method="pearson")
cor(train.data$total_compensation,train.data$retirement, method="pearson")     remove retirement
cor(train.data$total_compensation,train.data$total_salary, method="pearson") remove total_salary
cor(train.data$total_compensation,train.data$job_power_and_fire_executive, method="pearson")
cor(train.data$total_compensation,train.data$job_police_and_investigation, method="pearson")
cor(train.data$total_compensation,train.data$job_medical_health_and_diagnostic_expert, method="pearson")
cor(train.data$total_compensation,train.data$job_family_worker, method="pearson")
cor(train.data$total_compensation,train.data$job_family_police_services, method="pearson")
cor(train.data$total_compensation,train.data$job_family_nursing, method="pearson")
cor(train.data$total_compensation,train.data$job_family_management_and_development_agency, method="pearson")
cor(train.data$total_compensation,train.data$union_municipals, method="pearson")
cor(train.data$total_compensation,train.data$union_firefighters, method="pearson")
cor(train.data$total_compensation,train.data$department_code_mta, method="pearson")
cor(train.data$total_compensation,train.data$department_code_fir, method="pearson")
cor(train.data$total_compensation,train.data$department_code_dph, method="pearson")
cor(train.data$total_compensation,train.data$organization_group_public_works_transportation_commerce, method="pearson")
cor(train.data$total_compensation,train.data$organization_group_public_protection, method="pearson")
cor(train.data$total_compensation,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$total_compensation,train.data$organization_group_community_health, method="pearson")

cor(train.data$other_benefits,train.data$total_benefits, method="pearson")
cor(train.data$other_benefits,train.data$retirement, method="pearson")     
cor(train.data$other_benefits,train.data$total_salary, method="pearson")
cor(train.data$other_benefits,train.data$job_power_and_fire_executive, method="pearson")
cor(train.data$other_benefits,train.data$job_police_and_investigation, method="pearson")
cor(train.data$other_benefits,train.data$job_medical_health_and_diagnostic_expert, method="pearson")
cor(train.data$other_benefits,train.data$job_family_worker, method="pearson")
cor(train.data$other_benefits,train.data$job_family_police_services, method="pearson")
cor(train.data$other_benefits,train.data$job_family_nursing, method="pearson")
cor(train.data$other_benefits,train.data$job_family_management_and_development_agency, method="pearson")
cor(train.data$other_benefits,train.data$union_municipals, method="pearson")
cor(train.data$other_benefits,train.data$union_firefighters, method="pearson")
cor(train.data$other_benefits,train.data$department_code_mta, method="pearson")
cor(train.data$other_benefits,train.data$department_code_fir, method="pearson")
cor(train.data$other_benefits,train.data$department_code_dph, method="pearson")
cor(train.data$other_benefits,train.data$organization_group_public_works_transportation_commerce, method="pearson")
cor(train.data$other_benefits,train.data$organization_group_public_protection, method="pearson")
cor(train.data$other_benefits,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$other_benefits,train.data$organization_group_community_health, method="pearson")

cor(train.data$job_power_and_fire_executive,train.data$total_benefits, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$retirement, method="pearson")     
cor(train.data$job_power_and_fire_executive,train.data$total_salary, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$job_police_and_investigation, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$job_medical_health_and_diagnostic_expert, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$job_family_worker, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$job_family_police_services, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$job_family_nursing, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$job_family_management_and_development_agency, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$union_municipals, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$union_firefighters, method="pearson") remove union firefighters
cor(train.data$job_power_and_fire_executive,train.data$department_code_mta, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$department_code_fir, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$department_code_dph, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$organization_group_public_works_transportation_commerce, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$organization_group_public_protection, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$organization_group_community_health, method="pearson")

cor(train.data$job_power_and_fire_executive,train.data$total_benefits, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$retirement, method="pearson")     
cor(train.data$job_power_and_fire_executive,train.data$total_salary, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$job_police_and_investigation, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$job_medical_health_and_diagnostic_expert, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$job_family_worker, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$job_family_police_services, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$job_family_nursing, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$job_family_management_and_development_agency, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$union_municipals, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$union_firefighters, method="pearson") remove union firefighters
cor(train.data$job_power_and_fire_executive,train.data$department_code_mta, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$department_code_fir, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$department_code_dph, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$organization_group_public_works_transportation_commerce, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$organization_group_public_protection, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$organization_group_community_health, method="pearson")



cor(train.data$organization_group_community_health,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$organization_group_public_protection,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$organization_group_public_works_transportation_commerce,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$department_code_dph,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$department_code_fir,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$union_firefighters,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$department_code_mta,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$organization_group_community_health,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$union_municipals,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$job_family_management_and_development_agency,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$job_family_nursing,train.data$job_family_management_and_development_agency, method="pearson")
cor(train.data$job_family_worker,train.data$job_family_management_and_development_agency, method="pearson")
cor(train.data$job_police_and_investigation,train.data$job_family_management_and_development_agency, method="pearson")
cor(train.data$job_power_and_fire_executive,train.data$total_salary, method="pearson")
cor(train.data$union_firefighters ,train.data$union_municipals, method="pearson")
cor(train.data$other_benefits ,train.data$total_benefits, method="pearson")
cor(train.data$total_compensation ,train.data$total_benefits, method="pearson")
cor(train.data$total_benefits ,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$total_benefits ,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$total_benefits ,train.data$organization_group_general_city_responsibilities, method="pearson")
cor(train.data$total_benefits ,train.data$organization_group_general_city_responsibilities, method="pearson")


# removal of var with corelation greater than 0.9 for salary backward
train_s.data=train.data
test_s.data=test.data

train_s.data=select(train_s.data,-c(retirement))
train_s.data=select(train_s.data,-c(total_salary))
train_s.data=select(train_s.data,-c(total_benefits))
train_s.data=select(train_s.data,-c(union_firefighters))


test_s.data=select(test_s.data,-c(retirement))
test_s.data=select(test_s.data,-c(total_salary))
test_s.data=select(test_s.data,-c(total_benefits))
test_s.data=select(test_s.data,-c(union_firefighters))

# influential points
options(max.print=999999999)
influence.measures(m2)
summary(influence.measures(m2))


# run model again after vif once

m5=lm(train_s.data$salaries ~ .,data=train_s.data)
summary(m5)

m6=step(m5, direction = "backward", trace = T)

summary(m6)

# 2nd time model in sal
R_MAX_NUM_DLLS=500
install.packages("ggplot2")
library(ggplot2)
res=rstandard(m6)
plot (fitted(m6), res, main = "Predicted vs residuals plot")

qqnorm(res)
qqline(res,col=2)

install.packages("normtest")
library(normtest)
install.packages("tseries")
library(tseries)
jarque.bera.test(res)

names(test_s.data)
y1=predict.glm(m6,test_s.data)
y=test_s.data[,164]
rmse_1 = sqrt((y-y1)%*%(y-y1)/nrow(test_s.data))
rmse_1

install.packages("car")
library(car)
vif(m4)
names(m6)
new=data.frame()
