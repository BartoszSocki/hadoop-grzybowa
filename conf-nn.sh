#!/bin/sh

ssh-copy-id -i ~/.ssh/id_rsa.pub root@nn1
ssh-copy-id -i ~/.ssh/id_rsa.pub root@dn1

hadoop/bin/hdfs namenode -format
hadoop/sbin/start-dfs.sh

jps
