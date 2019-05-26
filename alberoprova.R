setwd("~/GitHub/msbd")

library(tree)
set.seed(42)
x <- read.csv("espl.csv", header=T)
head(x)
y <- read.csv("y-2s.csv", header=T)
head(y)

dati <- data.frame(cbind(y, x))
head(dati)
str(dati)

ix <- sample(1:nrow(x), nrow(x)/2)
x_train <- x[ix,]
y_train <- y[ix,]
x_val <- x[-ix,]
y_val <- y[-ix,]
x_val <- x_val[-1,]
y_val <- y_val[-1,]

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
