#unit1
setwd("/media/zzm/3AAD22D845A051D1/tseries/code")

#1.4.2 R的安装
#install.packages("tseries")
library(tseries)

#1.4.3 R语言基本规则
sum(1,2,3)
sum(1,2,3)    # 换行分割表达式
x=1;y=2;x+y   # 分号分割表达式
{x=1    # 大括号表示段落
y=2
x+y}
x<-3    # <-赋值
2*x+1->y # ->赋值
z<-y^2    # 平方
x       # 显示变量
y
z

#1.4.4 生成时间序列数据
##时间序列数据展示
price<-c(101,82,66,35,31,7)   # 为向量赋值
price<-ts(price,start=c(2005,1),frequency = 12)   # 转换为时间序列格式
price
price<-scan()   # 输入向量
price<-ts(price,start=c(2005,1),frequency = 12)

# 1-1
x<-read.table("../data/file1.csv",sep=",",header=T)
x
# yield       # 列名不是变量，直接调用会报错
x$yield

#1.4.5 时间序列数据的处理
y<-log(x$yield)   # 取对数
y
z<-subset(x,Year>1925,select=yield) # 取x中year>1925的行中yield值
z
a<-c(1:7)   # 生成向量
a[4]<-NA    # 赋值为空
a
library(zoo)
y1<-na.approx(a)      # 近似插值，默认为线性近似；需要导入zoo库，否则无法使用na.*
y1
y2<-na.spline(a)      # 三次样条插值
y2

#1.4.6 时间序列数据导出
#1-1
ln_yield<-log(x$yield)
x_new<-data.frame(x,ln_yield)
write.table(x_new,file="./outputs/yield.csv",sep=",",row.names = F)
