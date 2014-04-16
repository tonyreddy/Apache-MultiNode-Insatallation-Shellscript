#!/bin/bash
tar xzf hadoop-2.2.0.tar.gz
mv hadoop-2.2.0 hadoop 
master=$( cat master )
cat pas.txt | sudo -S cp -r host /etc/hosts
cat pas.txt | sudo -S mkdir /usr/local/had
cat pas.txt | sudo -S mkdir /hadoop
cat pas.txt | sudo -S chown $USER:$GROUP /usr/local/had
cat pas.txt | sudo -S chown $USER:$GROUP /hadoop
sed 's/echo\ "This script is Deprecated. Instead use start-dfs.sh and mr-jobhistory-daemon.sh"/#echo\ "This script is Deprecated. Instead use start-dfs.sh and mr-jobhistory-daemon.sh"/g' hadoop/sbin/start-all.sh -i
echo 'if [ -f "${YARN_HOME}"/sbin/mr-jobhistory-daemon.sh ]; then' >> hadoop/sbin/start-all.sh
echo  '"${YARN_HOME}"/sbin/mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR start historyserver' >> hadoop/sbin/start-all.sh
echo 'fi' >> hadoop/sbin/start-all.sh
sed 's/echo\ "This script is Deprecated. Instead use stop-dfs.sh and stop-yarn.sh"/#echo\ "This script is Deprecated. Instead use stop-dfs.sh and stop-yarn.sh"/g' hadoop/sbin/stop-all.sh -i
echo 'if [ -f "${YARN_HOME}"/sbin/mr-jobhistory-daemon.sh ]; then' >> hadoop/sbin/stop-all.sh
echo  '"${YARN_HOME}"/sbin/mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR stop historyserver' >> hadoop/sbin/stop-all.sh
echo 'fi' >> hadoop/sbin/stop-all.sh
sed "s/<\/configuration>/<property>\n<name>fs.default.name<\/name>\n<value>hdfs:\/\/$master:8020<\/value>\n<\/property>\n<property>\n<name>hadoop.tmp.dir<\/name>\n<value>\/hadoop\/datastore-hadoop<\/value>\n<\/property>\n<\/configuration>/g" -i.bak hadoop/etc/hadoop/core-site.xml
cp hadoop/etc/hadoop/mapred-site.xml.template hadoop/etc/hadoop/mapred-site.xml
sed "s/<\/configuration>/<property>\n<name>mapreduce.framework.name<\/name>\n<value>yarn<\/value>\n<\/property>\n<\/configuration>/g" -i.bak hadoop/etc/hadoop/mapred-site.xml
sed "s/<\/configuration>/<property>\n<name>dfs.replication<\/name>\n<value>1<\/value>\n<\/property>\n<property>\n<name>dfs.permissions<\/name>\n<value>false<\/value>\n<\/property>\n<!-- Immediately exit safemode as soon as one DataNode checks in. On a multi-node cluster, these configurations must be removed.-->\n<property>\n<name>dfs.safemode.extension<\/name>\n<value>0<\/value>\n<\/property>\n<property>\n<name>dfs.safemode.min.datanodes<\/name>\n<value>1<\/value>\n<\/property>\n<\/configuration>/g" -i.bak hadoop/etc/hadoop/hdfs-site.xml
sed "s/<\/configuration>/<property>\n<name>yarn.resourcemanager.resource-tracker.address<\/name>\n<value>$master:8031<\/value>\n<\/property>\n<property>\n<name>yarn.resourcemanager.address<\/name>\n<value>$master:8032<\/value>\n<\/property>\n<property>\n<name>yarn.resourcemanager.scheduler.address<\/name>\n<value>$master:8030<\/value>\n<\/property>\n<property>\n<name>yarn.resourcemanager.admin.address<\/name>\n<value>$master:8033<\/value>\n<\/property>\n<property>\n<name>yarn.resourcemanager.webapp.address<\/name>\n<value>$master:8088<\/value>\n<\/property>\n<property>\n<name>yarn.nodemanager.aux-services<\/name>\n<value>mapreduce.shuffle<\/value>\n<\/property>\n<property>\n<name>yarn.nodemanager.aux-services.mapreduce_shuffle.class<\/name>\n<value>org.apache.hadoop.mapred.ShuffleHandler<\/value>\n<\/property>\n<\/configuration>/g" -i.bak hadoop/etc/hadoop/yarn-site.xml
sed 's/\/etc\/hadoop/\/usr\/local\/had\/hadoop\/etc\/hadoop/g' hadoop/etc/hadoop/hadoop-env.sh -i
echo 'export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true' >> hadoop/etc/hadoop/hadoop-env.sh
cat slave > hadoop/etc/hadoop/slaves
cp -r hadoop /usr/local/had
rm -rf hadoop slave master
