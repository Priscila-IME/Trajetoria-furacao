require(tseries)
require(forecast)
require(CircStats)
require(spatstat)

beryl <- metricas_furacaop
#f_dist_n <- stats::filter(tay$dist_n, filter = rep(1/3, 3))
library(psych)
describe(beryl[c(2:15)])

par(mfcol = c(2, 3))
#autoplot(ts_dist_n)





# avaliação de métricas de diff_n
hist(beryl$diff_n, main="",xlab="Valores de diff_n (m)",xlim=c(-650000,550000),breaks=seq(-620000,510000,10000),xaxp=c(-620000,510000,100000),ylab="Frequência",ylim=c(0,30))

ts_diff_n <- ts(beryl$diff_n, frequency = 8)
dec.diff_n <- decompose(ts_diff_n) #, type = "multiplicative")
autoplot(dec.diff_n$trend, main="", xlab="Tempo (dias)", ylab="diff_n (m)")


# avaliação de métricas de dist_n
ts_dist_n <- ts(beryl$dist_n, frequency = 8)
dec.dist_n <- decompose(ts_dist_n) #, type = "multiplicative") 
autoplot(dec.dist_n$trend, main="", xlab="Tempo (dias)", ylab="dist_n (m)")







# avaliação de métricas de diff_s
hist(beryl$diff_s, main="",xlab="Valores de diff_s (m)",xlim=c(-650000,550000),breaks=seq(-650000,550000,50000),xaxp=c(-650000,550000,50000),ylab="Frequência")

ts_diff_s <- ts(beryl$diff_n, frequency = 8)
dec.diff_s <- decompose(ts_diff_s) #, type = "multiplicative")
autoplot(dec.diff_s$trend, main="", xlab="Tempo (dias)", ylab="diff_s (m)")


# avaliação de métricas de dist_s
ts_dist_s <- ts(beryl$dist_s, frequency = 8)
dec.dist_s <- decompose(ts_dist_s) #, type = "multiplicative")
autoplot(dec.dist_s$trend, main="", xlab="Tempo (dias)", ylab="dist_s (m)")




# avaliação de métricas de diff_e
hist(beryl$diff_e, main="",xlab="Valores de diff_e (m)",xlim=c(-630000,570000),breaks=seq(-630000,570000,50000),xaxp=c(-630000,570000,100000),ylab="Frequência")

ts_diff_e <- ts(beryl$diff_e, frequency = 8)
dec.diff_e <- decompose(ts_diff_e) #, type = "multiplicative")
autoplot(dec.diff_e$trend, main="", xlab="Tempo (dias)", ylab="diff_e (m)")

# avaliação de métricas de dist_e
ts_dist_e <- ts(beryl$dist_e, frequency = 8)
dec.dist_e <- decompose(ts_dist_e) #, type = "multiplicative")
autoplot(dec.dist_e$trend, main="", xlab="Tempo (dias)", ylab="dist_e (m)")



# avaliação de métricas de diff_w
hist(beryl$diff_w, main="",xlab="Valores de diff_w (m)",breaks=seq(-620000,580000,50000),xaxp=c(-620000,580000,50000),ylab="Frequência")

ts_diff_w <- ts(beryl$diff_w, frequency = 8)
dec.diff_w <- decompose(ts_diff_w) #, type = "multiplicative")
autoplot(dec.diff_w$trend, main="", xlab="Tempo (dias)", ylab="diff_w (m)")


# avaliação de métricas de dist_w
ts_dist_w <- ts(beryl$dist_w, frequency = 8)
dec.dist_w <- decompose(ts_dist_w) #, type = "multiplicative")
autoplot(dec.dist_w$trend, main="", xlab="Tempo (dias)", ylab="dist_w (m)")


# avaliação de métricas de dist_c
ts_dist_c <- ts(beryl$dist_cent, frequency = 8)
dec.dist_c <- decompose(ts_dist_c) #, type = "multiplicative")
autoplot(dec.dist_c$trend,main="", xlab="Tempo (dias)", ylab="dist_c (m)")


