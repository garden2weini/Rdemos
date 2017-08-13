# source("~/PycharmProjects/RDemo/shopSale1.R")
# Title     : Shop经度（longitude）／纬度（latitude）／销量的散点图与柱状图
# Objective : 可以查看南京各门店地理位置与销量的关系(门店日销量-TTG.xlsx, nanjing.csv)，期望三维图可以旋转
# Created by: Merlin
# Created on: 8/12/17

# setwd('~/Documents/ShopModel/')
# library(xlsx)
# dat = read.xlsx("门店日销量-TTG.xlsx", sheetName="结果", header=T)
# 使用xlsx加载17M文件会报错“OutOfMemoryError (Java): GC overhead limit exceeded.”，改用openxlsx加载

library(openxlsx)
library(sqldf)

dat <- read.xlsx(xlsxFile =  "~/Documents/ShopModel/门店日销量-TTG.xlsx")
dat[dat=="\\N"] <- 0 # 替换字符串
dat1 = read.csv(file="~/Documents/ShopModel/nanjing.csv",header = FALSE,sep=',',fileEncoding='GBK')
colnames(dat1) <- c("V1","V2","pos_id","V4","latitude","longitude") # 将列名v3更新为pos_id
dat3=merge(dat1, dat, by="pos_id") # 按照posid合并两个表

dat3$V1<-NULL # 删除dat3中的“V1”列
dat3$V2<-NULL
dat3$V4<-NULL
nrow(dat3)  # frame行数，or length(dat3[,1])
result1<-sqldf('select pos_id,latitude,longitude,all_sum from dat3')

# scatterplot3d(result1$latitude, result1$longitude, result1$all_sum, highlight.3d=TRUE, col.axis='blue', col.grid='lightblue', main='scatterplot3d - 1', pch=20)
# 点图(pch='20', lwd = 5, type='h'/'p')
scatterplot3d(result1$latitude, result1$longitude, result1$all_sum, highlight.3d=TRUE,
col.axis='blue', col.grid='lightblue', main='scatterplot3d - 1', pch=20,
xlab='latitude', ylab='longitude', zlab='sale', type='h')

# 柱状图(pch=' ', lwd = 5, type='h')
scatterplot3d(result1$latitude, result1$longitude, result1$all_sum, highlight.3d=TRUE,
col.axis='blue', col.grid='lightblue', main='scatterplot3d - 1', pch=' ',
xlab='latitude', ylab='longitude', zlab='sale', type='h', lwd = 5)

