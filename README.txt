Apache-MultiNode-Insatallation-Shellscript
==========================================

Apache Hadoop MultiNode Insatallation Shellscript

Yarn version MultiNode Installation Shell script

Pleace download this two script of Apache_MultiNode.sh and Slave_Install.sh.

Just do before start run the script run this commands in namenode bellow:

ssh-keygen -t rsa
ssh-copy-id -i  ~/.ssh/id_rsa.pub $USER@tony.com
ssh-copy-id -i  ~/.ssh/id_rsa.pub $USER@tony1.com
ssh-copy-id -i  ~/.ssh/id_rsa.pub $USER@tony2.com


And type Bellow command in your ubuntu michine:

bash Multinode_Install.sh

Then it will ask NameNode ip address and hostname of NameNode give to example of bellow given type:

192.168.0.1 tony.com

Then it will ask number of DataNode You want to install in Your cluster give to example of bellow given type:
3

Then it will ask DataNode ip address and hostname of DataNodes give to example of bellow given type:
Note if you want to use NameNode as a DataNode give NameNode ipaddress and hostname include DataNode ipaddress and hostname:
192.168.0.1 tony.com
192.168.0.2 tony1.com
192.168.0.3 tony2.com

Set the environment path and hadoop home in /etc/environment
In path : /usr/local/had/hadoop/bin:/usr/local/hadoop/sbin
HADOOP_HOME="/usr/local/had/hadoop"


If hav any problem send mail to tony.ntw@gmail.com
