#Начнем анализ данных(start data analysis)
#откроем нашу таблицу из wireshark, предваритально установим рабочую директорию(open wireshark file as a table, but before set a working directory)
setwd("~/Desktop")
table<-read.csv("shark", header=TRUE, sep=",")
#уберем лишние столбцы(No., Time, Length, Info)(delete unimportant columns)
newtable<-table[,3:5]
#удалим из памяти table( delete from memory)
rm(table)
#создадим переменные с уникальными значениями из колонн Source и Destination, Protocol (create lists with unique varies from "Source", "Destination", "Protocol" columns)
Dest<-as.character(unique(newtable$Destination))
Sour<-as.character(unique(newtable$Source))
Prot<-as.character(unique(newtable$Protocol))
#надо теперь правильно построить таблицу (build a table correct)
#но перед этим в newtable сделаем тип данных во всех столбцах character (make data in newtable as character type)
newtable$Source<-as.character(newtable$Source)
newtable$Destination<-as.character(newtable$Destination)
newtable$Protocol<-as.character(newtable$Protocol)
#создадим таблицу finaltable(create a finaltable)
#столбцы позже будут вида || IPs | CountS | IPd | CountD || (columns will be like || IPs | CountS | IPd | CountD || )
finaltable<-data.frame(Prot, IPs=1:length(Prot),CountS=1:length(Prot), IPd=1:length(Prot), CountD=1:length(Prot))
#заполним таблицу(wire data to table)
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


#удалим ненужные переменные(clear a memory)
rm(newtable,countd,countdd,counts,countss,d,Dest,i,index,IPs,l,m,Prot,Sour,t)
#сохраним таблицу(save a table)
write.csv(finaltable, file="RESULT.csv")

