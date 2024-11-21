
getwd()
library(readxl)
library(stm)
library(wordcloud)
library(tm)
library(splines)

library(igraph)
library(reshape2)
library(patchwork)
library(xlsx)
library(Rmisc)
library(plyr)
library(devtools)
library(stmBrowser)
library(lubridate)
library(ggplot2)
#中文
library(showtext)
showtext_auto(enable = TRUE)
font_add('SimSun', 'simsun.ttc')
Sys.setlocale("LC_TIME", "English")


#3.0读取数据
data <- read_excel(path = "./data_wanhui_guiguangtai.xlsx", sheet = "1", col_names = TRUE)
# data <- read_excel(path = "./forEN.xlsx", sheet = "1", col_names = TRUE)

#3.1ingest
# 调用textProcessor算法，将 data$document、data 作为参数
# 默认为3字符，改为1字符，避免单个汉字被删除
processed <- textProcessor(documents = data$documents, metadata = data, wordLengths = c(1, Inf))
####
meta <- processed$meta 
vocab <- processed$vocab 
docs <- processed$documents 

meta <- processed$meta #原数据
dec312016<-as.numeric(as.Date("2016-12-31"))
meta$day<- as.Date(dec312016+meta$day,origin="1970-01-01")
meta$day<- as.numeric(as.Date(dec312016+meta$day,origin="1970-01-01"))
meta$day<- meta$day-36159+1
 # meta$time<- as.POSIXct(meta$time)
#3.2 prepare
#确定阈值删除低频单词
#plotRemoved()函数可绘制不同阈值下删除的document、words、token数量

# ##查看需要各阈值数量后的数据情况。主要是来看删除字符前的阈值设置
# plotRemoved(docs, lower.thresh=seq(from = 10,to = 1000, by = 10))
# 
# ##pdf("stm-plot-removed.pdf")
# plotRemoved(docs, lower.thresh = seq(0, 20, by = 1))
# ##dev.off()


#out <- prepDocuments(docs, vocab, meta, lower.thresh = 1)
out <- prepDocuments(docs, vocab, meta)
docs <- out$documents
vocab <- out$vocab
meta <- out$meta


###选择最佳topic数目 semantic coherence and exclusivity

#storage <- searchK(out$documents,out$vocab, K = 5, prevalence = ~s(time)+label, data= meta)
topic_best <- data.frame(topic_num=6:40,sc=0:0,exc=0:0) #创建一个3列的空对象
topic_best1 <- data.frame(topic_num=3:5,sc=0:0,exc=0:0) #创建一个3列的空对象
for( tn in 1:3){
  a<-searchK(out$documents,out$vocab, K = (tn+2), prevalence = ~s(day)+s(label),max.em.its = 150,data= meta)
  topic_best1$sc[tn]<-a$results$semcoh
  topic_best1$exc[tn]<-a$results$exclus
}
write.xlsx(topic_best1, "topic_best2.xlsx") 


#绘图
topic_best<-read_excel(path = "./topic_best1.xlsx", sheet = "Sheet1", col_names = TRUE)
x<-unlist(topic_best$sc[1:38])
y<-unlist(topic_best$exc[1:38])
z<-unlist(topic_best$topic_num[1:38])

x<-data.frame(x)
y<-data.frame(y)
# z<-data.frame(z)
# z<-as.character(z)
z<-as.character(z)
z<-as.data.frame(z)
topic_data<-data.frame(x,y,z)

pdf("best_topic1.pdf")
par(family='SimSun') 
ggplot(topic_data, aes(x=x,y=y))+
  geom_text(aes(label=z),size=2)+
  xlab("Semantic Coherence") + ylab("Exclusivity")+
  geom_point(size=-1)+
  coord_fixed(ratio =20)
dev.off()



#3.3 estimate
#协变量两个：time+label
#time24*60=1440，要考虑自由度损失，引入spline function(分段多样式函数)进行样条曲线回归
#基础：stm=stm(out$document,out$vocab,4,init.type="LDA"
#init.type的选取
par(family='SimSun')
# prevalence 指的是主题偏好模型（topic prevalence model）指定的协变量； content 指的是词语偏好模型（topic content model）指定的协变量；由于时间 day 是连续变量，故而使用 spline 函数将其离散为十类；

HSRPrevFit <- stm(documents = out$documents, vocab = out$vocab, K = 10, prevalence = ~s(day)+s(label), data = out$meta, init.type = "Spectral")
# #HSRPrevFit <- stm(documents = out$documents, vocab = out$vocab, K = 23, prevalence = ~s(time)+label ,content =~ label, max.em.its = 75, data = out$meta, init.type = "Spectral")



##可视化主题
pdf("topic1.pdf")
par(family='SimSun') 
plot.STM( HSRPrevFit )
dev.off()

ts <- 1:HSRPrevFit$settings$dim$K
frequ <- colMeans(HSRPrevFit$theta[, ts])
sink("topic_fre1.txt", append=FALSE, split=TRUE)
print(frequ)
sink()


####8.22
##词云图，其中可以设置指定的topic编码，以及对应的词频数范围scale
pdf("cloud1.pdf")
par(family='SimSun') # 改字体, 否则不显示中文
cloud( HSRPrevFit,topic=1 )+title(sub="cloud")
# cloud(HSRPrevFit, topic = 1)+title(sub= "topic 1")
dev.off()


p1<-cloud(HSRPrevFit, topic = 1, scale = c(2,1))+title(sub= "topic 1")
p2<-cloud(HSRPrevFit, topic = 2, scale = c(2,0.5))+title(sub = "topic 2")
p3<-cloud(HSRPrevFit, topic = 3, scale = c(2,0.5))+title(sub = "topic 3")
p4<-cloud(HSRPrevFit, topic = 4, scale = c(2,0.5))+title(sub = "topic 4")
p5<-cloud(HSRPrevFit, topic = 5, scale = c(2,0.5))+title(sub = "topic 5")
p6<-cloud(HSRPrevFit, topic = 6, scale = c(2,0.5))+title(sub = "topic 6")
p7<-cloud(HSRPrevFit, topic = 7, scale = c(2,0.5))+title(sub = "topic 7")
p8<-cloud(HSRPrevFit, topic = 8, scale = c(2,0.5))+title(sub = "topic 8")
p9<-cloud(HSRPrevFit, topic = 9, scale = c(2,0.5))+title(sub = "topic 9")
p10<-cloud(HSRPrevFit, topic = 10, scale = c(2,0.5))+title(sub = "topic 10")
p11<-cloud(HSRPrevFit, topic = 11, scale = c(2,0.5))+title(sub = "topic 11")
p12<-cloud(HSRPrevFit, topic = 12, scale = c(2,0.5))+title(sub = "topic 12")
p13<-cloud(HSRPrevFit, topic = 13, scale = c(2,0.5))+title(sub = "topic 13")
p14<-cloud(HSRPrevFit, topic = 14, scale = c(2,0.5))+title(sub = "topic 14")
p15<-cloud(HSRPrevFit, topic = 15, scale = c(2,0.5))+title(sub = "topic 15")
p16<-cloud(HSRPrevFit, topic = 16, scale = c(2,0.5))+title(sub = "topic 16")
p17<-cloud(HSRPrevFit, topic = 17, scale = c(2,0.5))+title(sub = "topic 17")
pdf("cloud_topic.pdf")
par(family='SimSun') # 改字体, 否则不显示中文
multiplot(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,cols=3)
dev.off()
 


###为每个主题选择几个描述性的词
labelTopicsSel<-labelTopics( HSRPrevFit )
sink("labelTopics-selected1.txt", append=FALSE, split=TRUE)
print(labelTopicsSel)
sink()


findThoughts( HSRPrevFit ,texts=data$documents, topics=c(1,2,3,4,5,6,7,8,9,10), n=1)
# findThoughts( HSRPrevFit11 ,texts=data$documents, topics=c(1,2,3,4,5,6,7,8,9,10,11), n=1)
# how about more documents for more of these topics?
# shortdoc <- substr(out$meta$documents, 1, 200)
# thoughts6 <- findThoughts(HSRPrevFit, texts=shortdoc, n=1, topics=6)$docs[[1]]
# thoughts17 <- findThoughts(HSRPrevFit, texts=shortdoc, n=1, topics=17)$docs[[1]]


###为主题选择代表性的文档。
topicdocs <- read_excel(path = "./words.xlsx", sheet = "docs10", col_names = TRUE)

thoughts1<-topicdocs$content[1]
thoughts2<-topicdocs$content[2]
thoughts3<-topicdocs$content[3]
thoughts4<-topicdocs$content[4]
thoughts5<-topicdocs$content[5]
thoughts6<-topicdocs$content[6]
thoughts7<-topicdocs$content[7]
thoughts8<-topicdocs$content[8]
thoughts9<-topicdocs$content[9]
thoughts10<-topicdocs$content[10]
# thoughts11<-topicdocs$content[11]
pdf("stm-plot-find-thoughts1.pdf")
# mfrow=c(9, 1)将会把图输出到9行1列的表格中
par(mfrow = c(10, 1), mar = c(.5, .5, 1.5, .5))
par(family='SimSun') # 改字体, 否则不显示中文
plotQuote(thoughts1, width = 120, main = "Topic 1: failure, transfer, hot standby")
plotQuote(thoughts2, width=120, main="Topic 2: trip of the overhead lines")
plotQuote(thoughts3, width=120, main="Topic 3: body of the train, system of train")
plotQuote(thoughts4, width=120, main="Topic 4: TEDS, unauthorized persons")
plotQuote(thoughts5, width=120, main="Topic 5: ATP")
plotQuote(thoughts6, width=120, main="Topic 6: invasion of objects, natural disaster")
plotQuote(thoughts7, width=120, main="Topic 7: signal and communication equipment failures")
plotQuote(thoughts8, width=120, main="Topic 8: the foreign body in the overhead line system")
plotQuote(thoughts9, width=120, main="Topic 9: platform ")
plotQuote(thoughts10, width=120, main="Topic 10: block, urgent repair")
dev.off()


# ###评估协变量label的影响
# pdf("label.pdf")
# par(family='SimSun') # 改字体, 否则不显示中文
# plot.estimateEffect(prep,"label")
# plot(prep,covariate = "label", topics =c(1,2),  model = HSRPrevFit, cov.value1 =0,cov.value2 = 9, xlab ="Estimated Marginal Effect", main ="",  labeltype = "label", label.labels = c("",""))
# dev.off()
# # prep <- estimateEffect(c(1) ~ label, HSRPrevFit , data)#其中公式左侧是主题编号右侧是变量名
# # pdf("label.pdf")
# # plot.estimateEffect(prep,"label")
# # dev.off()

prep<-estimateEffect(1:10 ~ s(day)+s(label), HSRPrevFit,meta=out$meta, uncertainty = "Global")
summary(prep, topics=5)

###评估协变量day的影响
# pdf("time.pdf")
 p0<-plot.estimateEffect(prep,"day",model= HSRPrevFit,topics= c(1),method ="continuous",xlab = "Month",
                         xaxt='n',main='Topic 1 : failure, transfer, hot standby ',printlegend = FALSE)
 monthseq<-seq(from = as.Date("1970-01-01"), to = as.Date("1970-12-31"), by = "month")
 monthnames <- months(monthseq) 
 a<- month.abb[1:12]
 axis(1,at = as.numeric(monthseq) - min(as.numeric(monthseq)), labels = a)
 
 
 p1<-plot.estimateEffect(prep,"day",model= HSRPrevFit,topics= c(2),method ="continuous",xlab = "Month",
                         xaxt='n',main='Topic 2 : trip of the overhead lines ',printlegend = FALSE)
 axis(1,at = as.numeric(monthseq) - min(as.numeric(monthseq)), labels = a)
 
 
 p2<-plot.estimateEffect(prep,"day",model= HSRPrevFit,topics= c(3),method ="continuous",xlab = "Month",
                         xaxt='n',main='Topic 3 : body of the train, system of the train',printlegend = FALSE)
 axis(1,at = as.numeric(monthseq) - min(as.numeric(monthseq)), labels = a)
 
 
 p3<-plot.estimateEffect(prep,"day",model= HSRPrevFit,topics= c(4),method ="continuous",xlab = "Month",
                         xaxt='n',main='Topic 4 : TEDS, unauthorized persons',printlegend = FALSE)
 axis(1,at = as.numeric(monthseq) - min(as.numeric(monthseq)), labels = a)
 
 
 p4<-plot.estimateEffect(prep,"day",model= HSRPrevFit,topics= c(5),method ="continuous",xlab = "Month",
                         xaxt='n',main='Topic 5 : ATP',printlegend = FALSE)
 axis(1,at = as.numeric(monthseq) - min(as.numeric(monthseq)), labels = a)
 
 
 p5<-plot.estimateEffect(prep,"day",model= HSRPrevFit,topics= c(6),method ="continuous",xlab = "Month",
                         xaxt='n',main='Topic 6 : invasion of objects, natural disaster',printlegend = FALSE)
 axis(1,at = as.numeric(monthseq) - min(as.numeric(monthseq)), labels = a)
 
 
 p6<-plot.estimateEffect(prep,"day",model= HSRPrevFit,topics= c(7),method ="continuous",xlab = "Month",
                         xaxt='n',main='Topic 7 : signal and communication equipment failures',printlegend = FALSE)
 axis(1,at = as.numeric(monthseq) - min(as.numeric(monthseq)), labels = a)
 
 
 p7<-plot.estimateEffect(prep,"day",model= HSRPrevFit,topics= c(8),method ="continuous",xlab = "Month",
                         xaxt='n',main='Topic 8 : the foreign body in the overhead line system',printlegend = FALSE)
 axis(1,at = as.numeric(monthseq) - min(as.numeric(monthseq)), labels = a)
 
 
 p8<-plot.estimateEffect(prep,"day",model= HSRPrevFit,topics= c(9),method ="continuous",xlab = "Month",
                         xaxt='n',main='Topic 9 : platform',printlegend = FALSE)
 axis(1,at = as.numeric(monthseq) - min(as.numeric(monthseq)), labels = a)
 
 
 p9<-plot.estimateEffect(prep,"day",model= HSRPrevFit,topics= c(10),method ="continuous",xlab = "Month",
                         xaxt='n',main='Topic 10 : block, urgent repair',printlegend = FALSE)
 axis(1,at = as.numeric(monthseq) - min(as.numeric(monthseq)), labels = a)

 
###主题相关性分析
pdf("topic_coherence1.pdf")
HSRPrevFitc=topicCorr( HSRPrevFit )
plot.topicCorr(HSRPrevFitc)
dev.off()
##热力图
reli<-HSRPrevFitc$cor
relitu<-reshape2::melt(reli)
## import my theme for ggplot 
mytheme=theme_classic()+
  theme(axis.text.x = element_text( hjust = 0.5, vjust = 0.5,
                                    size=rel(1.25)),
        axis.text.y = element_text( hjust = 0.5, vjust = 0.5,
                                    size=rel(1.25)),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        axis.line = element_blank(),
        plot.title=element_text(size=rel(1.5),hjust = 0.5),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()
  ) 

pdf("heatmap1.pdf")
ggplot(relitu, aes(x=Var2, y=Var1, fill=value))+
  geom_tile(colour= "white",linewidth=1,width=0.9,height=.9)+
  ggtitle("Topic Correlations")+mytheme+
  scale_fill_gradient(low = "#FFFDE4", high = "#005AA7")+
  scale_x_continuous(breaks=seq(1, 11, 1))+   
  scale_y_continuous(breaks=seq(1, 11, 1))+
  xlab("topic")+
  ylab("topic")+
  coord_fixed(ratio =0.8)
dev.off()



##两个主题的比较6-10
cloud( HSRPrevFit,topic=2 )+title(sub="cloud")
cloud( HSRPrevFit,topic=1 )+title(sub="cloud")
pdf("topic_compare1.pdf")
par(family='SimSun') # 改字体, 否则不显示中文
plot(HSRPrevFit, type = "perspectives",topics = c(6,2))
dev.off()


##输出每个主题最相关的十个文档
findThoughts( HSRPrevFit ,texts=data$documents, topics=c(1,2,3,4,5,6,7,8,9,10), n=10)

#可视化
stmBrowser(HSRPrevFit, out$meta, c("day","label"), "documents")
