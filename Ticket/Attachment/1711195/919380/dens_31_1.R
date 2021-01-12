png("/home/silveira/www/home.logicamix.com/image/imgapex/TXT_DENSITY_PESO_UC_31_33_28.png",width=800,heigh=400);
 
dens <- density(c(0, 0.8492016468573927, 1.0210206707887035, 1.4123533301464943, 1.4604320568426992, 0.8612527903249557, 0.9330719975331035, 1.3245132742869503, 0.5730668819483514, 1.0024451880770735, 1.1266956729058482, 1.2818825125011362, 1.4822988353763173, 0.6451328259874644, 0.6462751542399179, 0.9500932759325922, 0.9556607485326196));
minx <- 1e10;
miny <- 1e10;
maxx <- 0;
maxy <- 0;
if ( minx > min(dens$x) )
{
 minx = min(dens$x);
}
if ( miny > min(dens$y) )
{
 miny = min(dens$y);
}
if ( maxx < max(dens$x) )
{
 maxx = max(dens$x);
}
if ( maxy < max(dens$y) )
{
 maxy = max(dens$y);
}
maxx = 1.1*maxx;
n <- length(dens$y);
dx <- mean(diff(dens$x));
y.unit <- sum(dens$y) * dx;
dx <- dx / y.unit;
x.mean <- sum(dens$y * dens$x) * dx;
y.mean <- dens$y[length(dens$x[dens$x < x.mean])];
x.mode <- dens$x[i.mode <- which.max(dens$y)];
y.mode <- dens$y[i.mode];
y.cs <- cumsum(dens$y);
x.med <- dens$x[i.med <- length(y.cs[2*y.cs <= y.cs[n]])];
y.med <- dens$y[i.med];
plot(dens, main="Distribuicao dos pesos das questoes (UC24 - Grandes Síndromes / Situações Cirúrgicas)", xlab="Peso", ylab="", xlim=c(minx, maxx), ylim=c(miny, maxy), col=c("#063d70"), type="l", lwd=2, lty=1, bty="n");
lines(c(x.mean,x.mean), c(0,y.mean), type="l", lwd=1.5, col="#020d38", lty=2);
lines(c(x.med ,x.med ), c(0,y.med ), type="l", lwd=1.5, col="#0f1f68", lty=3);
lines(c(x.mode,x.mode), c(0,y.mode), type="l", lwd=1.5, col="#1840ec", lty=4);
legend("topright",c("Densidade", "media", "mediana", "moda"), col=c("#063d70", "#020d38","#0f1f68","#1840ec"), lwd=c(2, 1.5, 1.5, 1.5), lty=c(1, 2, 3, 4));
 
dev.off();
 
