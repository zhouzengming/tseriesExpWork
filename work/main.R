# init script
rm(list = ls());gc();
# set working directory
setwd("/media/zzm/3AAD22D845A051D1/tseries/work")
library(forecast)
# read data
cpi=read.table("./data.csv",sep=",",header = TRUE)
# convert column 1 as date
cpi$DATE=as.Date(cpi$DATE)
# convert into time-series
cpi=ts(cpi$CHNCPIALLMINMEI,start = c(1993,1))
# self-correlation,stable check: false
plot(cpi)
## 一阶差分平稳
# diff 1
cpi.diff1=diff(cpi)
# 绘制一阶差分时序图
plot(cpi.diff1)
# 线性拟合通过系数是否显著判断是否平稳
t<-c(1:335)
cpi.d1lm<-lm(cpi.diff1~t)
# 系数不显著，认为系数为0，是平稳的
summary(cpi.d1lm)
# 白噪声检验，非白噪声，可以进一步分析
for(i in 1:2) print(Box.test(cpi.diff1,type = "Ljung-Box",lag=6*i))
# auto arima
mod1=auto.arima(cpi.diff1)
# auto.arima自动定阶，认为一阶差分后是arma(3,3)模型，即arima(3,1,3)模型
summary(mod1)
# 模型显著性检验，模型残差6阶时通过白噪声检验，12阶时不通过，说明模型提取到了部分信息，但仍未能完全充分提取。
for(i in 1:2) print(Box.test(mod1$residuals,type = "Ljung-Box",lag=6*i))
# 模型预测
# 使用forecast函数生成预测值
forecast_values <- forecast(mod1, h = 10)
# 可视化预测结果
plot(forecast_values)
# 计算预测精度
accuracy(forecast_values)

# 直接使用arima模型拟合
mod2=auto.arima(cpi)
# 使用forecast函数生成预测值
forecast_values2 <- forecast(mod2, h = 10)
# 绘制预测图
plot(forecast_values2)
# 输出后10月预测
forecast_values2$mean

