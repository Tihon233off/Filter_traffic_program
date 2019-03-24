#Начнем анализ данных
#откроем нашу таблицу из wireshark, предваритально установим рабочую директорию
setwd("~/Desktop")
table<-read.csv("shark", header=TRUE, sep=",")
#уберем лишние столбцы(No., Time, Length, Info)
newtable<-table[,3:5]
#удалим из памяти table
rm(table)
#создадим переменные с уникальными значениями из колонн Source и Destination, Protocol
Dest<-as.character(unique(newtable$Destination))
Sour<-as.character(unique(newtable$Source))
Prot<-as.character(unique(newtable$Protocol))
#надо теперь правильно построить таблицу
#но перед этим в newtable сделаем тип данных во всех столбцах character
newtable$Source<-as.character(newtable$Source)
newtable$Destination<-as.character(newtable$Destination)
newtable$Protocol<-as.character(newtable$Protocol)
#создадим таблицу finaltable
#столбцы позже будут вида || IPs | CountS | IPd | CountD ||
finaltable<-data.frame(Prot, IPs=1:length(Prot),CountS=1:length(Prot), IPd=1:length(Prot), CountD=1:length(Prot))
#заполним таблицу
countdd=0
countd=0
for(i in 1:length(Prot))
{
  for(m in 1:length(Dest))
  { 
    for (t in 1:length(newtable$Protocol))
    {
      if (Dest[m]==newtable$Destination[t]&Prot[i]==newtable$Protocol[t])
      {
        countd=countd+1
      }
    }
    if(countd>countdd)
    {
      index=m
      countdd=countd
      d=countd
    }
    
    countd=0
  }
  countdd=0
  finaltable$IPd[i]<-Dest[index]
  finaltable$CountD[i]<-d
  print(Prot[i])
  print(Dest[index])
  print(d)
  print("______")
  index=0
}
countss=0
counts=0
for(i in 1:length(Prot))
{
  for(m in 1:length(Sour))
  { 
    for (t in 1:length(newtable$Protocol))
    {
      if (Sour[m]==newtable$Source[t]&Prot[i]==newtable$Protocol[t])
      {
        counts=counts+1
      }
    }
    if(counts>countss)
    {
      index=m
      countss=counts
      d=counts
    }
      counts=0
  }
  countss=0
    print(Prot[i])
    print(Sour[index])
    print(d)
    print("______")
  finaltable$IPs[i]<-Sour[index]
  finaltable$CountS[i]<-d
  
  index=0
}


#удалим ненужные переменные
rm(newtable,countd,countdd,counts,countss,d,Dest,i,index,IPs,l,m,Prot,Sour,t)
#сохраним таблицу
write.csv(finaltable, file="RESULT.csv")

