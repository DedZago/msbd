library(latex2exp)
setwd("./Desktop/PhonePi_SampleServer-master/")
dati = read.csv("./data/bus/accelerometer.txt", header = F)
a = sqrt(as.numeric(as.matrix(dati$V4))^2 +
           as.numeric(as.matrix(dati$V5))^2 +
           as.numeric(as.matrix(dati$V6))^2)
t = dati$V3 - dati$V3[1]
plot(t, a,type="l",ylab = TeX("$||a||$"), xlab = "t (ms)")
abline(h=9.81, lty="dashed", col = 2)

for(i in seq(0,max(t), by = 3000)){
  abline(v=i,col=2, lty = "dashed")
}

mat = matrix(NA, nrow=7, ncol = 215)
for(i in 1:7){
  mat[i,] = a[((i-1)*215+1):(i*215)]
}
mat = cbind(mat, c(1,0,0,1,0,0,0))
plot(mat[4,-216], type="l")

# Accelerazioni nelle tre componenti
plot(t,dati$V4, type="l", col = 1)
lines(t,dati$V5, col = 2)
lines(t,dati$V6, col = 3)
