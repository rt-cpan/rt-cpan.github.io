library(fitdistrplus)
x1 <- c(6.4, 13.3, 4.1, 1.3, 14.1, 10.6, 9.9, 9.6, 15.3, 22.1, 13.4, 13.2, 8.4, 6.3, 8.9, 5.2, 10.9, 14.4)
f1l <- fitdist(x1, "norm")
gofstat(f1l, print.test = TRUE)
mean <- f1l$estimate[1]
print(mean)
write.table(mean, file="", row.names=FALSE, col.names=FALSE)
