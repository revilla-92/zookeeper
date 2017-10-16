mkdir /tmp/CNVR
mkdir /tmp/CNVR/z1
mkdir /tmp/CNVR/z2
mkdir /tmp/CNVR/z3

cd /tmp/CNVR
git clone https://github.com/revilla-92/zookeeper.git

cd zookeeper
tar xvf zookeeper-3.4.10.tar.gz

mv zookeeper-3.4.10 /tmp/CNVR
mv localhost_zoo1.cfg /tmp/CNVR/zookeeper-3.4.10/conf
mv localhost_zoo2.cfg /tmp/CNVR/zookeeper-3.4.10/conf
mv localhost_zoo3.cfg /tmp/CNVR/zookeeper-3.4.10/conf

cd ..
rm -rf zookeeper

echo 1 > z1/myid
echo 2 > z2/myid
echo 3 > z3/myid

cd zookeeper-3.4.10

export CLASSPATH=$CLASSPATH:/tmp/CNVR/zookeeper-3.4.10/zookeeper-3.4.10.jar
export CLASSPATH=$CLASSPATH:/tmp/CNVR/zookeeper-3.4.10/lib/*

ln -sf /opt/Oracle/jdk1.8 java_home

chmod 711 /tmp/CNVR/zookeeper-3.4.10/bin/*.sh

# En tres terminales distintas ejecutar los comandos:
# bin/zkServer.sh start conf/localhost_zoo1.cfg 
# bin/zkServer.sh start conf/localhost_zoo2.cfg
# bin/zkServer.sh start conf/localhost_zoo3.cfg 

# Con sus respectivos status:
# bin/zkServer.sh status conf/localhost_zoo1.cfg 
# bin/zkServer.sh status conf/localhost_zoo2.cfg
# bin/zkServer.sh status conf/localhost_zoo3.cfg 

# Con sus respectivos CLI (Command Line Interface):
# bin/zkCli.sh -server localhost:2181
# bin/zkCli.sh -server localhost:2182
# bin/zkCli.sh -server localhost:2183