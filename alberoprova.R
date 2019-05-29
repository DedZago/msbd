setwd("~/GitHub/msbd")

library(tree)
set.seed(42)
x <- read.csv("espl.csv", header=T)
head(x)
y <- read.csv("y-2s.csv", header=F)
head(y)

dati <- data.frame(cbind(y, x))
head(dati)
str(dati)

ix <- sample(1:nrow(x), nrow(x)*0.75)
x_train <- x[ix,]
y_train <- y[ix,]
x_val <- x[-ix,]
y_val <- y[-ix,]


dati_train <- dati[ix,]
dati_val <- dati[-ix,]
dati_val <- dati_val[-1165,]
dim(dati_train)
dim(dati_val)


dim(x_train)
dim(x_val)
head(x_val)
head(x_train)

head(y_val)

table(x_train$X == x_val$X)

str(x_train)
head(y_train)
head(x_train)

t1 <- tree(dati_train$tipo~dati_train$intTrapz+dati_train$maxA+dati_train$MVDeriv+
             dati_train$meanA+dati_train$Var+dati_train$Med, split="deviance")
summary(t1)
plot(t1)
text(t1,pretty=0,cex=0.6,col="blue")
temp = prune.tree(t1)

set.seed(42)
cv.hitters = cv.tree(t1 ,FUN=prune.tree )
cv.hitters
plot(cv.hitters$size,cv.hitters$dev,type="b", lwd=3,col="blue")

set.seed(42)
t2 <- prune.tree(t1, newdata=dati_val[, c(2,4:9)])
cv.hitters2 = cv.tree(t2, FUN=prune.tree )
cv.hitters2
plot(cv.hitters$size,cv.hitters$dev,type="b", lwd=3,col="blue")

t2 <- prune.tree(t1, size = 1,   newdata=dati_val)
names(t2)
t2$size
t2$method
plot(t2$dev)
J=t2$size[which.min(t2$dev)]
J
t2$size
plot(t2)

t3 <- prune.tree(t1,best=J)
plot(t3)
t3

?prune.tree


data(fgl, package="MASS")
fgl.tr <- tree(dati_train$tipo~dati_train$intTrapz+dati_train$maxA+dati_train$MVDeriv+
                 dati_train$meanA+dati_train$Var+dati_train$Med, dati_train)
plot(print(fgl.tr))
fgl.cv <- cv.tree(fgl.tr,, prune.tree)
for(i in 2:5)  fgl.cv$dev <- fgl.cv$dev +
  cv.tree(fgl.tr,, prune.tree)$dev
fgl.cv$dev <- fgl.cv$dev/5
plot(fgl.cv)

head(y_train)

library(rpart.plot)
hr_base_model <- rpart(y_train$V2~x_train$maxA+x_train$MVDeriv+
                         x_train$meanA+x_train$Var+x_train$Med, method = "class")
summary(hr_base_model)
#Plot Decision Tree
plot(hr_base_model)
# Examine the complexity plot
printcp(hr_base_model)
plotcp(hr_base_model)
predict(hr_base_model, newdata=x_val)


##########################################################
x <- read.csv("espl.csv", header=T)
head(x)
x <- x[,2:7]
y <- read.csv("y-2s.csv", header=F)
head(y)
y <- y[,2]

dati <- cbind(y, x)
dati <- dati[-1,]
head(dati)
dim(dati)
length(dati$maxA)

library(tree)
set.seed(123)
parte1=sample(1:NROW(dati),NROW(dati)/2) #divido in 2 parti a meta'
parte2=setdiff(1:NROW(dati),parte1)
#crescita fino le foglie


#f1 funzione con risp qualitativa
t1a=tree(dati[parte1,]$y~dati[parte1,]$maxA+dati[parte1,]$MVDeriv+dati[parte1,]$meanA
         +dati[parte1,]$Var+dati[parte1,]$Med+dati[parte1,]$Min,data=dati[parte1,],control=tree.control(nobs=length(parte1),minsize = 2,mindev = 0.001))#crescita con entropia
#se fosse stato f0 avrebbe usato la devianza per la crescita
#control=tree.control(nobs=length(cb1) crescita fino alle foglie
#minsize minima di crescita dei rami
plot(t1a)
text(t1a,cex=0.5)#cex=0.5 grandezza caratteri

#potatura considerando l'insieme di verifica
t2a=prune.tree(t1a,newdata = dati[parte2,])
plot(t2a) #funz di devianza per far crescere l'albero ho usato l'entropia e l'indice di gini 
#ho usato l'entropia perche' e' di default dato che e' la devianza della binomiale

#se avessi messo la risp qnt avrebbe preso di default la gaussiana


#prima cala poi cresce, c'e' un punto di minimo j
J=t2a$size[which.min(t2a$dev)]
J #corrisponde a 6 nodi terminali 
#foglie migliore 
str(t2a)
t2a


t3a=prune.tree(t1a,best = J)
plot(t3a)
text(t3a,cex=0.75)
#sulla parte destra l'albero ha due foglie con la stessa classe dato che da 1 1 come risultati
#perche?
#hanno probabilita' diverse, anche se entrambe >0.5
#se sei giovane e usi metodo pagamento a con chiamate <29 min e + probabile che sei giovane?????? (registrazione)
plot(t3a)
text(t3a,pretty=1)

plot(t3a)
text(t3a,pretty=0) #con lo 0 mi dice esplicitatamente il metodo di pagamento per intero


p8=predict(t3a,newdata=tele.v,type="class") #previsione della classe
et8=tabella.sommario(p8,tele.v$status)


#non voglio la classe ma la probabilita' quindi type="vector
p8a=predict(t3a, newdata=tele.v,type="vector")[,2]
a8=lift.roc(p8a,g,type="crue")
#non e' crescente perche' il nostro modello e' stimato non su casi specifici


##########################################################
x <- read.csv("espl.csv", header=T)
head(x)
x <- x[,2:7]
y <- read.csv("y-2s.csv", header=F)
head(y)
y <- y[,2]

yy <- rep(0, length(y))
yy[y=="shake"] <- 1
table(yy)

dati <- cbind(yy, x)
dati <- dati[-1,]
head(dati)
dim(dati)
length(dati$maxA)

library(tree)
set.seed(123)
parte1=sample(1:NROW(dati),NROW(dati)/2) #divido in 2 parti a meta'
parte2=setdiff(1:NROW(dati),parte1)
#crescita fino le foglie

head(dati)
#f1 funzione con risp qualitativa
t1a=tree(dati[parte1,]$y~dati[parte1,]$maxA+dati[parte1,]$MVDeriv+dati[parte1,]$meanA
         +dati[parte1,]$Var+dati[parte1,]$Med+dati[parte1,]$Min,
         data=dati[parte1,],control=tree.control(nobs=length(parte1),minsize = 2,mindev = 0.001))#crescita con entropia
#se fosse stato f0 avrebbe usato la devianza per la crescita
#control=tree.control(nobs=length(cb1) crescita fino alle foglie
#minsize minima di crescita dei rami
plot(t1a)
text(t1a,cex=0.5)#cex=0.5 grandezza caratteri

#potatura considerando l'insieme di verifica
t2a=prune.tree(t1a,newdata = dati[parte2,])
plot(t2a) #funz di devianza per far crescere l'albero ho usato l'entropia e l'indice di gini 
#ho usato l'entropia perche' e' di default dato che e' la devianza della binomiale

#se avessi messo la risp qnt avrebbe preso di default la gaussiana


#prima cala poi cresce, c'e' un punto di minimo j
J=t2a$size[which.min(t2a$dev)]
J #corrisponde a 6 nodi terminali 
#foglie migliore 
str(t2a)



t3a=prune.tree(t1a,best = J)
plot(t3a)
text(t3a,cex=0.75)
#sulla parte destra l'albero ha due foglie con la stessa classe dato che da 1 1 come risultati
#perche?
#hanno probabilita' diverse, anche se entrambe >0.5
#se sei giovane e usi metodo pagamento a con chiamate <29 min e + probabile che sei giovane?????? (registrazione)
plot(t3a)
text(t3a,pretty=1)

plot(t3a)
text(t3a,pretty=0) #con lo 0 mi dice esplicitatamente il metodo di pagamento per intero


p8=predict(t3a,newdata=tele.v,type="class") #previsione della classe
et8=tabella.sommario(p8,tele.v$status)


#non voglio la classe ma la probabilita' quindi type="vector
p8a=predict(t3a, newdata=tele.v,type="vector")[,2]
a8=lift.roc(p8a,g,type="crue")
#non e' crescente perche' il nostro modello e' stimato non su casi specifici


