#install.packages("faraway")
library(faraway); library(car)
data(gala)
head(gala)
 
model <- lm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, gala)
summary(model)
names(model)
 
deviance(model)
 
anova(model)
 
n = length(gala$Species)
x = matrix(c(rep(1, n), gala$Area,gala$Elevation,gala$Nearest,gala$Scruz,gala$Adjacent),nrow=n,ncol=6)
head(x)
npar = k = 5
J = matrix(1, n, n); head(J)
H = x%*%solve(t(x)%*%x)%*%t(x)
dim(H)
y = gala$Species
 
SQRes = t(y)%*%(diag(n) - H)%*%y;SQRes
SQRes/(n - npar)
SQReg = t(y)%*%(H - J/n)%*%y; SQReg
 
F = (SQReg/k)/(SQRes/(n-k-1)); F
1 - pf(F, k, n - k - 1)
 
sigma2h = (SQRes/(n-k-1)); sigma2h
sqrt(sigma2h)
 
varbeta = solve(t(x)%*%x)*as.vector(sigma2h); varbeta
sdbeta = sqrt(diag(varbeta)); sdbeta
 
betah = solve(t(x)%*%x)%*%t(x)%*%y; betah
 
tbeta0 = betah[1]/sdbeta[1]; tbeta0
tbeta0 = model$coefficients[1]/sdbeta[1]; tbeta0
 
anova(model)
 
x1 = matrix(c(rep(1,n),gala$Area),nrow=n,ncol=2)
 
beta1h = solve(t(x1)%*%x1)%*%t(x1)%*%y;beta1h
H1 = x1%*%solve(t(x1)%*%x1)%*%t(x1)
SQReg1 = t(y)%*%(H1 - J/n)%*%y; SQReg1
 
anova(model)
 
x2 = matrix(c(rep(1,n),gala$Area, gala$Elevation),nrow=n,ncol=3)
dim(x2)
 
beta2h = solve(t(x2)%*%x2)%*%t(x2)%*%y;beta2h
H2 = x2%*%solve(t(x2)%*%x2)%*%t(x2)
SQReg2 = t(y)%*%(H2 - J/n)%*%y; SQReg2
 
SQReg2 - SQReg1
 
anova(model)
 
## ANOVA faz pras duas variaveis e em seguida subtrai a outra
 
x3 = matrix(c(rep(1,n),gala$Area, gala$Elevation, gala$Nearest),nrow=n,ncol=4)
 
beta3h = solve(t(x3)%*%x3)%*%t(x3)%*%y;beta3h
H3 = x3%*%solve(t(x3)%*%x3)%*%t(x3)
SQReg3 = t(y)%*%(H3 - J/n)%*%y; SQReg3
 
SQReg3 - SQReg2
 
anova(model)
 
## LM SEM INTERCEPTO
 
model2 <- lm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent - 1, gala)
summary(model2)
 
## LM SÓ COM INTERCEPTO
 
model3 <- lm(Species ~ 1, gala)
summary(model3)
 
## Teste H0 : beta1 = ... = beta5 = 0
 
## achar matriz C
q = 5
C = matrix(c(0, 1, 0, 0, 0, 0,
             0, 0, 1, 0, 0, 0,
             0, 0, 0, 1, 0, 0,
             0, 0, 0, 0, 1, 0,
             0, 0, 0, 0, 0, 1),nrow=q, ncol=k+1, byrow=T);C
betah = as.vector(model$coefficients);betah
 
m = rep(0, q)
num = t(C%*%betah-m)%*%solve(C%*%solve(t(x)%*%x)%*%t(C))%*%(C%*%betah-m)
num
dem = SQRes
n-k-1
 
F = (num/q)/(dem/(n-k-1)); F
1 - pf(F, q, n - k - 1)
 
## rapido
model <- lm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, gala)
modelb0 <- lm(Species ~ 1, gala)
anova(modelb0, model) # do modelo completo, subtrai o modelo com intercepto (b_0, ..., b_5) - b_0
 
## mais rapido
library(car)
 
linearHypothesis(model,
                 c("Area=0",
                   "Elevation=0",
                   "Nearest=0",
                   "Scruz=0",
                   "Adjacent=0"))
 
linearHypothesis(model,
                 c("Area=Elevation",
                   "Elevation = Nearest",
                   "Nearest=Scruz",
                   "Scruz=Adjacent"))
 
q = 4
C = matrix(c(0, 1, -1, 0, 0, 0,
             0, 0, 1, -1, 0, 0,
             0, 0, 0, 1, -1, 0,
             0, 0, 0, 0, 1, -1),nrow=q, ncol=k+1, byrow=T);C
betah = as.vector(model$coefficients);betah
 
m = rep(0, q)
num = t(C%*%betah-m)%*%solve(C%*%solve(t(x)%*%x)%*%t(C))%*%(C%*%betah-m)
num
dem = SQRes
n-k-1
 
F = (num/q)/(dem/(n-k-1)); F