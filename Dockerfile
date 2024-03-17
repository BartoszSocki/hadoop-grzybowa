FROM ubuntu:20.04

# WORKDIR /root
WORKDIR /home/hadoop

# config
RUN apt-get update
RUN apt-get install openjdk-8-jdk -y
RUN apt-get install vim -y
RUN apt-get install wget -y
RUN apt-get install openssh-client -y
RUN apt-get install inetutils-ping -y
RUN apt-get install iproute2 -y
RUN apt-get install openssh-server -y

# hadoop
RUN /usr/bin/bash -c 'wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6-aarch64.tar.gz'
RUN tar -xzvf hadoop-3.3.6-aarch64.tar.gz
RUN ln -s hadoop-3.3.6 hadoop

RUN apt-get install sudo -y

RUN echo 'export HADOOP_HOME=/home/hadoop/hadoop' >> ~/.bashrc
RUN echo 'PATH=$HADOOP_HOME:$HADOOP_HOME/bin:$PATH' >> ~/.bashrc
RUN echo 'export PATH' >> ~/.bashrc
RUN /usr/bin/bash -c 'source ~/.bashrc'

RUN echo 'export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")' >> hadoop/etc/hadoop/hadoop-env.sh
COPY ./core-site.xml hadoop/etc/hadoop/
COPY ./hdfs-site.xml hadoop/etc/hadoop/
COPY ./mapred-site.xml hadoop/etc/hadoop/
COPY ./yarn-site.xml hadoop/etc/hadoop/
COPY ./workers hadoop/etc/hadoop/

RUN echo 'export HADOOP_HOME="/home/hadoop/hadoop"' >> ~/.bashrc
RUN echo 'export PATH=$PATH:$HADOOP_HOME/bin' >> ~/.bashrc
RUN echo 'export PATH=$PATH:$HADOOP_HOME/sbin' >> ~/.bashrc
RUN echo 'export HADOOP_MAPRED_HOME=${HADOOP_HOME}' >> ~/.bashrc
RUN echo 'export HADOOP_COMMON_HOME=${HADOOP_HOME}' >> ~/.bashrc
RUN echo 'export HADOOP_HDFS_HOME=${HADOOP_HOME}' >> ~/.bashrc
RUN echo 'export YARN_HOME=${HADOOP_HOME}' >> ~/.bashrc
RUN echo 'export PDSH_RCMD_TYPE=ssh' >> ~/.bashrc
RUN echo 'export YARN_RESOURCEMANAGER_USER=root' >> ~/.bashrc
RUN echo 'export YARN_NODEMANAGER_USER=root' >> ~/.bashrc
RUN /usr/bin/bash -c 'source ~/.bashrc'

RUN echo 'export HDFS_NAMENODE_USER=root' >> ~/.bashrc
RUN echo 'export HDFS_DATANODE_USER=root' >> ~/.bashrc
RUN echo 'export HDFS_SECONDARYNAMENODE_USER=root' >> ~/.bashrc
RUN mkdir -p /home/hadoop/data/nameNode
RUN mkdir -p /home/hadoop/data/dataNode

# EXPOSE 22
# EXPOSE 8000-10000

COPY ./conf-nn.sh .
COPY ./conf-dn.sh .
COPY ./conf-ssh.sh .

CMD ["/usr/bin/bash"]

