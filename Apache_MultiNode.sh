#!/bin/bash
echo "Enter MasterNode ipaddress space hostname::"$cond 
read cond
echo $cond > master
echo "Enter Datanode cluster number::"$cond1
read cond1
echo "Enter Sudo User Password::"$cond3
read cond3
if [  -z "$cond3" ]
then
echo Your password file configuration successfully skiped..................
else 
echo "$cond3" > pas.txt
echo Your password file configuration successfully finced..................
fi
for ((i=1; i<=$cond1; i++)); 
do
echo "Enter Datanode ipaddress space hostname::"$cond2
read cond2
echo $cond2 >> datanode
done
cat master > host
cat datanode >> host
awk '!x[$0]++' host > hos
mv hos host
cat pas.txt | sudo -S cp -r host /etc/hosts
echo cp
wget http://archive.apache.org/dist/hadoop/common/stable/hadoop-2.2.0.tar.gz 
a=$( cat 1 )
for ((i=1; i<=$cond1; i++));
do
cut -d' ' -f1 datanode > slv
sl=$( sed -n "$i"p slv )
echo $sl
cut -d' ' -f2 datanode > slave
echo "$cond3" > pas.txt
echo $cond > master
scp -r host $sl:~
scp -r pas.txt $sl:~
scp -r master $sl:~
scp -r slave $sl:~
scp -r Slave_isnt.sh $sl:~
scp -r hadoop-2.2.0.tar.gz  $sl:~
ssh $sl sh Slave_isnt.sh
done
bash Slave_isnt.sh
